#ifndef INCLUDED_POLYGON
#define INCLUDED_POLYGON

#include <string>
#include "shape.h"

class Polygon : public Shape
{
	public:
	  	Polygon(const std::string& id, int num_sides);
	  	int num_sides() const;
    protected:
    private:
  		int d_num_sides;

};

# endif

