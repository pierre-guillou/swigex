#include "fibo.hpp"
#include "version.h"

#include <iostream>
#include <sstream>

/**
 * Return the Nth Fibonacci number
 *
 * @param n: index of the value
 */
int fibn(int n)
{
  int a = 0;
  int b = 1;
  int i = 1;
  if (n <= 0) return -1;
  while (1)
  {
    if (i == n) return a;
    int aa = a;
    a = b;
    b = aa+b;
    i++;
  }
  return -1;
}

/**
 * Print Fibonacci numbers up to the provided value
 *
 * @param n: maximum value to be generated
 */
VectorInt fib(int n)
{
  VectorInt res;
  int a = 0;
  int b = 1;
  while (a < n)
  {
    res.push_back(a);
    int aa = a;
    a = b;
    b = aa+b;
  }
  return res;
}

std::vector<int> fibStd(int n)
{
  return fib(n).getVector();
}

void printVi(const VectorInt& vec)
{
  std::cout << "printVi ";
  for (const auto& i: vec)
    std::cout << i << ' ';
  std::cout << std::endl;
}
void printVd(const VectorDouble& vec)
{
  std::cout << "printVd ";
  for (const auto& i: vec)
    std::cout << i << ' ';
  std::cout << std::endl;
}
void printVs(const VectorString& vec)
{
  std::cout << "printVs ";
  for (const auto& i: vec)
    std::cout << i << ' ';
  std::cout << std::endl;
}

void printStd(const std::vector<int>& vec)
{
  std::cout << "printStd ";
  for (const auto& i: vec)
    std::cout << i << ' ';
  std::cout << std::endl;
}

/**
 * Default constructor of a class which handle Fibonacci integer list up to n
 * 
 * @param n     Strict Positive Integer
 * @param title Title to be printed
 */
Fibo::Fibo(int n, const String& title)
: _n(n)
, _title(title)
{
  if (_n <= 0)
  {
    std::cout << "Fibonacci class must be initialized with a strict positive integer. N is set to 50." << std::endl;
    _n = 50;
  }
  if (_title.empty())
  {
    std::stringstream sstr;
    sstr << DEFAULT_TITLE << " (" << MYFIBO_RELEASE << " - " << MYFIBO_DATE << ")";
    _title = sstr.str();
  }
}

/**
 * Destructor
 */
Fibo::~Fibo()
{
}

/**
 * Write the Fibonacci list to standard output
 *
 * @param showTitle Flag for printing the title
 */
void Fibo::display(bool showTitle) const
{
  if (showTitle)
    std::cout << _title << ": ";
  VectorInt res = get();
  for (const auto& i: res)
    std::cout << i << ' ';
  std::cout << std::endl;
}

/**
 * Return the Fibonacci list as a vector of integer
 *
 * @return Fibonacci integer vector
 */
VectorInt Fibo::get() const
{
  return fib(_n);
}

