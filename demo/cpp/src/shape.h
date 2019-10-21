#ifndef INCLUDED_SHAPE
#define INCLUDED_SHAPE

#include <string>

class Shape
{
	public:
	  	Shape(const std::string& id);
	  	virtual ~Shape();
  		const std::string& asString() const;
    protected:
    private:
  		std::string d_id;

};

#endif