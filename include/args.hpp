#pragma once

#include "myfibo_export.hpp"
#include "fibo_define.hpp"

#include "VectorT.hpp"
#include "VectorNumT.hpp"


class MYFIBO_EXPORT TypeClass
{
public:
  TypeClass();
  ~TypeClass();
//                                                                             //   R         Python

  int testInt(int a);                                                          //   OK        OK
  const int& testIntRef(const int& a);                                         //   OK        OK
  const int* testIntPtr(const int* a);                                         //   ## NOK    OK
  void testIntRefOut(int& a) const;                                            //   ## NOK    ## NOK

  VectorInt testVectorInt(VectorInt a);                                        //   OK        OK
  const VectorInt& testVectorIntRef(const VectorInt& a);                       //   OK        OK
  const VectorInt* testVectorIntPtr(const VectorInt* a);                       //   OK        OK
  void testVectorIntRefOut(VectorInt& a) const;                                //   OK        OK

  VectorVectorInt testVVectorInt(VectorVectorInt a);                           //   OK        OK
  const VectorVectorInt& testVVectorIntRef(const VectorVectorInt& a);          //   OK        OK
  const VectorVectorInt* testVVectorIntPtr(const VectorVectorInt* a);          //   OK        OK
  void testVVectorIntRefOut(VectorVectorInt& a) const;                         //   OK        OK

  double testDouble(double a);                                                 //   OK        OK
  const double& testDoubleRef(const double& a);                                //   OK        OK
  const double* testDoublePtr(const double* a);                                //   ## NOK    OK
  void testDoubleRefOut(double& a) const;                                      //   ## NOK    ## NOK

  VectorDouble testVectorDouble(VectorDouble a);                               //   OK        OK
  const VectorDouble& testVectorDoubleRef(const VectorDouble& a);              //   OK        OK
  const VectorDouble* testVectorDoublePtr(const VectorDouble* a);              //   OK        OK
  void testVectorDoubleRefOut(VectorDouble& a) const;                          //   OK        OK

  VectorVectorDouble testVVectorDouble(VectorVectorDouble a);                  //   OK        OK
  const VectorVectorDouble& testVVectorDoubleRef(const VectorVectorDouble& a); //   OK        OK
  const VectorVectorDouble* testVVectorDoublePtr(const VectorVectorDouble* a); //   OK        OK
  void testVVectorDoubleRefOut(VectorVectorDouble& a) const;                   //   OK        OK

  String testString(String a);                                                 //   OK        OK
  const String& testStringRef(const String& a);                                //   OK        OK
  const String*testStringPtr(const String* a);                                 //   ## NOK    ## NOK
  void testStringRefOut(String& a) const;                                      //   ## NOK    ## NOK

  VectorString testVectorString(VectorString a);                               //   OK        OK
  const VectorString& testVectorStringRef(const VectorString& a);              //   OK        OK
  const VectorString* testVectorStringPtr(const VectorString* a);              //   OK        OK
  void testVectorStringRefOut(VectorString& a) const;                          //   OK        OK

  void testIntOverload(int a) const;                                           //   OK        OK
  void testIntOverload(const VectorInt& a) const;                              //   OK        OK
  void testDoubleOverload(double a) const;                                     //   OK        OK
  void testDoubleOverload(const VectorDouble& a) const;                        //   OK        OK
  void testStringOverload(String a) const;                                     //   OK        OK
  void testStringOverload(const VectorString& a) const;                        //   OK        OK

private:
  int                _varInt;
  double             _varDouble;
  String             _varString;
  VectorInt          _varVectorInt;
  VectorVectorInt    _varVVectorInt;
  VectorDouble       _varVectorDouble;
  VectorVectorDouble _varVVectorDouble;
  VectorString       _varVectorString;
};
