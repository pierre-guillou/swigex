#include "args.hpp"

#include <iostream>

TypeClass::TypeClass()
: _display(true)
, _varInt()
, _varDouble()
, _varString()
, _varVectorInt()
, _varVVectorInt()
, _varVectorDouble()
, _varVVectorDouble()
, _varVectorString()
{

}
TypeClass::~TypeClass()
{

}

Id TypeClass::testInt(Id a)
{
  _varInt = a;
  if (_display) std::cout << "Test int: " << a << std::endl;
  return _varInt;
}

const Id& TypeClass::testIntRef(const Id& a)
{
  _varInt = a;
  if (_display) std::cout << "Test int Reference: " << a << std::endl;
  return _varInt;
}

const Id* TypeClass::testIntPtr(const Id* a)
{
  _varInt = *a;
  if (_display) std::cout << "Test int Pointer: " << *a << std::endl;
  return &_varInt;
}

void TypeClass::testIntRefOut(Id& a) const
{
  a = _varInt;
  if (_display) std::cout << "Test int Reference Out: " << a << std::endl;
}

void TypeClass::testIntRefDef(const Id& a, const Id& b)
{
  _varInt = a;
  if (_display) std::cout << "Test int Reference Def: " << a << " - " << b << std::endl;
}

VectorInt TypeClass::testVectorInt(VectorInt a)
{
  _varVectorInt = a;
  if (_display) std::cout << "Test VectorInt: " << a << std::endl;
  return _varVectorInt;
}

const VectorInt& TypeClass::testVectorIntRef(const VectorInt& a)
{
  _varVectorInt = a;
  if (_display) std::cout << "Test VectorInt Reference: " << a << std::endl;
  return _varVectorInt;
}

const VectorInt* TypeClass::testVectorIntPtr(const VectorInt* a)
{
  _varVectorInt = *a;
  if (_display) std::cout << "Test VectorInt Pointer: " << *a << std::endl;
  return &_varVectorInt;
}

void TypeClass::testVectorIntRefOut(VectorInt& a) const
{
  a = _varVectorInt;
  if (_display) std::cout << "Test VectorInt Reference Out: " << a << std::endl;
}

void TypeClass::testVectorIntRefDef(const VectorInt& a, const VectorInt& b)
{
  _varVectorInt = a;
  if (_display) std::cout << "Test VectorInt Reference Def: " << a << " - " << b << std::endl;
}

VectorVectorInt TypeClass::testVVectorInt(VectorVectorInt a)
{
  _varVVectorInt = a;
  if (_display) std::cout << "Test VectorVectorInt: " << a << std::endl;
  return _varVVectorInt;
}

const VectorVectorInt& TypeClass::testVVectorIntRef(const VectorVectorInt& a)
{
  _varVVectorInt = a;
  if (_display) std::cout << "Test VectorVectorInt Reference: " << a << std::endl;
  return _varVVectorInt;
}

const VectorVectorInt* TypeClass::testVVectorIntPtr(const VectorVectorInt* a)
{
  _varVVectorInt = *a;
  if (_display) std::cout << "Test VectorVectorInt Pointer: " << *a << std::endl;
  return &_varVVectorInt;
}

void TypeClass::testVVectorIntRefOut(VectorVectorInt& a) const
{
  a = _varVVectorInt;
  if (_display) std::cout << "Test VectorVectorInt Reference Out: " << a << std::endl;
}

void TypeClass::testVVectorIntRefDef(const VectorVectorInt& a, const VectorVectorInt& b)
{
  _varVVectorInt = a;
  if (_display) std::cout << "Test VectorVectorInt Reference Def: " << a << " - " << b << std::endl;
}

double TypeClass::testDouble(double a)
{
  _varDouble = a;
  if (_display) std::cout << "Test double: " << a << std::endl;
  return _varDouble;
}

const double& TypeClass::testDoubleRef(const double& a)
{
  _varDouble = a;
  if (_display) std::cout << "Test double Reference: " << a << std::endl;
  return _varDouble;
}

const double* TypeClass::testDoublePtr(const double* a)
{
  _varDouble = *a;
  if (_display) std::cout << "Test double Pointer: " << *a << std::endl;
  return &_varDouble;
}

void TypeClass::testDoubleRefOut(double& a) const
{
  a = _varDouble;
  if (_display) std::cout << "Test Double Reference Out: " << a << std::endl;
}

void TypeClass::testDoubleRefDef(const double& a, const double& b)
{
  _varDouble = a;
  if (_display) std::cout << "Test Double Reference Def: " << a << " - " << b << std::endl;
}

VectorDouble TypeClass::testVectorDouble(VectorDouble a)
{
  _varVectorDouble = a;
  if (_display) std::cout << "Test VectorDouble: " << a << std::endl;
  return _varVectorDouble;
}

const VectorDouble& TypeClass::testVectorDoubleRef(const VectorDouble& a)
{
  _varVectorDouble = a;
  if (_display) std::cout << "Test VectorDouble Reference: " << a << std::endl;
  return _varVectorDouble;
}

const VectorDouble* TypeClass::testVectorDoublePtr(const VectorDouble* a)
{
  _varVectorDouble = *a;
  if (_display) std::cout << "Test VectorDouble Pointer: " << *a << std::endl;
  return &_varVectorDouble;
}

void TypeClass::testVectorDoubleRefOut(VectorDouble& a) const
{
  a = _varVectorDouble;
  if (_display) std::cout << "Test VectorDouble Reference Out: " << a << std::endl;
}

void TypeClass::testVectorDoubleRefDef(const VectorDouble& a, const VectorDouble& b)
{
  _varVectorDouble = a;
  if (_display) std::cout << "Test VectorDouble Reference Def: " << a << " - " << b << std::endl;
}

VectorVectorDouble TypeClass::testVVectorDouble(VectorVectorDouble a)
{
  _varVVectorDouble = a;
  if (_display) std::cout << "Test VectorVectorDouble: " << a << std::endl;
  return _varVVectorDouble;
}

const VectorVectorDouble& TypeClass::testVVectorDoubleRef(const VectorVectorDouble& a)
{
  _varVVectorDouble = a;
  if (_display) std::cout << "Test VectorVectorDouble Reference: " << a << std::endl;
  return _varVVectorDouble;
}

const VectorVectorDouble* TypeClass::testVVectorDoublePtr(const VectorVectorDouble* a)
{
  _varVVectorDouble = *a;
  if (_display) std::cout << "Test VectorVectorDouble Pointer: " << *a << std::endl;
  return &_varVVectorDouble;
}

void TypeClass::testVVectorDoubleRefOut(VectorVectorDouble& a) const
{
  a = _varVVectorDouble;
  if (_display) std::cout << "Test VectorVectorDouble Reference Out: " << a << std::endl;
}

void TypeClass::testVVectorDoubleRefDef(const VectorVectorDouble& a, const VectorVectorDouble& b)
{
  _varVVectorDouble = a;
  if (_display) std::cout << "Test VectorVectorDouble Reference Def: " << a << " - " << b << std::endl;
}

String TypeClass::testString(String a)
{
  _varString = a;
  if (_display) std::cout << "Test String: " << a << std::endl;
  return _varString;
}

const String& TypeClass::testStringRef(const String& a)
{
  _varString = a;
  if (_display) std::cout << "Test String Reference: " << a << std::endl;
  return a;
}

const String* TypeClass::testStringPtr(const String* a)
{
  _varString = *a;
  if (_display) std::cout << "Test String Pointer: " << *a << std::endl;
  return &_varString;
}

void TypeClass::testStringRefOut(String& a) const
{
  a = _varString;
  if (_display) std::cout << "Test String Reference Out: " << a << std::endl;
}

void TypeClass::testStringRefDef(const String& a, const String& b)
{
  _varString = a;
  if (_display) std::cout << "Test String Reference Def: " << a << " - " << b << std::endl;
}

VectorString TypeClass::testVectorString(VectorString a)
{
  _varVectorString = a;
  if (_display) std::cout << "Test VectorString: " << a << std::endl;
  return _varVectorString;
}

const VectorString& TypeClass::testVectorStringRef(const VectorString& a)
{
  _varVectorString = a;
  if (_display) std::cout << "Test VectorString Reference: " << a << std::endl;
  return _varVectorString;
}

const VectorString* TypeClass::testVectorStringPtr(const VectorString* a)
{
  _varVectorString = *a;
  if (_display) std::cout << "Test VectorString Pointer: " << *a << std::endl;
  return &_varVectorString;
}

void TypeClass::testVectorStringRefOut(VectorString& a) const
{
  a = _varVectorString;
  if (_display) std::cout << "Test VectorString Reference Out: " << a << std::endl;
}

void TypeClass::testVectorStringRefDef(const VectorString& a, const VectorString& b)
{
  _varVectorString = a;
  if (_display) std::cout << "Test VectorString Reference Def: " << a << " - " << b << std::endl;
}

void TypeClass::testIntOverload(Id a) const
{
  std::cout << "Test int Overload [Scalar]: " << a << std::endl;
}
void TypeClass::testIntOverload(const VectorInt& a) const
{
  std::cout << "Test int Overload [Vector]: " << a << std::endl;
}
void TypeClass::testDoubleOverload(double a) const
{
  std::cout << "Test double Overload [Scalar]: " << a << std::endl;
}
void TypeClass::testDoubleOverload(const VectorDouble& a) const
{
  std::cout << "Test double Overload [Vector]: " << a << std::endl;
}
void TypeClass::testStringOverload(String a) const
{
  std::cout << "Test String Overload [Single]: " << a << std::endl;
}
void TypeClass::testStringOverload(const VectorString& a) const
{
  std::cout << "Test String Overload [Vector]: " << a << std::endl;
}
