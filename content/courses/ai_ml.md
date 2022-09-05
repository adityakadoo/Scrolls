---
title: "Artificial Intelligence and Machine Learning"
date: 2022-09-05T06:52:35+05:30
draft: false
tags: ["Machine-Learning","Computer-Science"]
math: true
---

## Probability

### Basic Terms

#### Sample Space

Sample Space $(S)$
: The set of all possible outcomes of an experiment.
$$
    P(S)=1,P(\empty)=0
$$

#### Probability Distribution

Probability Distribution $(p)$
: A function that gives the probabilities of occurence of different possible outcomes of an experiment.
$$
    p:S\rightarrow[0,1]\\\
    \sum_{x\in S}p(x)=1
$$

#### Event

Event $(E)$
: A set of outcomes of an experiement i.e. a subset of the sample space.
$$
    E\sube S
$$

#### Probability of an Event

Probability of an event $P(E)$
: The likelihood of an event happening. Mathematically given as,
$$
    P(E)=\sum_{x\in S}p(x)\\\
    P(\overline E)=1-P(E),\ \overline E=S-E
    P(E_1\cup E_2)=P(E_1)+P(E_2)-P(E_1\cap E_2)
$$

#### Expectation

Expectation $E[.]$
: For a RV $X$ on $\R$ with PMF $P$ expectation is defined as,
$$
    E[X]=\sum_xP(X=x)
$$

> **Linearity**: $E[\alpha X+\beta Y]=\alpha E[X]+\beta E[Y]$

> **MSE minimizer**: Solution for $E[(X-z)^2]$ is $z=E[X]$

> **Expectation of Product**: $E[XY]=E[X]E[Y]$

#### Variance

Varaince $\text{Var}[.]$
: For a RV $X$,
$$
    \text{Var}[X]=E[X^2]-E[X]^2
$$

> $\text{Var}[\alpha X+\beta]=\alpha^2\text{Var}[X]$

> $\text{Var}[X+Y]=\text{Var}[X]+\text{Var}[Y]$ if $X$ and $Y$ are independent

#### Covariance

Covariance $(\text{Cov}[.,.])$
: For RVs $X$ and $Y$, covariance is defined as
$$
    \text{Cov}[X,Y]=E[XY]-E[X]E[Y]
$$

> $\text{Cov}[X,X]=\text{Var}[X]$

> $\text{Cov}[X+Z,Y]=\text{Cov}[X,Y]+\text{Cov}[Z,Y]$

> $\text{Cov}[X,Y]=0 \iff X$ and $Y$ are independent

### Important Results

#### Union Bound

$$
    P(E_1\cup E_2)\le P(E_1)+P(E_2)
$$

#### Disjoint Events

$$
    P(\bigcup_{i=1}^nE_i)=\sum_{i=1}^np(x)
$$

#### Conditional Probability

For two event $E_1$ and $E_2$,
$$
    P(E_1|E_2)=\dfrac{P(E_1\cap E_2)}{P(E_2)}
$$

#### Bayes' Theorem

$$
    P(E_1|E_2)=\dfrac{P(E_2|E_1)P(E_1)}{P(E_2)}
$$

#### Marginal Distribution

For 2 random variables $X$ and $Y$ the joint distribution is $P(X,Y)$ and the probability that $X=x$ is given by,
$$
    P(X=x)=\sum_YP(X=x,Y=y)
$$

#### Independent Random Variables

$X$ and $Y$ are independent w.r.t. each other if,
$$
    P(X=x,Y=y)=P(X=x)\cdot P(Y=y)
$$


#### Chebyshev's Inequality

If $X$ is a RV with mean $\mu$ and variance $\sigma^2$ then $\forall\alpha>0$
$$
    P[|X-\mu|\ge\alpha]\le\dfrac{\sigma^2}{\alpha^2}
$$

#### Convulution

When $Z=X+Y$,
$$
    P(Z=z)=\sum_xP(X=x)P(Y=z-x)
$$

### Data to PDF

Consider a PDF $f:\R\rightarrow \R_0^+$ which needs to be found. We can generate samples from this PDF.
$$
    E_f[x^k]=\lim_{n\rightarrow\infty}\dfrac{\sum_{i=1}^NX_i^k}{N}
$$
We define the moment generating function $M(\omega)$ as,
$$
    M(\omega)=\int_{-\infty}^{\infty}e^{i\omega x}f(x)dx\\\
    =1+i\omega E[x]-\dfrac{\omega^2E[x^2]}{2!}-i\dfrac{\omega^3E[x^3]}{3!}\cdots
$$
By using the Inverse Fourier Transform we get,
$$
    f(x)=\dfrac{1}{s\pi}\int_{-\infty}^{\infty}e^{-i\omega x}M(\omega)d\omega
$$

## Linear Algebra

### Vectors and Matrices

Vector $v$
: Ordered sequence of numbers.

Linearly Independent
: A set of vectors is LI if one of them can't be reconstructed by taking linear combination of others.

Matrix $A,B,...$
: Ordered sequence of vectors.

### Linear Equations

$$
    Ax=B
$$
here $A\in\R^{m\times n}$, $x\in\R^n$ and $b\in\R^m$. This is solved using Gaussian Elimination.

### Vector Spaces

Vector Space $(\mathcal V)$
: A set of vectors qualifies as a vector space if it is closed under the operation of summation and multiplication.

Column Space $\mathcal C(A)$
: The vector space spanned by the column vectors of matrix $A$.

Null Space $\mathcal N(A)$
: Solutions of the equation $Ax=0$.

Rank $r(A)$
: The maximal number of linearly independent columns of matrix $A$.

> **Rank-Nullity Theorem**: $r(\mathcal C)=r(\mathcal N)$

> A square matrix $A$ of dimensions $n\times n$ is invertible iff $r(A)=n$

> $\lim_{k\rightarrow\infty}W^k=\dfrac{\boldsymbol{1}\boldsymbol{1}^T}{n}$ iff

$$
    \boldsymbol{1}^TW=\boldsymbol{1}^T\\\
    W\boldsymbol{1}=\boldsymbol{1}\\\
    \rho(W-\dfrac{\boldsymbol{1}\boldsymbol{1}^T}{n})<1
$$
> where $\rho(.)$ denotes the spectral radius of a matrix i.e. maximum of the absolute values of its eigenvalues.

## Loss Function Design

### Datasets

#### Training set

Train set
: The dataset on which we train the model.

#### Validation set

Validation set
: For hyper-parameter tuning

#### Test set

Test set
: For judging the model's accuracy on unseen data.

Consider a classification task where we have a dataset $D$ with $(x_i,y_i)$ values. $y_i\in\\\{-1,1\\\}$ and $x_i\in\R^d$ is the feature vector. Lets say
$$
    Y=H(X)
$$
We must find $H(.)$.

### Loss Minimization

We define a Loss Function $L(.)$ that takes a function $H:\R^d\rightarrow\\\{1,-1\\\}$ needs to be minimised.
$$
    H^*=\text{arg}_H\text{min}L(H)
$$

Following are possible examples of $L$ given by,
- General Hypothesis: $L(H) = \sum_{i\in D}\mathbb{I}(H(x_i)\ne y_i)$
- Constant Hypothesis: $L(H) = \sum_{i\in D}\mathbb{I}(c\ne y_i)$
- Linear Hypothesis: $L(H) = \sum_{i\in D}\mathbb{I}(w^Tx_i+b\ne y_i)$

Assuming Linear Hypothesis we can make following modifications:
- Linear Hypothesis with Absolute Difference:
$$
    \\\{w^&ast;,b^&ast;\\\}=\text{arg}_{w,b}\text{min}\sum_D|w^Tx_i+b-y_i|
$$
- Linear Hypothesis with Signum and Indicator Cost:
$$
    \\\{w^&ast;,b^&ast;\\\}=\text{arg}_{w,b}\text{min}\sum_D\mathbb{I}(\text{sgn}(w^Tx_i+b)\ne y_i)
$$
- Linear Hypothesis with Sigmoid Mapping:
$$
    f(x_i)=\dfrac{1}{1+e^{-(w^Tx_i+b)}}
$$
$$
    \\\{w^&ast;,b^&ast;\\\}=\text{arg}_{w,b}\text{min}\sum_D\mathbb{I}(f(x_i)\ne \dfrac{y_i+1}{2})
$$
- Linear, Sigmoid and ReLU:
$$
    \\\{w^&ast;,b^&ast;\\\}=\text{arg}_{w,b}\text{min}\sum_D\text{max}(0,(\dfrac{1}{2}-f(x_i)\cdot y_i))
$$

Another example from Probabilistic Analysis:
- Binary Cross Entropy Loss:
$$
    \\\{w^&ast;,b^&ast;\\\}=\text{arg}_{w,b}\text{min}\sum_D[-(\dfrac{y_i+1}{2})\log(f(x_i))-(1-\dfrac{y_i+1}{2})\log(1-f(x_i))]
$$

### Accounting for Noise

When $L=\sum_{i\in D}\max(0,-y_i(w^Tx_i+b))$, if $w^Tx_i+b$ takes a very small positive or negative value then the loss function should not consider this reliable as it could be the result of noise in measurement. Thus to deal with such values, we can add a $\plusmn1$ around the decision boundary.

## Regression

Consider the problem of housing price prediction. We have a feature vector with $n$ features given by the column vector $x\in\R^{n\times1}$. The price of a house is modelled by the RV $Y$. We need to find a function $f:\R^n\rightarrow\R$ that models the relation between $X$ and $Y$.

### Mean Squared Loss

Assuming Gaussian noise between $f(x_i)$ and $y_i$ we get,
$$
    y_i=f(x_i)+e_i\\\
    e_i=y_i-f(x_i)
$$
where $e\sim\mathcal{N}(0,\sigma^2)$. Maximizing the likelihood of $e_i$ we get the Mean Squared Loss.

> Similarly we get an $L_1$ Loss if we model noise as Laplacian distribution.

### Solving of Linear Regression wrt MSL

Assuming $f(x)=w^tx+b$ and,
$$
    (w^&ast;,b^&ast;)=\arg\min\sum_{i\in D}(y_i-w^tx_i-b)^2
$$

> $b^&ast;=E[Y]$

$$
    w^&ast;=\arg\dfrac{d((y-w^tx)^2)}{dw}=0
$$
On solving this we get,
> $w^&ast;=\dfrac{y}{\lambda}(I-\dfrac{xx^T}{\lambda+||x||^2_2})x$

As $\lambda\rightarrow0$ this expression doesn't give a solution. Another way of writing this solution is,

> $w^&ast;=(X^TX)^{-1}X^TY$

### Invertibility of $X^TX$

Condition number
: The ratio of minimum eigenvalue to maximum eigenvalue.
$$
    \text{Cond}(A)=\dfrac{\min(eigen(A))}{\min(eigen(A))}
$$

A high condition number means the matrix can be inverted. A way to do this is to add a factor of $\lambda I$ to the matrix $X^TX$ since this lower bounds the condition number.This is also the solution of a particular Loss function as shown below.

## Regularisation

There are different types of regularisation techniques such as:
- L1 regularisation
- L2 regularisation
- Dropout regularisation

### L2 regularisation

$$
    w^&ast;=\sum_{i\in D}(y_i-w^Tx_i)^2+\lambda||w||^2
$$

On solving we get,
$$
    w^*=(X^TX+\lambda I)^{-1}X^TY
$$

### Overfitting

Overfitting occures when the model is constrained to the training set and not able to perform well on the test set, here the gap between the training error and testing error is large.
