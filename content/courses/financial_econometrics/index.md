---
title: "Financial Econometrics"
date: 2023-08-24T18:31:59+05:30
draft: true
math: true
tags: ["Economics"]
description: "Notes from EC-638 course at IIT Bombay"
resources:
- name: thumbnail
  src: 
toc: true
footer: true
---

## CLRM

### 7 Assumptions

1. Linear regression model on $\\\{x_i,y_i\\\}_{i=1}^N$:
  $$
    Y_i=\beta_1+\beta_2\cdot X_i+\epsilon_i
  $$
2. $X$ independent of error terms:
  $$
    \text{cov}(X_i,\epsilon_i)=0
  $$
3. Zero mean error:
  $$
    \mathbb{E}[\epsilon_i|X_i]=0
  $$
4. Homoscedasticity of error:
  $$
    \text{var}(u_i) = \sigma^2_{\text{const w.r.t. }X_i}
  $$
5. No autocorrelation in errors:
  $$
    \text{cov}(u_i,u_j|X_i,X_j)=0
  $$
6. Number of samples:
  $$
    \dim(\beta_2)+1 < N
  $$
7. Nature of samples:
  $$
    \text{var}(X)>0
  $$

### Estimates

$$
  \hat\beta_2 = \frac{\text{cov}(X,Y)}{\text{var}(X)}\\\
  \\ \\\
  \hat\beta_1 = \bar Y - \hat\beta_2\cdot\bar X\\\
  \\ \\\
  \sum\hat u_i^2 = \sum y_i^2 - \frac{\left(\sum x_iy_i\right)^2}{\sum x_i^2}\\\
  \\ \\\
  \hat\sigma = \sqrt{\frac{\sum\hat u_i^2}{N-2}}
$$

### BLUE

**Best Linear Unbiased Estimator [BLUE]**
: - It is linear, that is, a linear function of a random variable, such as the dependent variable $Y$ in the regression model.
  - It is unbiased, that is, its average or expected value, $\mathbb{E}[\beta_2]$, is equal to the true value, $\beta_2$.
  - It has minimum variance in the class of all such linear unbiased estimators; an unbiased estimator with the least variance is known as an efficient estimator.

> **Gauss-Markov Theorem** : Given the assumptions of the classical linear regression model, the least-squares estimators, in the class of unbiased linear estimators, have minimum variance, that is, they are BLUE.

## Multicollinearity