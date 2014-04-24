#include <tut/tut.hpp>
#include <tut/tut_macros.hpp>

struct <+FILE NAME ROOT+> {};
typedef tut::test_group<<+FILE NAME ROOT+>> factory;
typedef factory::object object;

namespace tut
{

template<>
template<>
void object::test<1>()
{<+CURSOR+>
}

}

namespace
{
    factory tf("<+FILE NAME ROOT+>");
}
