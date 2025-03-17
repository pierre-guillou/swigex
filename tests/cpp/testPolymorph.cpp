#include "polymorph.hpp"
#include "stdoutredirect.hpp"

class ChildTwo : public ParentBase
{
public:
  ChildTwo(): ParentBase() {}
  virtual ~ChildTwo() {}

  virtual String getHello() const override { return "ChildTwo in C++ - Hello"; }
};

int main()
{
  StdoutRedirect sr("testPolymorph.out");
  
  ParentBase pa;
  showHello(&pa);
  ChildOne co;
  showHello(&co);
  ChildTwo ct;
  showHello(&ct);

  return 0;
}
