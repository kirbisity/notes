# C++

[Back](../README.md)

[https://en.cppreference.com](https://en.cppreference.com/)

### List of Contents

C and C++

* [Preprocessor Directives](#preprocessor-directives)
* [Class](#class)
* [Namespace](#namespace)
* [Template](#template)
* [Smart Pointer](#smart-pointer)

Testing

* [Google Mock](#google-mock)

Other

* [Debug Checklist](#debug-checklist)

  

## Preprocessor directives

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

[Back To Top](#c\+\+)

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
    Vehicle* foo() { 
      Car c;
    return &c;
    }
    ```
    
  * The reverse is not true.

  * If it is necessary to use a derived class pointer to point to base instance, use `dynamic_cast`

    ```c++
    Car* foo
    <type> *p_subclass = dynamic_cast<<type> *>( p_obj );
    ```

    

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

* Defines a container/scope
* Mitigates name collision in large projects
* Never use `using namespace` in header file

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

* Ideally less than 5 nestings

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

* function resolution looks up name first

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



## Smart Pointer

* Cannot be used as elements of a container
* Difficult to use as class members
* exception-safe

#### Not smart raw Pointer

* represent access to an object

  ```c++
  X* x_p = new X();
  x_p->fun(); // if anything throws an exception before delete, memory leak
  delete x_p;
  ```

#### std::unique_ptr\<T>

* the **sole owner** of a memory resource

* will hold a pointer and **delete** it in its destructor

  ```c++
  std::unique_ptr<X> x_p(new X());
  std::unique_ptr<X> y_p(x_p); // y_p now owns the object, x_p no longer own anything
  std::unique_ptr<X> z_p = y_p; // z_p now owns the object, y_p no longer own anything
  (*z_p).fun(); // operator* can be used
  z_p.reset(); // will destroy the object
  ```

* When a unique pointer is copy-constructed. The ownership will transfer and the original unique pointer points to nothing.

* If the object should not be modified, use  `std::unique_ptr<const X>`

* http://www.cplusplus.com/reference/memory/unique_ptr/



Reference: https://www.fluentcpp.com/2017/08/25/knowing-your-smart-pointers/



## Google Mock

* In unit-testing, control the dependencies of the subject-under-test, so that external influences like network connectivity or database issues etc. will not affect test result.

* Replace real components with doubles.

* Doubles are often written as derived classes of the SUT class

  ```C++
  class SUTDouble : public SUT { ... }
  
  TEST() {
    // GIVEN
    SUTFake s;
    // WHEN
    s.fun(1);
    // THEN
    ASSERT ...;
  }
  ```

* Types of doubles

  * Dummy

    * Be an argument to function just to let the test compile

  * Stub

    * Interact minimally, return the correct value

      ```c++
      class SUTStub : public SUT {
        public:
      	  int fun(int i) { return 10; }
      }
      ```

  * Fake

    * Contain fake data

      ```c++
      class SUTFake : public SUT {
        public:
      	  int fun(int i) { return d_date[i]; }
        private:
          vector<int> d_data;
      }
      ```

  * Spy

    * Observes the interaction and report it at the end of the test

      ```C++
      class SUTSpy : public SUT {
        public:
        vector<int> d_obervations;
      	  int fun(int i) { 
            d_obervations.push_back(i);
            return d_date[i]; 
          }
        private:
          vector<int> d_data;
      }
      ```

  * Mock

    * In the test, expectation will be made of how SUT will interact with mock

      ```C++
      class SUTMock : public SUT {
        public:
          MOCK_METHOD1(fun, int(int));
      }
      
      //GIVEN
      EXPECT_CALL(s, fun(1))
        .WillOnce(Return(10));
      ```

* Google Mock Expectations

  * Create mock class by inheriting from SUT class

  * Use `MOCK_ …` macros

  * Set up expectations using `EXPECT_CALL`

  * Failure to meet expectations is failure

  * Test the SUT, not the mock

  * Example

    ```c++
    #include <gmock/gmock.h>
    class SUTMock : public SUT {
      public:
        MOCK_METHOD1(fun, int(int));
    }
    ```

* Matchers

  * Decide when an expectation is met

  * First matching expectation is matched. Not the most specific one.

  * Matching order is from bottom-up. Reverse order of addition

  * Example

    ```c++
    // GIVEN
    EXPECT_CALL(s, )
    ```

* Cardinality & Actions

  * Cardinalirt is the expectation of number of times matched

  * Expectation do not retire automatically on saturation

  * `WillOnce` connects the expectation with it's actions

    ```c++
    EXPECT_CALL(s, fun(_))
      .Times(3)
      .WillOnce(Return(4)) // for the first match, 4 will be returned
      .WIllOnce(Return(5)) // for the second, 5
      .WillOnce(Return(6)); // third, 6
    ```

  * `WillRepeatedly` expect the same action to be done repeatedly

    ```c++
    EXPECT_CALL(s, fun(_))
      .Times(3)
      .WillRepeatedly(Return(6))
    ```

  * `RetiresOnSaturation` remove an expectation when its cardinality limit is reached

    





## Debug Checklist



Undefined/Unresolved definition

- [ ] Is the **order of #include** right ? Is there a need for **forward declaration** ?

[Back To Top](#cpp)