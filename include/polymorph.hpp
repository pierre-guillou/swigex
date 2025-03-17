#pragma once

#include "swigex_export.hpp"
#include "swigex_define.hpp"

/**
 * Base class for testing polymorphism in target language
 */
class SWIGEX_EXPORT ParentBase
{
  public:
    ParentBase() {};
    virtual ~ParentBase() {};

    virtual String getHello() const { return "Hello"; }
};

/**
 * Concrete class for testing polymorphism in target language
 */
class SWIGEX_EXPORT ChildOne : public ParentBase
{
  public:
    ChildOne() {};
    virtual ~ChildOne() {};

    virtual String getHello() const override { return "ChildOne - Hello"; }

    //virtual ChildOne* clone() const override { return new ChildOne(); } // Override clone even if the return type is different
};

/// Global function for testing polymorphism
SWIGEX_EXPORT void showHello(const ParentBase* parent);


