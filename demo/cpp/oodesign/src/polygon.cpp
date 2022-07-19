#include "polygon.h"

Polygon::Polygon(const std::string& id, int num_sides)
: Shape(id),
  d_num_sides(num_sides)
{
}

int Polygon::num_sides() const
{
	return d_num_sides;
}