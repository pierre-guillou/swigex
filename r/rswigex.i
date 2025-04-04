%module(directors="1") swigex

// Note : Keep order in this file!

//   Ignore functions that are not exportable with SWIG     //
//////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
//       Specific typemaps and fragments for R language     //
//////////////////////////////////////////////////////////////

%begin %{
// For isnan
#include <cmath>
// For isinf
#include <math.h>
// For cout
#include <iostream>
%}

%fragment("ToCpp", "header")
{
  template <typename Type> int convertToCpp(SEXP obj, Type& value);
  
  template <> int convertToCpp(SEXP obj, int& value)
  {
    // Test argument
    if (obj == NULL) return SWIG_TypeError;

    int myres = SWIG_TypeError;
    if (Rf_length(obj) > 0) // Prevent NULL value from becoming NA
    {
      myres = SWIG_AsVal_int(obj, &value);
      //std::cout << "convertToCpp(int): value=" << value << std::endl;
      if (SWIG_IsOK(myres) && value == R_NaInt) // NA, NaN, Inf or out of bounds value becomes NA
        value = getNA<int>();
    }
    return myres;
  }
  template <> int convertToCpp(SEXP obj, double& value)
  {
    // Test argument
    if (obj == NULL) return SWIG_TypeError;
      
    int myres = SWIG_TypeError;
    if (Rf_length(obj) > 0) // Prevent NULL value from becoming NA
    {
       myres = SWIG_AsVal_double(obj, &value);
      //std::cout << "convertToCpp(double): value=" << value << std::endl;
      if (SWIG_IsOK(myres) && !R_finite(value)) // NA, NaN, Inf or out of bounds value becomes NA
        value = getNA<double>();
    }
    return myres; 
  }
  template <> int convertToCpp(SEXP obj, String& value)
  {
    // Test argument
    if (obj == NULL) return SWIG_TypeError;
      
    int myres = SWIG_TypeError;
    if (Rf_length(obj) > 0) // Prevent NULL value from being accepted
    {
      myres = SWIG_AsVal_std_string(obj, &value);
      //std::cout << "convertToCpp(String): value=" << value << std::endl;
      // No undefined
    }
    return myres;
  }
  // Certainly not the most efficient way to convert vectors,
  // but at least, I can test each value for particular NAs
  SEXP getElem(SEXP obj, int i)
  {
    if (Rf_isInteger(obj))      return Rf_ScalarInteger(INTEGER(obj)[i]);
    if (Rf_isReal(obj))         return Rf_ScalarReal(REAL(obj)[i]);
    if (Rf_isString(obj))       return Rf_ScalarString(STRING_ELT(obj, i));
    if (TYPEOF(obj) == VECSXP)  return VECTOR_ELT(obj, i);
    return SEXP();
  }
  
  template <typename Vector>
  int vectorToCpp(SEXP obj, Vector& vec)
  {
    // Type definitions
    using ValueType = typename Vector::value_type;
    vec.clear();
    
    // Test argument
    if (obj == NULL) return SWIG_TypeError;
    if (TYPEOF(obj) == EXTPTRSXP) return SWIG_TypeError;

    // Conversion
    int myres = SWIG_OK;
    int size = (int)Rf_length(obj);
    if (size > 0)
    {
      // Real vector
      vec.reserve(size);
      for (int i = 0; i < size && SWIG_IsOK(myres); i++)
      {
        SEXP item = getElem(obj,i); // item could be NULL or NIL
        if (TYPEOF(item) == NILSXP) continue; // If NIL, no error
        ValueType value;
        myres = convertToCpp(item, value);
        if (SWIG_IsOK(myres))
          vec.push_back(value);
      }
    }
    // else length = 0, empty vector
    return myres;
  }

  template <typename VectorVector>
  int vectorVectorToCpp(SEXP obj, VectorVector& vvec)
  {
    // Type definitions
    using InputVector = typename VectorVector::value_type;
    vvec.clear();
    
    // Test argument
    if (obj == NULL) return SWIG_TypeError;
    if (TYPEOF(obj) == EXTPTRSXP) return SWIG_TypeError;

    // Conversion
    int myres = SWIG_OK;
    int size = (int)Rf_length(obj);
    if (size == 1)
    {
      InputVector vec;
      SEXP item = getElem(obj,0);
      // Try to convert
      if (TYPEOF(item) == NILSXP) 
        myres = vectorToCpp(obj, vec);
      else
        myres = vectorToCpp(item, vec);
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
    // else length = 0, empty vector
    return myres;
  }
}

// Add typecheck typemaps for dispatching functions
%typemap(rtypecheck, noblock=1) const int&, int                               { length($arg) == 1 && (is.integer(unlist($arg)) || is.numeric(unlist($arg))) }
%typemap(rtypecheck, noblock=1) const double&, double                         { length($arg) == 1 &&  is.numeric(unlist($arg)) }
%typemap(rtypecheck, noblock=1) const String&, String                         { length($arg) == 1 &&  is.character(unlist($arg)) }
%typemap(rtypecheck, noblock=1) const VectorInt&, VectorInt                   { length($arg) == 0 || (length($arg) > 0 && (is.integer(unlist($arg)) || is.numeric(unlist($arg)))) }
%typemap(rtypecheck, noblock=1) const VectorDouble&, VectorDouble             { length($arg) == 0 || (length($arg) > 0 &&  is.numeric(unlist($arg))) }
%typemap(rtypecheck, noblock=1) const VectorString&, VectorString             { length($arg) == 0 || (length($arg) > 0 &&  is.character(unlist($arg))) }
%typemap(rtypecheck, noblock=1) const VectorVectorInt&, VectorVectorInt       { length($arg) == 0 || (length($arg) > 0 && 
                                                                               (length($arg[[1]]) == 0 || (length($arg[[1]]) > 0 && (is.integer(unlist($arg[[1]])) || is.numeric(unlist($arg[[1]])))))) }
%typemap(rtypecheck, noblock=1) const VectorVectorDouble&, VectorVectorDouble { length($arg) == 0 || (length($arg) > 0 && 
                                                                               (length($arg[[1]]) == 0 || (length($arg[[1]]) > 0 && is.numeric(unlist($arg[[1]]))))) }

%fragment("FromCpp", "header")
{  
  template <typename InputType> struct OutTraits;
  template <> struct OutTraits<int>     { using OutputType = int; };
  template <> struct OutTraits<double>  { using OutputType = double; };
  template <> struct OutTraits<String>  { using OutputType = String; };
  
  template <typename Type> typename OutTraits<Type>::OutputType convertFromCpp(const Type& value);
  template <> int convertFromCpp(const int& value)
  {
    //std::cout << "convertFromCpp(int): value=" << value << std::endl;
    if (isNA<int>(value))
      return R_NaInt;
    return value;
  }
  template <> double convertFromCpp(const double& value)
  {
    //std::cout << "convertFromCpp(double): value=" << value << std::endl;
    if (isNA<double>(value))
      return R_NaReal;
    return value;
  }
  template <> String convertFromCpp(const String& value)
  {
    //std::cout << "convertFromCpp(String): value=" << value << std::endl;
    return value; // No special conversion provided
  }
  
  template <typename Type> SEXP objectFromCpp(const Type& value);
  template <> SEXP objectFromCpp(const int& value)
  {
    return Rf_ScalarInteger(convertFromCpp(value));
  }
  template <> SEXP objectFromCpp(const double& value)
  {
    return Rf_ScalarReal(convertFromCpp(value));
  }
  template <> SEXP objectFromCpp(const String& value)
  {
    return Rf_ScalarString(Rf_mkChar(convertFromCpp(value).c_str()));
  }
  
  template <typename Vector>
  int vectorFromCpp(SEXP* obj, const Vector& vec)
  {
    // Type definitions
    int myres = SWIG_TypeError;
    using SizeType = typename Vector::size_type;
 
    // Test NA values
    auto vec2 = vec.getVector();
    SizeType size = vec2.size();
    for(SizeType i = 0; i < size; i++)
    {
      vec2[i] = convertFromCpp(vec2[i]);
    }
    // Convert to R vector
    *obj = swig::from(vec2);
    myres = (*obj) == NULL ? SWIG_TypeError : SWIG_OK;
    return myres;
  }

  template <typename VectorVector>
  int vectorVectorFromCpp(SEXP* obj, const VectorVector& vec)
  {
    // Type definitions
    int myres = SWIG_TypeError;
    using SizeType = typename VectorVector::size_type;

    // https://cpp.hotexamples.com/examples/-/-/Rf_allocVector/cpp-rf_allocvector-function-examples.html
    SizeType size = vec.size();
    PROTECT(*obj = Rf_allocVector(VECSXP, size));
    if(*obj != NULL)
    {
      myres = SWIG_OK;
      for(SizeType i = 0; i < size && SWIG_IsOK(myres); i++)
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

// This for automatically convert R lists to externalptr
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
// TODO : Add a fix for inheritance problem: https://github.com/gstlearn/gstlearn/issues/308

%insert(s)
%{

##
## Add operator [] to VectorXXX R class [1-based index]
## ---------------------------------------------------- ##

"getVitem" <-
function(x, i)
{
  idx = as.integer(i)
  if (length(idx) > 1) {
    sapply(idx, function(n) {
      if (n < 1 || n > x$length())
        stop("Index out of range")
      x$getAt(n-1)
    }) 
  }
  else {
    x$getAt(idx-1)
  }
}

"setVitem" <-
function(x, i, value)
{
  idx = as.integer(i)
  if (length(idx) > 1) {
    sapply(1:length(i), function(n) {
      if (i[n] < 1 || i[n] > x$length())
        stop("Index out of range")
      x$setAt(i[n]-1, value[n])
    })
  }
  else {
    x$setAt(idx-1, value)
  }
  x
}

setMethod('[',    '_p_VectorTT_int_t',                  getVitem)
setMethod('[<-',  '_p_VectorTT_int_t',                  setVitem)
setMethod('[',    '_p_VectorTT_double_t',               getVitem)
setMethod('[<-',  '_p_VectorTT_double_t',               setVitem)
setMethod('[',    '_p_VectorTT_String_t',               getVitem)
setMethod('[<-',  '_p_VectorTT_String_t',               setVitem)
setMethod('[',    '_p_VectorNumTT_int_t',               getVitem)
setMethod('[<-',  '_p_VectorNumTT_int_t',               setVitem)
setMethod('[',    '_p_VectorNumTT_double_t',            getVitem)
setMethod('[<-',  '_p_VectorNumTT_double_t',            setVitem)
setMethod('[[',   '_p_VectorTT_VectorInt_t',            getVitem)
setMethod('[[<-', '_p_VectorTT_VectorInt_t',            setVitem)
setMethod('[[',   '_p_VectorTT_VectorDouble_t',         getVitem)
setMethod('[[<-', '_p_VectorTT_VectorDouble_t',         setVitem)
%}