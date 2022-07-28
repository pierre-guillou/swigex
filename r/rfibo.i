%module(directors="1") myfibo

// Note : Keep order in this file!

//////////////////////////////////////////////////////////////
//       Specific typemaps and fragments for R language     //
//////////////////////////////////////////////////////////////

%fragment("ToCpp", "header")
{

  template <typename Type> int convertToCpp(SEXP obj, Type& value);
  
  template <> int convertToCpp(SEXP obj, int& value)
  {
    // TODO : Handle undefined or NA values
    return SWIG_AsVal_int(obj, &value);
  }
  template <> int convertToCpp(SEXP obj, double& value)
  {
    // TODO : Handle undefined or NA values
    return SWIG_AsVal_double(obj, &value);
  }
  template <> int convertToCpp(SEXP obj, String& value)
  {
    return SWIG_AsVal_std_string(obj, &value);
  }

  // Certainly not the most efficient way to convert vectors.
  // But at least, I can test each value for particular NAs
  SEXP getElem(SEXP obj, int i)
  {
    if (Rf_isInteger(obj))     return Rf_ScalarInteger(INTEGER(obj)[i]);
    if (Rf_isReal(obj))        return Rf_ScalarReal(REAL(obj)[i]);
    if (Rf_isString(obj))      return Rf_ScalarString(STRING_ELT(obj, i));
    if (TYPEOF(obj) == VECSXP) return VECTOR_ELT(obj, i);
    return SEXP();
  }
  
  template <typename Vector>
  int vectorToCpp(SEXP obj, Vector& vec)
  {
    // Type definitions
    using ValueType = typename Vector::value_type;
    
    // Conversion
    vec.clear();
    int myres = SWIG_OK;
    int size = (int)Rf_length(obj);
    if (size < 0)
    {
      // Not a vector
      ValueType value;
      // Try to convert
      myres = convertToCpp(obj, value);
      if (SWIG_IsOK(myres))
        vec.push_back(value);
    }
    else if (size > 0)
    {
      // Real vector
      vec.reserve(size);
      for (int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        SEXP item = getElem(obj,i);
        ValueType value;
        myres = convertToCpp(item, value);
        if (SWIG_IsOK(myres))
          vec.push_back(value);
      }
    }
    return myres;
  }
  
  template <typename VectorVector>
  int vectorVectorToCpp(SEXP obj, VectorVector& vvec)
  {
    // Type definitions
    using InputVector = typename VectorVector::value_type;
    
    // Conversion
    int myres = SWIG_OK;
    int size = (int)Rf_length(obj);
    if (size <= 1)
    {
      // Not a vector (or a single value)
      InputVector vec;
      // Try to convert
      myres = vectorToCpp(obj, vec);
      if (SWIG_IsOK(myres))
        vvec.push_back(vec);
    }
    else if (size > 1)
    {
      for (int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        SEXP item = getElem(obj,i);
        InputVector vec;
        myres = vectorToCpp(item, vec);
        if (SWIG_IsOK(myres))
          vvec.push_back(vec);
      }
    }
    return myres;
  }
}

// Add numerical vector typecheck typemaps for dispatching functions
%typemap(rtypecheck) const VectorInt&,    VectorInt,
                     const VectorDouble&, VectorDouble
{
  is.numeric($arg) && length($arg) >= 1
}

// Add string vector typecheck typemaps for dispatching functions
%typemap(rtypecheck) const VectorString&, VectorString
{
  is.character($arg) && length($arg) >= 1
}

%fragment("FromCpp", "header")
{
  template <typename Vector>
  int vectorFromCpp(SEXP* obj, const Vector& vec)
  {
    *obj = swig::from(vec.getVector());
    return (*obj) == NULL ? -1 : 0;
  }

  template <typename VectorVector>
  int vectorVectorFromCpp(SEXP* obj, const VectorVector& vec)
  {
    int myres = SWIG_TypeError;
    // https://cpp.hotexamples.com/examples/-/-/Rf_allocVector/cpp-rf_allocvector-function-examples.html
    const unsigned int size = vec.size();
    PROTECT(*obj = Rf_allocVector(VECSXP, size));
    if(*obj != NULL)
    {
      myres = SWIG_OK;
      for(unsigned int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        SEXP rvec;
        myres = vectorFromCpp(&rvec, vec.at(i));
        if (SWIG_IsOK(myres))
          SET_VECTOR_ELT(*obj, i, rvec);
      }
    }
    UNPROTECT(1);
    return myres;
  }
}

%typemap(scoerceout) int,    int*,    int&,
                     double, double*, double&
 %{    %}

%typemap(scoerceout) VectorInt,    VectorInt*,    VectorInt&,
                     VectorDouble, VectorDouble*, VectorDouble&,
                     VectorString, VectorString*, VectorString&
 %{    %}

%typemap(scoerceout) VectorVectorInt,    VectorVectorInt*,    VectorVectorInt&,
                     VectorVectorDouble, VectorVectorDouble*, VectorVectorDouble&
 %{    %}

//////////////////////////////////////////////////////////////
//         C++ library SWIG includes and typemaps           //
//////////////////////////////////////////////////////////////

%include ../swig/swig_inc.i

//////////////////////////////////////////////////////////////
//                C++ library SWIG interface                //
//////////////////////////////////////////////////////////////

%include ../swig/swig_exp.i

//////////////////////////////////////////////////////////////
//                    Add C++ extension                     //
//////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
//       Add target language additional features below      //
//////////////////////////////////////////////////////////////

// TODO : Redirection of std::cout for windows RGui.exe users

// Make VectorXXX R class indicable [1-based index]

%insert(s)
%{

"getitem" <-
function(x, i)
{
  idx = as.integer(i)
  sapply(idx, function(n) {
    if (n < 1 || n > x$length())
      stop("Index out of range")
    x$get(n-1)
  })
}
"setitem" <-
function(x, i, value)
{
  idx = as.integer(i)
  sapply(1:length(i), function(n) {
    if (i[n] < 1 || i[n] > x$length())
      stop("Index out of range")
    x$set(i[n]-1, value[n])
  })
  x
}

setMethod('[',   '_p_VectorNumTT_int_t',               getitem)
setMethod('[<-', '_p_VectorNumTT_int_t',               setitem)
setMethod('[',   '_p_VectorNumTT_double_t',            getitem)
setMethod('[<-', '_p_VectorNumTT_double_t',            setitem)
setMethod('[',   '_p_VectorTT_std__string_t',          getitem)
setMethod('[<-', '_p_VectorTT_std__string_t',          setitem)
setMethod('[',   '_p_VectorTT_VectorNumTT_int_t_t',    getitem) # TODO : VectorVectorXXX getitem doesn't work yet
setMethod('[<-', '_p_VectorTT_VectorNumTT_int_t_t',    setitem) # TODO : VectorVectorXXX setitem doesn't work yet
setMethod('[',   '_p_VectorTT_VectorNumTT_double_t_t', getitem) # TODO : VectorVectorXXX getitem doesn't work yet
setMethod('[<-', '_p_VectorTT_VectorNumTT_double_t_t', setitem) # TODO : VectorVectorXXX setitem doesn't work yet

%}