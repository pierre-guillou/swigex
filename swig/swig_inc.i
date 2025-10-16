%feature(director) ParentBase;

%{
  #include "swigex_export.hpp"
  #include "swigex_define.hpp"
  #include "VectorT.hpp"
  #include "VectorNumT.hpp"
  #include "fibo.hpp"
  #include "args.hpp"
  #include "polymorph.hpp"
  #include "stdoutredirect.hpp"
%}

////////////////////////////
//        Typemaps        //
////////////////////////////

// Mandatory for using swig::asptr and swig::from for std::vectors
%include std_vector.i
%include std_string.i
%template(DoNotUseVectorIntStd)     std::vector< int >;
%template(DoNotUseVectorLongStd)    std::vector< long >;
%template(DoNotUseVectorLLongStd)   std::vector< long long >;
%template(DoNotUseVectorDoubleStd)  std::vector< double >;
%template(DoNotUseVectorStringStd)  std::vector< std::string >; // Keep std::string here otherwise asptr fails!
%template(DoNotUseVVectorIntStd)    std::vector< std::vector< int > >;
%template(DoNotUseVVectorLongStd)   std::vector< std::vector< long > >;
%template(DoNotUseVVectorLLongStd)  std::vector< std::vector< long long > >;
%template(DoNotUseVVectorDoubleStd) std::vector< std::vector< double > >;

////////////////////////////////////////////////
// Conversion Target language => C++

// Note : Before including this file :
//        - vectorToCpp, vectorVectorToCpp and convertToCpp 
//          functions must be defined in ToCpp fragment

// Convert scalar arguments by value
%typemap(in, fragment="ToCpp") Id,
                               double,
                               String
{
  try
  {
    int errcode = convertToCpp($input, $1);
    if (!SWIG_IsOK(errcode))
      %argument_fail(errcode, "$type", $symname, $argnum);
  }
  catch(...)
  {
    std::cerr << "Error while converting argument #$argnum of type '$type' in '$symname' function";
  }
}

// Convert scalar argument by reference
// Don't add String or char here otherwise "res2 not declared" / "alloc1 not declared"
%typemap(in, fragment="ToCpp") Id*     (Id val),     const Id*     (Id val),
                               Id&     (Id val),     const Id&     (Id val),
                               double* (double val), const double* (double val),
                               double& (double val), const double& (double val)
{
  try
  {
    int errcode = convertToCpp($input, val);
    if (!SWIG_IsOK(errcode))
      %argument_fail(errcode, "$type", $symname, $argnum);
    $1 = &val;
  }
  catch(...)
  {
    std::cerr << "Error while converting argument #$argnum of type '$type' in '$symname' function";
  }
}

%typemap(in, fragment="ToCpp") VectorInt    (void *argp),
                               VectorDouble (void *argp),
                               VectorString (void *argp)
{ 
  // Try to convert from any target language vector
  int errcode = vectorToCpp($input, $1);
  if (!SWIG_IsOK(errcode))
  {
    // Try direct conversion of Vectors by value (see swigtypes.swg)
    errcode = SWIG_ConvertPtr($input, &argp, $&descriptor, %convertptr_flags);
    if (SWIG_IsOK(errcode))
    {
      if (!argp) {
        %argument_nullref("$type", $symname, $argnum);
      }
      else {
        $&ltype temp = %reinterpret_cast(argp, $&ltype);
        $1 = *temp;
        if (SWIG_IsNewObj(errcode)) %delete(temp);
      }
    }
    else
      %argument_fail(errcode, "$type", $symname, $argnum);
  }
}

%typemap(in, fragment="ToCpp") VectorVectorInt    (void *argp),
                               VectorVectorDouble (void *argp)
{
  // Try to convert from any target language vector
  int errcode = vectorVectorToCpp($input, $1);
  if (!SWIG_IsOK(errcode))
  {
    // Try direct conversion of VectorVectors by value (see swigtypes.swg)
    errcode = SWIG_ConvertPtr($input, &argp, $&descriptor, %convertptr_flags);
    if (SWIG_IsOK(errcode))
    {
      if (!argp) {
        %argument_nullref("$type", $symname, $argnum);
      }
      else {
        $&ltype temp = %reinterpret_cast(argp, $&ltype);
        $1 = *temp;
        if (SWIG_IsNewObj(errcode)) %delete(temp);
      }
    }
    else {
      %argument_fail(errcode, "$type", $symname, $argnum);
    }
  }
}

%typemap(in, fragment="ToCpp") const VectorInt&    (void *argp, VectorInt vec),
                               const VectorInt*    (void *argp, VectorInt vec),
                               const VectorDouble& (void *argp, VectorDouble vec),
                               const VectorDouble* (void *argp, VectorDouble vec),
                               const VectorString& (void *argp, VectorString vec),
                               const VectorString* (void *argp, VectorString vec)
{
  // Try to convert from any target language vector
  int errcode = vectorToCpp($input, vec);
  if (!SWIG_IsOK(errcode))
  {
    try
    {
      // Try direct conversion of Vectors by reference/pointer (see swigtypes.swg)
      errcode = SWIG_ConvertPtr($input, &argp, $descriptor, %convertptr_flags);
      if (SWIG_IsOK(errcode))
      {
        if (!argp) {
          %argument_nullref("$type", $symname, $argnum);
        }
        $1 = %reinterpret_cast(argp, $ltype);
      }
      else {
        %argument_fail(errcode, "$type", $symname, $argnum);
      }
    }
    catch(...)
    {
      %argument_fail(errcode, "$type", $symname, $argnum);
    }
  }
  else {
    $1 = &vec;
  }
}

%typemap(in, fragment="ToCpp") const VectorVectorInt&    (void *argp, VectorVectorInt vec),
                               const VectorVectorInt*    (void *argp, VectorVectorInt vec),
                               const VectorVectorDouble& (void *argp, VectorVectorDouble vec),
                               const VectorVectorDouble* (void *argp, VectorVectorDouble vec)
{
  // Try to convert from any target language vector
  int errcode = vectorVectorToCpp($input, vec);
  if (!SWIG_IsOK(errcode))
  {
    try
    {
      // Try direct conversion of VectorVectors by reference/pointer (see swigtypes.swg)
      errcode = SWIG_ConvertPtr($input, &argp, $descriptor, %convertptr_flags);
      if (SWIG_IsOK(errcode))
      {
        if (!argp) {
          %argument_nullref("$type", $symname, $argnum);
        }
        $1 = %reinterpret_cast(argp, $ltype);
      }
      else {
        %argument_fail(errcode, "$type", $symname, $argnum);
      }
    }
    catch(...)
    {
      %argument_fail(errcode, "$type", $symname, $argnum);
    }
  }
  else
  {
    $1 = &vec;
  }
}

////////////////////////////////////////////////
// Conversion C++ => Target language
//
// Note : Before including this file :
//        - vectorFromCpp, vectorVectorFromCpp and objectFromCpp 
//          functions must be defined in FromCpp fragment

%typemap(out, fragment="FromCpp") Id,
                                  double,
                                  String
{
  $result = objectFromCpp($1);
}

%typemap(out, fragment="FromCpp") Id*,     const Id*,     Id&,     const Id&,
                                  double*, const double*, double&, const double&,
                                  String*, const String*, String&, const String&
{
  $result = objectFromCpp(*$1);
}

%typemap(out, fragment="FromCpp") VectorInt, 
                                  VectorDouble, 
                                  VectorString
{
  int errcode = vectorFromCpp(&($result), $1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorInt*,    VectorInt&,
                                  VectorDouble*, VectorDouble&,
                                  VectorString*, VectorString&
{
  int errcode = vectorFromCpp(&($result), *$1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorVectorInt,
                                  VectorVectorDouble
{
  int errcode = vectorVectorFromCpp(&($result), $1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

%typemap(out, fragment="FromCpp") VectorVectorInt*,    VectorVectorInt&,
                                  VectorVectorDouble*, VectorVectorDouble&
{
  int errcode = vectorVectorFromCpp(&($result), *$1);
  if (!SWIG_IsOK(errcode))
    SWIG_exception_fail(SWIG_ArgError(errcode), "in method $symname, wrong return value: $type");
}

