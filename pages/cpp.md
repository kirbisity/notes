# C++

[Back](../README.md)



### Class

#### Inheritance

* Model is-a-kind-of relationships
* Enable substitutability
* Reuse code in derived classes

##### Example:

Base class

```c++
/* vehicle.h */
class Vehicle {
  public:
    Vehicle(int weight); // parent constructor
    Vehicle(const Vehicle& original); // parent copy constructor
    virtual ~Vehicle(); // if a virtual function is used, destructor need to be virtual
    virtual int price(); // virtual function will look for definition in child
  protected:
    int d_weight; // attribute shared across inherited classes
  private:
    string d_secret; // attribute inaccessible to any other class including child classes
}

/* vehicle.cpp */
Vehicle::Vehicle(int weight)
: d_weight(weight)
{
}

```

Derived class

* Derived class contains all base class variables and functions.

```c++
/* car.h */
class Car : public Vehicle { // public inheritance
  public:
    Car(int weight, int wheels); // Child constructor
    // No copy constructor
    // No assignment Opertator
    // No destructor
    virtual int price();
  protected:
    int d_wheels; // child class contains attributes unique to itself and its children
}

/* child.cpp */
Car::Car(int weight, int wheels)
: Vehicle(weight), // Uses base class constructor
  d_wheels(wheels)
{
}


```

Inheritance rules

* Base initialized before derived
* Base descructed after derived
* Compiler provide copy constructer and assignment operator for base first

Public, protected and private

* **public:** accessible to all classes
* **protected:** accessible to derived classes
* **private:** accessible only to current class

Public vs private inheritance

* Public inheritance
  * Inheritance is known publicly

* Private inheritance
  * Only child knows relation to parent
  * Using child class as base class will fail
  * Use if the inheritance is only for code reuse

`virtual` keyword

- `virtual` enables dynamic binding for the function in current class and all derived classes
- `virtual` will find the definition in the most derived type.
  - If not virtual, calls `Parent::function()`
  - If virtual, calls `MostDerivedChild::function()`
- Need if virtual destructor if virtual function is used

Mutiple inheritance

* `class Car : public Vehicle, public Asset { ... }`



### Namespace

* Defines a container/scope.
* Mitigates name collision in large projects

Name space look-up

```c++
namespace N1
{
  namespace N2
  {
    void foo() {
      if (1) {
        {
          x // 
          cout << x << endl;
        }
      }
    }
  }
}
```







