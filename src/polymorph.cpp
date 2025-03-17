#include "polymorph.hpp"

#include <iostream>

 void showHello(const ParentBase* parent)
{
   std::cout << parent->getHello() << std::endl;
}

