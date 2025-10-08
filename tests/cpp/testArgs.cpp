#include "args.hpp"
#include "stdoutredirect.hpp"

#include <iostream>

int main()
{
  StdoutRedirect sr("testArgs.out");
  
  TypeClass a;
  int i = a.testInt(12);
  if (i != 12)
    std::cout << "Wrong Int!" << std::endl;
  i = a.testIntRef(22);
  if (i != 22)
    std::cout << "Wrong Int Reference!" << std::endl;
  const Id* pi = a.testIntPtr(new Id(32));
  if ((*pi) != 32)
    std::cout << "Wrong Int Pointer!" << std::endl;
  VectorInt vi = a.testVectorInt({23,33,43});
  if (vi[0] != 23 || vi[1] != 33 || vi[2] != 43)
    std::cout << "Wrong VectorInt!" << std::endl;
  vi = a.testVectorIntRef({24,34,44});
  if (vi[0] != 24 || vi[1] != 34 || vi[2] != 44)
    std::cout << "Wrong VectorInt Reference!" << std::endl;
  const VectorInt* pvi = a.testVectorIntPtr(new VectorInt({25,35,45}));
  if ((*pvi)[0] != 25 || (*pvi)[1] != 35 || (*pvi)[2] != 45)
    std::cout << "Wrong VectorInt Pointer!" << std::endl;
  VectorVectorInt vvi = a.testVVectorInt({{23,33,43},{53,63},{73,83,93}});
  if (vvi[0][0] != 23 || vvi[0][1] != 33 || vvi[0][2] != 43 ||
      vvi[1][0] != 53 || vvi[1][1] != 63 ||
      vvi[2][0] != 73 || vvi[2][1] != 83 || vvi[2][2] != 93)
    std::cout << "Wrong VectorVectorInt!" << std::endl;
  vvi = a.testVVectorIntRef({{24,34,44},{54,64},{74,84,94}});
  if (vvi[0][0] != 24 || vvi[0][1] != 34 || vvi[0][2] != 44 ||
      vvi[1][0] != 54 || vvi[1][1] != 64 ||
      vvi[2][0] != 74 || vvi[2][1] != 84 || vvi[2][2] != 94)
    std::cout << "Wrong VectorVectorInt Reference!" << std::endl;
  const VectorVectorInt* pvvi;
  vvi.clear();
  vvi.push_back(VectorInt({25,35,45}));
  vvi.push_back(VectorInt({55,65}));
  vvi.push_back(VectorInt({75,85,95}));
  pvvi = a.testVVectorIntPtr(&vvi);
  if ((*pvvi)[0][0] != 25 || (*pvvi)[0][1] != 35 || (*pvvi)[0][2] != 45 ||
      (*pvvi)[1][0] != 55 || (*pvvi)[1][1] != 65 ||
      (*pvvi)[2][0] != 75 || (*pvvi)[2][1] != 85 || (*pvvi)[2][2] != 95)
    std::cout << "Wrong VectorVectorInt Pointer!" << std::endl;
  double d = a.testDouble(12.1);
  if (d != 12.1)
    std::cout << "Wrong Double!" << std::endl;
  d = a.testDoubleRef(22.2);
  if (d != 22.2)
    std::cout << "Wrong Double Reference!" << std::endl;
  const double* pd = a.testDoublePtr(new double(32.3));
  if ((*pd) != 32.3)
    std::cout << "Wrong Double Pointer!" << std::endl;
  VectorDouble vd = a.testVectorDouble({23.1,33.1,43.1});
  if (vd[0] != 23.1 || vd[1] != 33.1 || vd[2] != 43.1)
    std::cout << "Wrong VectorDouble!" << std::endl;
  vd = a.testVectorDoubleRef({24.2,34.2,44.2});
  if (vd[0] != 24.2 || vd[1] != 34.2 || vd[2] != 44.2)
    std::cout << "Wrong VectorDouble Reference!" << std::endl;
  const VectorDouble* pvd = a.testVectorDoublePtr(new VectorDouble({25.3,35.3,45.3}));
  if ((*pvd)[0] != 25.3 || (*pvd)[1] != 35.3 || (*pvd)[2] != 45.3)
    std::cout << "Wrong VectorDouble Pointer!" << std::endl;
  VectorVectorDouble vvd = a.testVVectorDouble({{23.1,33.1,43.1},{53.1,63.1},{73.1,83.1,93.1}});
  if (vvd[0][0] != 23.1 || vvd[0][1] != 33.1 || vvd[0][2] != 43.1 ||
      vvd[1][0] != 53.1 || vvd[1][1] != 63.1 ||
      vvd[2][0] != 73.1 || vvd[2][1] != 83.1 || vvd[2][2] != 93.1)
    std::cout << "Wrong VectorVectorDouble!" << std::endl;
  vvd = a.testVVectorDoubleRef({{24.2,34.2,44.2},{54.2,64.2},{74.2,84.2,94.2}});
  if (vvd[0][0] != 24.2 || vvd[0][1] != 34.2 || vvd[0][2] != 44.2 ||
      vvd[1][0] != 54.2 || vvd[1][1] != 64.2 ||
      vvd[2][0] != 74.2 || vvd[2][1] != 84.2 || vvd[2][2] != 94.2)
    std::cout << "Wrong VectorVectorDouble Reference!" << std::endl;
  const VectorVectorDouble* pvvd;
  vvd.clear();
  vvd.push_back(VectorDouble({25.3,35.3,45.3}));
  vvd.push_back(VectorDouble({55.3,65.3}));
  vvd.push_back(VectorDouble({75.3,85.3,95.3}));
  pvvd = a.testVVectorDoublePtr(&vvd);
  if ((*pvvd)[0][0] != 25.3 || (*pvvd)[0][1] != 35.3 || (*pvvd)[0][2] != 45.3 ||
      (*pvvd)[1][0] != 55.3 || (*pvvd)[1][1] != 65.3 ||
      (*pvvd)[2][0] != 75.3 || (*pvvd)[2][1] != 85.3 || (*pvvd)[2][2] != 95.3)
    std::cout << "Wrong VectorVectorDouble Pointer!" << std::endl;
  String s = a.testString("Str12");
  if (s != "Str12")
    std::cout << "Wrong String!" << std::endl;
  s = a.testStringRef("Str22");
  if (s != "Str22")
    std::cout << "Wrong String Reference!" << std::endl;
  const String* ps = a.testStringPtr(new String("Str32"));
  if ((*ps) != "Str32")
    std::cout << "Wrong String Pointer!" << std::endl;
  VectorString vs = a.testVectorString({"Str23","Str33","Str43"});
  if (vs[0] != "Str23" || vs[1] != "Str33" || vs[2] != "Str43")
    std::cout << "Wrong VectorString!" << std::endl;
  vs = a.testVectorStringRef({"Str24","Str34","Str44"});
  if (vs[0] != "Str24" || vs[1] != "Str34" || vs[2] != "Str44")
    std::cout << "Wrong VectorString Reference!" << std::endl;
  const VectorString* pvs = a.testVectorStringPtr(new VectorString({"Str25","Str35","Str45"}));
  if ((*pvs)[0] != "Str25" || (*pvs)[1] != "Str35" || (*pvs)[2] != "Str45")
    std::cout << "Wrong VectorString Pointer!" << std::endl;

  a.testVectorInt({}); // Empty vector
  //a.testVectorInt(101); // Single value                              // TODO : Not possible in C++  (value interpreted as size_type)
  a.testVectorInt({102}); // Vector with 1 item
  a.testVectorDouble({}); // Empty vector
  //a.testVectorDouble(201.1); // Single value                         // TODO : Not possible in C++  (value interpreted as size_type)
  a.testVectorDouble({202.1}); // Vector with 1 item
  a.testVectorString({}); // Empty vector
  //a.testVectorString("Str301"); // Single value                      // TODO : Not possible in C++  (cannot convert value to size_type)
  a.testVectorString({"Str302"}); // Vector with 1 item
  a.testVVectorInt({}); // Empty vector
  //a.testVVectorInt(101); // Single value                             // TODO : Not possible in C++  (value interpreted as size_type)
  //a.testVVectorInt({102}); // Only 1 vector with 1 item              // TODO : Not possible in C++  (value interpreted as size_type)
  //a.testVVectorInt({103, 104}); // Only 1 vector with 2 items        // TODO : Not possible in C++  (values interpreted as size_type)
  a.testVVectorDouble({}); // Empty vector
  //a.testVVectorDouble(201.1); // Single value                        // TODO : Not possible in C++  (value interpreted as size_type)
  //a.testVVectorDouble({202.1}); // Only 1 vector with 1 item         // TODO : Not possible in C++  (cannot convert value to size_type)
  //a.testVVectorDouble({203.1, 204.1}); // Only 1 vector with 2 items // TODO : Not possible in C++  (cannot convert value to size_type)
  // No VectorVectorString (doesn't exist in the C++ library)

  a.testIntOverload(12);
  a.testIntOverload({13, 14});

  a.testDoubleOverload(12.1);
  a.testDoubleOverload({13.1, 14.1});

  a.testStringOverload("Str12.1");
  //a.testStringOverload({"Str13.1", "Str14.1"}); // TODO : Not possible in C++

  return 0;
}
