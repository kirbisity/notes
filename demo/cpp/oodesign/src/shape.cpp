#include "shape.h"

Shape::Shape(const std::string& id)
: d_id(id)
{
}

Shape::~Shape()
{
}

const std::string& Shape::asString() const
{
	return d_id;
}