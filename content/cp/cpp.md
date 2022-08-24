---
title: "C++"
date: 2022-08-20T12:27:03+05:30
draft: false
math: true
tags: ["Programming-Languages","Computer-Science"]
---

## Basic Utilities

### Initializer lists

```cpp
int values[] {1, 2, 3};
std::vector<int> v {1, 2, 4, 8, 16};
std::vector<std::string> cities {
    "Berlin", "New York", "London", "Braunschweig", "Cairo", "Cologne"
};
std::complex<double> c{4.0,3.0}; // equivalent to c(4.0,3.0)
```

### Range-based *for* loops

- Looping through a container
    ```cpp
    for (auto& elem : vec) {
        elem *= 3;
    }
    ```
- Looping through an initializer list
    ```cpp
    for (int i : {1, 2, 3, 4, 5}) {
        std::cout<< i << std::endl;
    }
    ```

### Lambda functions

```cpp
int x=0;
int y=42;
auto f1 = [=, &y] (std::string s) {
    cout<<s<<"\n";
    x++; // not very effective
    y++; // super effective
}
auto f2 = [=] (std::string s) {
    cout<<s<<"\n";
    x++; // not very effective
    y++; // not very effective
}
auto f3 = [&] (std::string s) {
    cout<<s<<"\n";
    x++; // super effective
    y++; // super effective
}
```

## STL Data types

### Pair

```cpp
std::pair<T1, T2> p(e1,e2);
```

| Operation          | Effect                                                   | Complexity       |
| ------------------ | -------------------------------------------------------- | ---------------- |
| `make_pair(e1,e2)` | Returns a pair using types and values of e1 and e2       | $\mathcal{O}(1)$ |
| `p.first`          | Returns reference to first value                         | $\mathcal{O}(1)$ |
| `p.second`         | Returns reference to second value                        | $\mathcal{O}(1)$ |
| `p1==p2`           | Returns `p1.first==p2.first && p1.second==p2.second`     | $\mathcal{O}(1)$ |
| `p1<p2`            | Compares first values and if equal second of both values | $\mathcal{O}(1)$ |
| `swap(p1,p2)`      | Swaps data of p1 and p2                                  | $\mathcal{O}(1)$ |

### Tuple

```cpp
std::tuple<T1,T2,T3,...Tk> t(e1,e2,e3,...,ek);
```

| Operation                   | Effect                                                | Complexity       |
| --------------------------- | ----------------------------------------------------- | ---------------- |
| `make_tuple(e1,e2,..., ek)` | Returns a tuple using types and values of e1, ..., ek | $\mathcal{O}(k)$ |
| `get<i>(t)`                 | Returns reference to the ith value                    | $\mathcal{O}(1)$ |
| `t1==t2`                    | Returns whether all elements of t1 are equal to t2    | $\mathcal{O}(k)$ |
| `t1<t2`                     | Compares elements of t1 and t2 lexicographically      | $\mathcal{O}(k)$ |
| `swap(t1,t2)`               | Swaps data of t1 and t2                               | $\mathcal{O}(k)$ |