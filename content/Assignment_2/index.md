---
title: "Assignment 2"
date: 2023-09-06T09:52:31+05:30
draft: false
tags: []
description: "Aditya Kadoo(200050055), Prerak Meshram(200050110) and Shikhar Mundra(200050131)"
resources:
- name: "thumbnail"
  src: ""
toc: true
footer: false
math: true
---

## Problem 1

Assuming the image vector $f$ to be a column vector for dimensions $n\times 1$. We can define a $(n+6)\times n$ matrix using the convolution mask $w = (w_0, w_1,\dots,w_6)$ as,
$$
  W_{(n+6)\times n} = \begin{bmatrix}
    w_6 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    w_5 & w_6 & 0 & 0 & 0 & 0 & 0 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    w_4 & w_5 & w_6 & 0 & 0 & 0 & 0 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    w_3 & w_4 & w_5 & w_6 & 0 & 0 & 0 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    w_2 & w_3 & w_4 & w_5 & w_6 & 0 & 0 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    w_1 & w_2 & w_3 & w_4 & w_5 & w_6 & 0 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    w_0 & w_1 & w_2 & w_3 & w_4 & w_5 & w_6 & 0 & \cdots & 0 & 0 & 0 & 0 \\\
    0 & w_0 & w_1 & w_2 & w_3 & w_4 & w_5 & w_6 & \cdots & 0 & 0 & 0 & 0 \\\
    \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \ddots & \vdots & \vdots & \vdots & \vdots \\\
    0 & 0 & 0 & 0 & 0 & 0 & 0 & 0 & \cdots & 0 & 0 & 0 & w_6 \\\
  \end{bmatrix}
$$

Using this matrix we can define convolution as,
$$
  w\ast f\equiv W_{(n+6)\times n}\cdot f_{n\times 1}
$$
$W$ is a example of sparse diagonal band matrices called Toeplitz matrix. It has various symmetries about the centre and diagonals. Since convolution is associative, this matrix can be used to represent convolution as a transformation and can be used to compute a series of convolutions as a single convolution tranformation. Because of it's sparse nature and symmetries, it can be multiplied in $\mathcal{O}(n^2)$ and stored in $\mathcal{O}(n)$.

## Problem 2

We have,
$$
  v(x,y) = \sum_{i=0}^3\sum_{j=0}^3a_{ij}x^iy^j
  % =\begin{bmatrix}
  %   1 & x & x^2 & x^3\\\
  % \end{bmatrix}\cdot\begin{bmatrix}
  %   a_{00} & a_{01} & a_{02} & a_{03}\\\
  %   a_{10} & a_{11} & a_{12} & a_{13}\\\
  %   a_{20} & a_{21} & a_{22} & a_{23}\\\
  %   a_{30} & a_{31} & a_{32} & a_{33}\\\
  % \end{bmatrix}\cdot\begin{bmatrix}
  %   1\\\
  %   y\\\
  %   y^2\\\
  %   y^3
  % \end{bmatrix}
  = \begin{bmatrix}
    1\\\ y\\\ y^2\\\ y^3\\\
    x\\\ xy\\\ xy^2\\\ xy^3\\\
    x^2\\\ x^2y\\\ x^2y^2\\\ x^2y^3\\\
    x^3\\\ x^3y\\\ x^3y^2\\\ x^3y^3\\\
  \end{bmatrix}^T\cdot\begin{bmatrix}
    a_{00}\\\ a_{01}\\\ a_{02}\\\ a_{03}\\\
    a_{10}\\\ a_{11}\\\ a_{12}\\\ a_{13}\\\
    a_{20}\\\ a_{21}\\\ a_{22}\\\ a_{23}\\\
    a_{30}\\\ a_{31}\\\ a_{32}\\\ a_{33}\\\
  \end{bmatrix}
  = p(x,y)^T\cdot A
$$

Let $A$ be the column vector formed by the coeffcients and let $p(x,y)$ be the column vector formed by the bicubic terms. For a particular point $(x,y)$, let $\\\{(x_k,y_k):0\le k\le15\\\}$ be the set of nearest 16 grid-points that must be interpolated and $\\\{I_k:0\le k\le15\\\}$ be the corresponding intensities. 

To find the elements of matrix $A$, we can satisfy the equation for $v(x,y)$ these 16 points. This can also be done using matrix notation as,
$$
  I_{16\times 1} = \begin{bmatrix}
    I_0 & I_1 & \dots & I_{15}
  \end{bmatrix}^T,\\ \\ 
  P_{16\times 16} = \begin{bmatrix}
    p(x_0,y_0) & p(x_1,y_1) & \dots & p(x_{15}, y_{15})
  \end{bmatrix}^T
  % Y_{4\times 16} = \begin{bmatrix}
  %   1 & 1 & \dots & 1\\\
  %   y_0 & y_1 & \dots & y_{15}\\\
  %   y_0^2 & y_1^2 & \dots & y_{15}^2\\\
  %   y_0^3 & y_1^3 & \dots & y_{15}^3\\\
  % \end{bmatrix}
$$
Using this we can write,
$$
  I = P\cdot A\\\
  \implies A = P^{-1}\cdot I
$$
Here $P^{-1}$ exists because each of $P$'s rows depends on the bicubic terms of co-ordinates of distinct 16 points. These cannot be written as linear combination of each other, making it's rank 16.

## Problem 3

We have seen that the PDF of a random variable at point $(x,y)$ obtained as a sum of two RVs, is the convolution of the PDFs of the two at coordinate $(x,y)$. We can model the distribution of the original image as delta distribution such that,
$$
  \delta(s;I(x,y)) = \left\\{ \begin{array}{lr}
    0 & s\ne I(x,y)\\\
    \epsilon>0 & s = I(x,y)\\\
  \end{array}\right\\}\\\
  \\ \\\
  \int_{-\infty}^\infty \delta(s;I(x,y))\cdot ds=1 
$$

Now by convolution at $(x,y)$, we have the resultant PDF as,
$$
  p_{x,y}(u) = \int_{-\infty}^\infty \delta(s;I(x,y))\cdot \mathcal{N}(u-s;\\ 0,\sigma)\cdot ds
$$
Using the sifting property of the delta distribution,
$$
  p_{x,y}(u) = \mathcal{N}(u-I(x,y);\\ 0,\sigma)\\\
  \\ \\\
  = \mathcal{N}(u;\\ I(x,y),\sigma)
$$

Thus the PDF of the noisy image is the mean shifted Gaussian.

## Problem 4

### Part (a)

Let $[a,b,c]^T$ and $[p,q,r]$ be the vectors into which the Laplacian filter can be separated.
$$
  \therefore\begin{bmatrix}
    0 & 1 & 0\\\
    1 & -4 & 1\\\
    0 & 1 & 0\\\
  \end{bmatrix} = \begin{bmatrix}
    a\\\
    b\\\
    c\\\
  \end{bmatrix}\cdot\begin{bmatrix}
    p & q & r\\\
  \end{bmatrix} = \begin{bmatrix}
    ap & aq & ar\\\
    bp & bq & br\\\
    cp & cq & cr\\\
  \end{bmatrix}\\\
  \implies aq=1 \And bp=1\\\
  \implies apbq = 1 \text{ but } ap=0\\\
  \therefore \text{Contradiction}
$$

### Part (b)

Consider the following two 1D filters,
$$
  \begin{bmatrix}
    1\\\ -2\\\ 1\\\
  \end{bmatrix}\ast f + 
  \begin{bmatrix}
    1 & -2 & 1\\\
  \end{bmatrix}\ast f\\\
$$
Convolution is distributive over addition,
$$
  = \left(\begin{bmatrix}
    1\\\ -2\\\ 1\\\
  \end{bmatrix} + 
  \begin{bmatrix}
    1 & -2 & 1\\\
  \end{bmatrix}\right)\ast f\\\
$$
By adding zero-padding to the filters,
$$
  = \left(\begin{bmatrix}
    0 & 1 & 0\\\
    0 & -2 & 0\\\
    0 & 1 & 0\\\
  \end{bmatrix} + 
  \begin{bmatrix}
    0 & 0 & 0\\\
    1 & -2 & 1\\\
    0 & 0 & 0\\\
  \end{bmatrix}\right)\ast f\\\
  \\ \\\
  = \begin{bmatrix}
    0 & 1 & 0\\\
    1 & -4 & 1\\\
    0 & 1 & 0\\\
  \end{bmatrix}\ast f\\\
$$
Hence we can derive the Laplacian filter using these two 1D convolutions.

## Problem 5
Let $A$ be the mean-filter of size $(2a+1)\times(2a+1)$ and f is the image(assumed to infinitely zero-padded). On applying convolution once we get,
$$\hat f = A\ast f$$
Repeating this $k$ times gives,
$$
  \hat f=A\ast(\cdots(K\text{ times})\cdots A\ast(A\ast(A\ast f))\cdots)
$$
Since convolution is associative,
$$
  \hat f=(A\ast A\cdots(K\text{ times})\cdots A)\ast f\\\
  \\ \\\
  \hat f=A_K\ast f 
$$
This shows that $A_K=(A\ast A\cdots(K\text{ times})\cdots\ast A)$ is a convolution operator that can be used for $K$ applications of any filter $A$.

As the mean-filter (with zero padding) corresponds to the 2-dimensional uniform PDF, it's K convolutions with itself will correspond to the PDF of sum of $K$ discrete uniform i.i.d. random variables. Since the 2D uniform distribution is the product of two 1D uniform distributions in $x$ and $y$, the PDF after $K$ convolutions in 2D is simply the product of the resulting PDF at both coordinates in 1D after $K$ convolutions. The PDF at n after K convolutions of 1D uniform distribution between $-a$ to $a$ is,
$$
  P_K(n;-a,a) = \text{Coefficient of }x^n\text{ in }\frac{(x^{2a+1}-1)^K}{(x-1)^K\cdot x^{aK}\cdot (2a+1)^K}\\\
  \\ \\\
$$
Using this we can define the convolution mask $A_K = [A_{ij}]$ of size $(2Ka+1)\times (2Ka+1)$ where,
$$
  A_{ij} = P_K(i-Ka;-a,a)\cdot P_K(j-Ka;-a,a),\\ \\ \forall 0\le i,j\le 2Ka
$$

## Problem 6
Given intensity function,
$$
  I(x)=cx+d
$$
On applying Gaussian filter,
$$
J(x;\sigma) = \int_{-\infty}^\infty I(i)\cdot\mathcal{N}(i;x,\sigma)\cdot di\\\
\\ \\\
= c\cdot\int_{-\infty}^\infty i\cdot\mathcal{N}(i;x,\sigma)\cdot di+d
= cx+d
$$
On applying bilateral filter,
$$
  K(x;\sigma_s,\sigma_r) = \frac{\int_{-\infty}^\infty I(i)\cdot\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}(I(x)-I(i);0,\sigma_r)\cdot di}{\int_{-\infty}^\infty\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}(I(x)-I(i);0,\sigma_r)\cdot di}\\\
  \\ \\\
  = \frac{\int_{-\infty}^\infty I(i)\cdot\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}((cx+d)-(ci+d);0,\sigma_r)\cdot di}{\int_{-\infty}^\infty\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}((cx+d)-(ci+d);0,\sigma_r)\cdot di}\\\
  \\ \\\
  = \frac{\int_{-\infty}^\infty I(i)\cdot\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}(c(x-i);0,\sigma_r)\cdot di}{\int_{-\infty}^\infty\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}(c(x-i);0,\sigma_r)\cdot di}\\\
  \\ \\\
  = \frac{\int_{-\infty}^\infty I(i)\cdot\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}(i;x,\sigma_r/c)\cdot di}{\int_{-\infty}^\infty\mathcal{N}(i;x,\sigma_s)\cdot\mathcal{N}(i;x,\sigma_r/c)\cdot di}\\\
  \\ \\\
  = \frac{\int_{-\infty}^\infty I(i)\cdot\mathcal{N}(i;x,\sigma_s\sigma_r/\sqrt{c^2\sigma_s^2+\sigma_r^2})\cdot di}{\int_{-\infty}^\infty\mathcal{N}(i;x,\sigma_s\sigma_r/\sqrt{c^2\sigma_s^2+\sigma_r^2})\cdot di}\\\
  \\ \\\
  = J(x;\sigma_s\sigma_r/\sqrt{c^2\sigma_s^2+\sigma_r^2}) = cx+d
$$
Here we have used the result that product of two Gaussian distributions $\mathcal{N}(\mu_1,\sigma_1)$ and $\mathcal{N}(\mu_2,\sigma_2)$ is another Gaussian distribution $\mathcal{N}\left(\frac{\sigma_1^2\mu_2+\sigma_2^2\mu_1}{\sigma_1^2+\sigma_2^2},\frac{\sigma_1\sigma_2}{\sqrt{\sigma_1^2+\sigma_2^2}}\right)$.

## Problem 7
Relationship between given coordinate systems,
$$
  u = x\cos\theta-y\sin\theta,\\\
  v = x\sin\theta+y\cos\theta\\\
$$
$$
  \therefore x = u\cos\theta+v\sin\theta,\\\
  y = -u\sin\theta+v\cos\theta\\\
$$
For any image $f$ on taking gradient in the 2 coordinate systems and equating them,
$$
  \nabla f = \frac{\partial f}{\partial x}\hat i+\frac{\partial f}{\partial y}\hat j = \frac{\partial f}{\partial u}\hat u+\frac{\partial f}{\partial v}\hat v\\\
$$
Gradient can be [defined only using the scalar field](https://proofwiki.org/wiki/Definition:Gradient_Operator/Geometrical_Representation) on which it operates, making it independent of the co-ordinate system.
On equating components along x and y directions,
$$
  \frac{\partial f}{\partial x}
  % = \frac{\partial f}{\partial u}\frac{\partial u}{\partial x}+\frac{\partial f}{\partial v}\frac{\partial v}{\partial x}
  = \frac{\partial f}{\partial u}\cos\theta+\frac{\partial f}{\partial v}\sin\theta\\\
  \\ \\\
  \frac{\partial f}{\partial y}
  % = \frac{\partial f}{\partial u}\frac{\partial u}{\partial y}+\frac{\partial f}{\partial v}\frac{\partial v}{\partial y}
  = -\frac{\partial f}{\partial u}\sin\theta+\frac{\partial f}{\partial v}\cos\theta\\\
$$
Substituting $\frac{\partial f}{\partial x}$ as $f$ in the above equation,
$$
  \frac{\partial^2f}{\partial x^2}=\frac{\partial}{\partial x}\left(\frac{\partial f}{\partial x}\right)
  % =\frac{\partial}{\partial u}\left(\frac{\partial f}{\partial x}\right)\frac{\partial u}{\partial x}+\frac{\partial}{\partial v}\left(\frac{\partial f}{\partial x}\right)\frac{\partial v}{\partial x}\\\
  % \\ \\\
  =\frac{\partial}{\partial u}\left(\frac{\partial f}{\partial x}\right)\cos\theta+\frac{\partial}{\partial v}\left(\frac{\partial f}{\partial x}\right)\sin\theta\\\
  \\ \\\
  = \frac{\partial^2f}{\partial u^2}\cos^2\theta+\frac{\partial^2f}{\partial v^2}\sin^2\theta+2\frac{\partial^2f}{\partial u\partial v}\sin\theta\cos\theta
$$
Similarly for $y$,
$$
  \frac{\partial^2f}{\partial y^2}=\frac{\partial}{\partial y}\left(\frac{\partial f}{\partial y}\right)
  % =\frac{\partial}{\partial u}\left(\frac{\partial f}{\partial x}\right)\frac{\partial u}{\partial x}+\frac{\partial}{\partial v}\left(\frac{\partial f}{\partial x}\right)\frac{\partial v}{\partial x}\\\
  % \\ \\\
  =-\frac{\partial}{\partial u}\left(\frac{\partial f}{\partial y}\right)\sin\theta+\frac{\partial}{\partial v}\left(\frac{\partial f}{\partial y}\right)\cos\theta\\\
  \\ \\\
  =\frac{\partial^2f}{\partial u^2}\sin^2\theta+\frac{\partial^2f}{\partial v^2}\cos^2\theta-2\frac{\partial^2f}{\partial u\partial v}\sin\theta\cos\theta
$$
Adding the two results,
$$
  \frac{\partial^2f}{\partial x^2} + \frac{\partial^2f}{\partial y^2} = \frac{\partial^2f}{\partial u^2} + \frac{\partial^2f}{\partial v^2}\\\
  \\ \\\
  \implies f_{xx}+f_{yy} = f_{uu}+f_{vv}
$$

## Problem 8

### Gaussian Noise with 5 Stdev

#### Barbara ($\sigma = 5$)

| Original | Noisy |
|---|---|
|![barbara_5_orignal](./images/barbara256.png)|![barbara_5_noisy](images/barbara_5_noisy.png)|

|$(\sigma_s,\sigma_r)=(0.1,0.1)$|$(\sigma_s,\sigma_r)=(2,2)$|$(\sigma_s,\sigma_r)=(3,15)$|
|---|---|---|
|![barbara_5_01_01](images/barbara_5_01_01.png)|![barbara_5_2_2](images/barbara_5_2_2.png)|![barbara_5_3_15](images/barbara_5_3_15.png)|

#### Kodak ($\sigma = 5$)

| Original | Noisy |
|---|---|
|![kodak_5_orignal](./images/kodak24.png)|![kodak_5_noisy](images/kodak_5_noisy.png)|

|$(\sigma_s,\sigma_r)=(0.1,0.1)$|
|---|
|![kodak_5_01_01](images/kodak_5_01_01.png)|

|$(\sigma_s,\sigma_r)=(2,2)$|
|---|
|![kodak_5_2_2](images/kodak_5_2_2.png)|

|$(\sigma_s,\sigma_r)=(3,15)$|
|---|
|![kodak_5_3_15](images/kodak_5_3_15.png)|

### Gaussian Noise with 10 Stdev

#### Barbara ($\sigma = 10$)

| Original | Noisy |
|---|---|
|![barbara_10_orignal](./images/barbara256.png)|![barbara_10_noisy](images/barbara_10_noisy.png)|

|$(\sigma_s,\sigma_r)=(0.1,0.1)$|$(\sigma_s,\sigma_r)=(2,2)$|$(\sigma_s,\sigma_r)=(3,15)$|
|---|---|---|
|![barbara_10_01_01](images/barbara_10_01_01.png)|![barbara_10_2_2](images/barbara_10_2_2.png)|![barbara_10_3_15](images/barbara_10_3_15.png)|

#### Kodak ($\sigma = 10$)

| Original | Noisy |
|---|---|
|![kodak_10_orignal](./images/kodak24.png)|![kodak_10_noisy](images/kodak_10_noisy.png)|

|$(\sigma_s,\sigma_r)=(0.1,0.1)$|
|---|
|![kodak_10_01_01](images/kodak_10_01_01.png)|

|$(\sigma_s,\sigma_r)=(2,2)$|
|---|
|![kodak_10_2_2](images/kodak_10_2_2.png)|

|$(\sigma_s,\sigma_r)=(3,15)$|
|---|
|![kodak_10_3_15](images/kodak_10_3_15.png)|

### Observations

For $\sigma=5$ noisy images,
- For both Barbara and Kodak images $(0.1,0.1)$ bilateral filter doesn't cause much difference.
- Although it's subjective, best results seem to be for the $(2,2)$ bilateral filter. This can be seen for the resulting Kodak image as it resembles the original Kodak image closely.
- For both images, $(3,15)$ bilateral filter leads to too much smoothing and loss of details compared to the original image.

For $\sigma=10$ noisy images,
- Both the $(0.1,0.1)$ and $(2,2)$ filters seem to be too weak.
- The $(3,15)$ filter produces the best results but there is still some loss of finer details.

## Problem 9

### LC1 results

|Orignal Image|Global HE|
|---|---|
|![LC1_orignal](images/LC1.png)|![LC1_global](images/global_1.png)|


|Local HE with $7\times 7$ filter|Local HE with $31\times 31$ filter|
|---|---|
|![LC1_7](images/local_1_7.png)|![LC1_31](images/local_1_31.png)|

|Local HE with $51\times 51$ filter|Local HE with $71\times 71$ filter|
|---|---|
|![LC1_51](images/local_1_51.png)|![LC1_71](images/local_1_71.png)|

### LC2 results

|Orignal Image|Global HE|
|---|---|
|![LC2_orignal](images/LC2.jpg)|![LC2_global](images/global_2.png)|


|Local HE with $7\times 7$ filter|Local HE with $31\times 31$ filter|
|---|---|
|![LC2_7](images/local_2_7.png)|![LC2_31](images/local_2_31.png)|

|Local HE with $51\times 51$ filter|Local HE with $71\times 71$ filter|
|---|---|
|![LC2_51](images/local_2_51.png)|![LC2_71](images/local_2_71.png)|

### Observations

- Compared to the results from the inbuilt Global Histogram Equalizer in Matlab, the results of Local Histogram equalization seem to be more noisy at places such as the sky but manage to capture many more details of things that are far away from the camera.
- The results for Local HE with $7\times 7$ filter are too noisy to observe any details.
- For the $31\times 31$ filter the results for the both the images are still very noisy to differentiate distinct objects.
  - For example in LC1 the trees in the foreground and the houses behind them get blured out.
  - In LC2, the branches for trees are visible but it is difficult to see which tree a branch belongs to.
- The results for the $51\times 51$ and $71\times 71$ are both pretty good. First one having more deeper details whereas the later showing depth better.
  - This can be seen in LC2. In $51\times 51$ filter result more branches can be seen (less sky).
  - In the $71\times 71$ filter result, we can differentiate better between trees in foreground and background.
