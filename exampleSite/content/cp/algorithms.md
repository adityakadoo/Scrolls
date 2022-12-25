---
title: "Algorithms"
date: 2022-09-02T09:46:58+05:30
draft: false
math: true
tags: ["Computer-Science", "Math"]
---

## Numerical Methods (3)

### Ternary Search

We are given a funtion $f(x)$ which is unimodal on an interval $[l,r]$. This means it has one of the following two behaviours:

1. The function strictly increases first, reaches maximum and then strictly decreases.
2. The function strictly decreases first, reaches minimum and then strictly increases.

Here we assume the first case and find the maximum of $f(x)$ on the interval $[l,r]$.

#### Implementation

##### Iterative

```cpp
int ternary_max(int[] a, int l, int r){
    int res=0;
    while(l<=r){
        int m1 = l+(r-l)/3;
        int m2 = r-(r-l)/3;
        if(a[m1]<a[m2]){
            res = a[m2];
            l = m1+1;
        }
        else if(a[m1]>a[m2]){
            res = a[m1];
            r = m2-1;
        }
        else{
            res = a[m1];
            l = m1+1;
            r = m2;
        }
    }
    return res;
}
```

##### Recursive

```cpp
int ternary_max(int[] a, int l, int r){
    if(l==r)
        return a[0];
    int m1 = l+(r-l)/3;
    int m2 = r-(r-l)/3;
    if(a[m1]<a[m2]){
        return ternary_max(a,m1+1,r);
    else if(a[m1]>a[m2]){
        return ternary_max(a,l,m2-1);
    else
        return ternary_max(a,m1+1,m2);
}
```

#### Proof

$$n=r-l+1$$
##### Basis

If $n=1$ then $a_0$ is the only and the maximum element

##### Induction

Assuming our algorithm works for all arrays of size $\le n$. Consider an array $a$ with size $n+1$.
$$m_1 = l+\lfloor\dfrac{r-l}{3}\rfloor$$
$$m_2 = r-\lfloor\dfrac{r-l}{3}\rfloor$$
- If $a_{m_1}<a_{m_2}$ then the maximum can't lie before $m_1$ therefore the max of $a[m_1+1:r]$ is the result.
- If $a_{m_1}>a_{m_2}$ then the maximum can't lie after $m_2$ therefore the max of $a[l:m_2-1]$ is the result.
- If $a_{m_1}=a_{m_2}$ then the maximum can't lie beyond $m_1$ or $m_2$ therefore the max of $a[m_1+1:m_2]$ is the result.

In every case the new search space is of size less than $n+1$ and our algorithm will work on it.

#### Analysis
$$
    T(n)=T(2n/3)+\mathcal{O}(1)
$$
Thus time complexity is $\mathcal O(\log n)$.

### Newton's method for finding roots

Used to find root of a function $f(x)$ on some interval $[a,b]$. It is assumed that $f$ is continuous and differentiable over this interval.

#### Implementation

##### To find real square root of a number

```cpp
float sqrt(float n){
    auto f = [=] (float x){
        return x*x-n;
    };
    auto f1 = [=] (float x){
        return 2*x;
    };
    float res=n,prev=0;
    while(res-prev>1e-9){
        prev = res;
        res = res-f(res)/f1(res);
    }
    return res;
}
```

##### To find integer part of square root of a number

```cpp
int sqrt(int n) {
    int x = 1,nx=0;
    bool decreased = false;
    while(x != nx && (nx <= x || !decreased)) {
        decreased = nx < x;
        x = nx;
        nx = (x + n / x) / 2;
    }
    return x;
}
```

#### Proof

It converges towards the root with every iteration.

$$
    |x_{i+1}-\sqrt{n}|=|\dfrac{x_i+\frac{n}{x_i}}{2}-\sqrt{n}|=\dfrac{|(\sqrt{x_i}-\dfrac{\sqrt{n}}{\sqrt{x_i}})^2|}{2}\le|x_i-\sqrt{n}|
$$

#### Analysis

For $n$-digit precision requirement the complexity is $\mathcal O(n)$.

### Simpson's Formula

Used to calculate the integral of a funtion $f$ over the interval $[a,b]$.

#### Implementation

Here $f(x)$ is some pre-defined function.

```cpp
#define N 1000*1000

float integrate(float a,float b){
    float h = (b-a)/N;
    auto f = [] (float x) {...};
    float res = f(a)+f(b);
    for(int i=0;i<N;i++){
        float x = a+h*(i+1);
        if(i%2==0)
            res += f(x)*2;
        else
            res += f(x)*4;
    }
    res *= h/3;
    return res;
}
```

#### Proof

Let $n$ be some natural number. We divide the integration segment $[a,b]$ into $2n$ equal parts:
$$
    x_i=a+ih,\ i=0\dots2n,\\\ h=\dfrac{b-a}{2n}
$$ 
Now we calculate the integral separately on each of the segments $[x_{2i-2},x_{2i}$, $i=1\dots n$ and then add all the values.

So, suppose we consider the next segment $[x_{2i-2},x_{2i}]$, $i=1\dots n$. Replace the function $f(x)$ on it with a parabola $P(x)$ passing through 3 points $(x_{2i-2},x_{2i-1},x_{2i})$. Such a parabola always exists and is unique; it can be found analytically. For instance we could construct it using the Lagrange polynomial interpolation. The only remaining thing left to do is to integrate this polynomial. If you do this for a general function $f$, you receive a remarkably simple expression:
$$
    \int_{x_{2i-2}}^{x_{2i}}f(x)dx\approx\int_{x_{2i-2}}^{x_{2i}}P(x)dx=(f(x_{2i-2})+4f(x_{2i-1})+f(x_{2i}))\frac{h}{3}
$$
Adding these values over all segments, we obtain the final Simpson's formula:
$$
    \int_a^bf(x)dx\approx(f(x_0)+4f(x_1)+2f(x_2)+\cdots+4f(x_{2N-1})+f(x_{2N}))\frac{h}{3}
$$

#### Analysis

Only depends on the number of divisions thus $\mathcal O(n)$.

## Dynamic Programming (4)

## Combinatorics (10)

## Data Structures (10)

## String Processing (12)

## Linear Algebra (4)

## Geometry (23)

## Algebra (27)

## Graphs (44)

## Miscellaneous (12)