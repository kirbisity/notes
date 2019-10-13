# C++

[Back](../README.md)



#### Namespace

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







