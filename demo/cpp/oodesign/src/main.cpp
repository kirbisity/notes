#include <iostream>
#include "shape.h"
#include "polygon.h"

using namespace std;

int main(int argc, char *argv[])
{
	Polygon* p_p= new Polygon("p", 5);
	cout << p_p->asString() << p_p->num_sides() << endl;
	return 0;
}