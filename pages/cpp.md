# C++

[Back](../README.md)

* [C and C++](#c-and-c++)
* [Class](#class)
* [Namespace](#namespace)
* [Template](#template)
* [Debug-checklist](#debug-checklist)

## C and C++

#### Preprocessor directives

* These are all done at preprocessor stage

* Compiler will not see them

* Debugger will not see them

* **#include**

  * specifies the files to be included, especially header-files

  * ```c++
    #include <car.h>
    ```

* ##### # define

  * Used for undefining a macro

  * At preprocessor stage, replace macro with its value

  * defined values are **not typed**

  * ```c++
    #define WEIGHT 1000
    ```

  * ```c++
    #define MAX(A, B) (A > B) ? (A) : (B)
    ```

  * Be **cautious** of complex macro expressions. Because these are preprocessed, the expressions will be directly plugged in, causing unwanted effects when used. 

    ```c++
    MAX(++a, ++b);
    // will have the same effect as
    if (++a > ++b) {
        ++a;
    } else {
        ++b;
    }
    // which will cause the larger item to ++ twice
    ```

* **#undef**

  * Used for undefining a macro

* **#if**

  * Tests a compile-time condition

* **#elif**

* **#endif**

  * Specifies the end of #if

* **#ifdef**

  * Test for macro definition

* **#ifndef**

  * Tests whether a macro is not defined

  * ```C++
    // car.h
    #ifndef INCLUDED_CAR
    #define INCLUDED_CAR
    class Car {...}
    #endif
    ```

* **#else**

  * Provides an alternative option when #if fails

* **#error**

* **#line**

  * Supplies a line number for compiler messages

* **#pragma**

  * Specifies implementation-defined instructions to the compiler

[Back To Top](#cpp)

## Class

#### Inheritance

* Model is-a-kind-of relationships

* Enable substitutability

* Reuse code in derived classes

* ##### Example:

  ###### Base class

  ```C++
  /* vehicle.h */
  class Vehicle {
    public:
      Vehicle(int weight); // parent constructor
      Vehicle(const Vehicle& original); // parent copy constructor
      virtual ~Vehicle(); // if used virtual function, destructor need to be virtual
      virtual int price(); // virtual function will look for definition in child
    protected:
      int d_weight; // attribute shared across inherited classes
    private:
      string d_secret; // attribute inaccessible to any other classes
  }
  
  /* vehicle.cpp */
  Vehicle::Vehicle(int weight)
  : d_weight(weight)
  {
  }
  ```

  ###### Derived class

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

#### Inheritance rules

* Derived class can be used as base instance

  * A base class pointer `Vehicle*` can refer to a derived `Car` instance

  * ```c++
    Vehicle* foo() { return new Car; }
    ```

  * The reverse is not true.

* Base initialized before derived

* Base destructed after derived

* Compiler provide copy constructer and assignment operator for base first

#### Public, protected and private

* **public:** accessible to all classes
* **protected:** accessible to derived classes
* **private:** accessible only to current class

#### Public vs private inheritance

* Public inheritance
  * Inheritance is known publicly

* Private inheritance
  * Only child knows relation to parent
  * Using child class as base class will fail
  * Use if the inheritance is only for code reuse

#### `virtual` keyword

- `virtual` enables dynamic binding for the function in current class and all derived classes

- `virtual` will find the definition in the most derived type.
  
  - If not virtual. Call `Parent::function()`
  - If virtual. Call `MostDerivedChild::function()`
  
- Need virtual destructor in base class if virtual function is used

  - ```c++
    virtual ~Vehicle();
    ```

  - Derived classes don't have destructor.

#### Multiple inheritance

* ```c++
  class Car : public Vehicle, public Asset { ... }`
  ```

[Back To Top](#cpp)

## Namespace

* Defines a container/scope.
* Mitigates name collision in large projects

#### Name space look-up

* start in tightest scope and move to wider scope

* stops once found

* name in tighter scope hides name in wider scope

* derived class inherits base's name

* derived can hide names from base

* ```c++
  int x; // 7
  namespace N1 {
    int x; // 6
    namespace N2 {
      int x; // 5
      void foo() {
        int x; // 3
        if (1) {
          int x;x // 2
          {
            int x; // 1
            cout << x << endl;
          }
        }
      }
    }
  }
  
  class N1::N2::C {
      int x; // 4
  }
  ```

#### Namespace alias

* ```c++
  namespace standard = std;
  standard::cout << "Hello World!" << standard::endl;
  ```

* used to shorten nested namespace

#### `using` keyword

* ```c++
  using std::cout;
  cout << "Hello World!" << std::endl; // cout now refers to std::cout
  ```

* allow names/functions/classes to be used without qualification

* place in tightest scope possible, do not put at file scope

#### Typedef

* ```c++
  typedef std::vector array;
  ```

* Declare an alias for a type, not a new type

* Only used with types

#### Function resolution in name

* ```c++
  class Vehicle {
    public:
      void setPrice(int a);
  }
  class Car : public Vehicle {
    public:
      void setPrice(float a);
  }
  Car c;
  c.setPrice(1); // will call Car::setPrice(float) even when type not match
  ```

* function resolution looks up name first

* name found in tighter scope `Car::setPrice` hides `Vehicle::setPrice` in base class

#### Anonymous namespace

* ```c++
  namespace {
      Car c;
  }
  ```

* alternative to `static`

* applies to all members, while `static` is only for functions and variables

[Back To Top](#cpp)

## Template



#### Specialized template

```c++
template <class T>
struct A {
  static string me = "default";
}

template <>
struct A<int> { // only A<int> goes here
  static string me = "int";
}

template <class T>
void foo(T& a) {
  cout << A<T>::me << endl;
}

foo(5); // print "int"
foo("a"); // print "default"
```

[Back To Top](#cpp)

## Debug checklist



Undefined/Unresolved definition

- [ ] Is the **order of #include** right ? Is there a need for **forward declaration** ?

[Back To Top](#cpp)