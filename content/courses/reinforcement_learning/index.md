---
title: "Reinforcement Learning"
date: 2023-09-13T14:47:25+05:30
draft: true
math: true
tags: [Computer-Science, Machine-Learning]
description: "Notes for CS 747"
resources:
- name: thumbnail
  src: 
toc: true
footer: true
---

## Multi-armed Bandits

**Stochastic Multi-armed Bandits**
: - $A$ is the set of $n$ arms
  - $\forall a\in A$, $a$ has an associated Bernoulli distribution with mean reward $p_a$
  - Highest mean is $p^\star$
  - Pull any arm to gain reward and repeat this $T$ (horizon) times

**Algorithm for maximising reward**
: For $t=0,1,2,\dots,T-1$:
  - Given the *history* $h^t=(a^0,r^0,a^1,r^1,\dots,a^{t-1},r^{t-1})$
  - Pick an *arm* $a^t$
  - Obtain the *reward* $r^t$

**Deterministic Algorithm**
: Set of all histories $\to A$

**Randomized Algorithm**
: Set of all histories $\to \Delta A$ a.k.a. set of all probability distributions over $A$

### $\epsilon$-greedy Algorithms

**$\epsilon$-G1**
: - $t\le\epsilon T\implies$ sample uniformly at random
  - $t=\lfloor\epsilon T\rfloor\implies$ identify $a^\star$ with the highest empirical mean
  - $t>\epsilon T\implies$ sample $a^\star$

**$\epsilon$-G2**
: - $t\le\epsilon T\implies$ sample uniformly at random
  - $t>\epsilon T\implies$ sample arm with highest empirical mean

**$\epsilon$-G3**
: With probability $\epsilon$ sample uniformly at random; with probability $1-\epsilon$ sample an arm with the highest empirical mean

### Regret

> Consider the plot of $\mathbb{E}[r^t]$ vs $t$.
> It must be bounded between $y=p_{\min}=\min_{a\in A}p_a$ and $y=p^\star$.
> On random uniform sampling of arms the graph will be $y=p_{\text{avg}}=\frac{1}{n}\sum_{a\in A}p_a$.
> A reasonable learning algorithm will start at $p_{\text{avg}}$ and tend towards $p^\star$

**Regret**
: For horizon $T$ and given algorithm,
$$
  R_T = Tp^\star - \sum_{t=0}^{T-1}\mathbb{E}[r^t]
$$

> **Goal** : Find an algorithm for which $\lim_{T\to\infty}\frac{R_T}{T}=0$.
> All $\epsilon$-Gi's have linear regret.

How to achieve Sub-linear Regret?
1. **Infinite Exploration**: In the limit, each arm must be pulled an infinite number of times.
2. **Greed in the Limit**: Let $\text{exploit}(T)$ denote the number of pulls that are greedy w.r.t. the empirical mean up to the horizon $T$. We want,
  $$
    \lim_{T\to\infty}\frac{\mathbb{E}[\text{exploit}(T)]}{T}=1
  $$

**Special Bandit Instances** ($\bar{\mathcal{I}}$)
: Set of all bandit instances with reward means $\le 1$

> **Result** : An algorithm $L$ achieves sub-linear regret on all instances $I\in\bar{\mathcal{I}}$ $\iff$ $L$ does infinite exploration and is greedy in the limit.

#### Lower bound on Regret

> **Lai and Robbins' theorem** : Let $L$ be an algorithm such that $\forall I\in\bar{\mathcal{I}}$ and $\forall\alpha>0$, as $T\to\infty$,
> $$R_T(L,I)=\mathcal{o}(T^\alpha)$$
>
> Then $\forall I\in\bar{\mathcal{I}}$, as $T\to\infty$:
> $$\frac{R_T(L,I)}{\ln(T)}\ge\sum_{a:p_a(I)\not =p^\star(I)}\frac{p^\star(I)-p_a(I)}{KL(p_a(I),p^\star(I))}$$
> where for $x,y\in[0,1), KL(x,y)=x\ln\frac{x}{y}+(1-x)\ln\frac{1-x}{1-y}$

### Optimal Regret Algorithms

#### UCB Algorithm

- At time $t$ for every arm $a$,
  $$
    \text{ucb}^t_a = \hat p^t_a + \sqrt{\frac{2\ln(t)}{u^t_a}}
  $$
- $\hat p^t_a$ is the empirical mean of the rewards from arm $a$ and $u^t_a$ is the number of times a has been sampled at time $t$.
- Pull an arm $a$ for which $\text{ucb}^t_a$ is maximum.

> UCB achieves $\mathcal{O}(\log(T))$ regret.

#### KL-UCB Algorithm

- Define, where $c\ge 3$,
  $$
    \text{ucb-kl}^t_a = \max\\\{q\in[\hat p^t_a,1]\\ |\\ u^t_a\cdot \text{KL}(\hat p_a^t,q)\le\ln(t)+c\ln(\ln(t))\\\}
  $$
- Pull $\argmax_{a\in A}\text{ucb-kl}^t_a$

#### Thompson Sampling

- For every arm $a$ with $s_a^t$ successful pulls and $f_a^t$ failed pulls draw a sample,
  $$
    x_a^t\sim\text{Beta}(s_a^t+1,f_a^t+1)
  $$
- Pull arm $a$ with max $x_a^t$

> Both KL-UCB and Thompson Sampling manage to get optimal regret.

### Bound on UCB Regret

## Markov Decision Problems

**Markov Decision Problem** $\langle S,A,T,R,\gamma\rangle$
: - **Set of states**: $S=\\\{s_1,s_2,\dots,s_n\\\}$
  - **Set of actions**: $A=\\\{a_1,a_2,\dots,a_k\\\}$
  - **Transition function**: $T(s,a,s^\prime)$ is the probability of reaching $s^\prime$ by starting at $s$ and taking action $a$. Hence $\forall s\in S,\forall a\in A,\\ \sum_{s^\prime\in S}T(s,a,s^\prime)=1$.
  - **Reward function**: $T(s,a,s^\prime)$ is the reward on reaching $s^\prime$ by starting at $s$ and taking action $a$. Assuming all rewards are from $[-R_{\max},R_{\max}]$ where $R_{\max}\ge 0$.
  - **Discount factor**: $\gamma$

**Policy** ($\pi$)
: $\pi:S\to A$

> If $\Pi$ is the set of all policies then $|\Pi|=k^n$

**State values for Policy** ($V^\pi$)
: For $s\in S$, $V^\pi:S\to\R$,
  $$
    V^\pi(s)=\mathbb{E}_\pi[r^0+\gamma r^1+\gamma^2r^2+\dots|s^0=s]
  $$

> Every MDP has an optimal policy $\pi^\star$ such that,
> $$
>   \forall\pi\in\Pi,\forall s\in S:V^{\pi^\star}(s)\ge V^\pi(s)
> $$
>
> **MDP Planning Problem** : Find $\pi^\star$.

### Bellman Equations

> For $\pi\in\Pi,s\in S$,
> $$
>   V^\pi(s) = \sum_{s^\prime\in S}T(s,\pi(s),s^\prime)\\\{R(s,\pi(s),s^\prime)+\gamma V^\pi(s^\prime)\\\}
> $$
> - $n$ equations $n$ variables
> - linear
> - Guaranteed solution for $\gamma<1$

Therefore brute-force way of finding the state values for all $k^n$ possible policies and then picking the most dominant one is possible but has $\mathcal{O}(\text{poly}(n,k)\cdot k^n)$ time complexity.

#### Episodic Tasks

**Episodic Task**
: - Has a new terminal state $s_\top$ from which there are no out going transitions on rewards.
  - For every non-terminal state and every policy there is a non-zero probability of reaching the terminal state in a finite number of steps.

##### Definition of values

**Infinite discounted reward**
: $V^\pi(s)=\mathbb{E}_\pi[r^0+\gamma r+\gamma^2r^2+\dots|s^0=s]$

**Total reward**
: $V^\pi(s)=\mathbb{E}_\pi[r^0+r^1+\dots+|s^0=s]$

**Finite horizon reward**
: $V^\pi(s)=\mathbb{E}_\pi[r^0+r^1+\cdots+r^{H-1}|s^0=s]$ where $H\ge 1$

**Average reward**
: $V^\pi(s)=\mathbb{E_{\pi}}[\lim_{m\to\infty}\frac{r^0+r^1+\cdots+R^{m-1}}{m}|s^0=s]$

### Optimal Policy Characterization

#### Banach's Fixed-point Theorem

**Banach Space** ($X$)
: A complete, normed vector space
  - **Vector space**: $X$
  - **Norm**: $\\|\cdot\\|$
  - **Complete**: $(X,\\|\cdot\\|)$ such that every Cauchy sequence has a limit in $X$

**Contraction mapping** ($Z,l$)
: $Z:X\to X$ with contraction factor $0\le l<1$ such that, $\forall u\in X,\forall v\in X,$
$$
  \\|Zv-Zu\\|\le l\\|v-u\\|
$$

**Fixed-point** ($x^\star$)
: For $Z$, such that $Zx^\star=x^\star$

> **Banach's Fixed-point Theorem** : For a contraction map $Z$ with contraction factor $l$ in a Banach space $(X,\\|\cdot\\|)$,
> 1. $Z$ has a unique fixed point $x^\star\in X$
> 2. For $x\in X,m\le 0:\\|Z^mx-x^\star\\|\le l^m\\|x-x^\star\\|$

#### Bellman Optimality Operator

**Bellman optimality operator** ($B^\star$)
: $B^\star:\R^n\to\R^n$ for an MDP is defined for $F\in\R^n,s\in S$ as,
$$
  (B^\star(F))(s) = \max_{a\in A}\sum_{s^\prime\in S}T(s,a,s^\prime)\\\{R(s,a,s^\prime)+\gamma F(s^\prime)\\\}
$$

**Max norm** ($\\|\cdot\\|_\infty$)
: For $F=(f_1,f_2,\dots,f_n)\in\R^n$,
$$
  \\|F\\|_\infty=\max\\\{|f_1|,|f_2|,\dots,|f_n|\\\}
$$

> **Result** : $(\R^n,\\|\cdot\\|_\infty)$ is a Banach space.
>
> $\therefore B^\star$ is a contraction map in $(\R^n,\\|\cdot\\|_\infty)$ with contraction factor $\gamma$.

**Optimal Value Function** $(V^\star)$
: Denote the fixed point $V^\star:S\to\R$ (alternatively, $V^\star\in\R^n$) such that $B^\star(V^\star)=V^\star$. For $s\in S$,
$$
  V^\star(s)=\max_{a\in A}\sum_{s^\prime\in S}T(s,a,s^\prime)\\\{R(s,a,s^\prime)+\gamma V^\star(s^\prime)\\\}
$$

### Optimal Policy Algorithms

#### Value Iteration

1. $V_0\leftarrow$ Arbitrary, element-wise bounded, $n$-length vector.
2. $t\leftarrow 0$
3. Repeat:
   1. For $s\in S$:
      1. $V_{t+1}(s)\leftarrow\max_{a\in A}\sum_{s^\prime\in S}T(s,a,s^\prime)(R(s,a,s^\prime+\gamma V_t(s^\prime)))$
   2. $t\leftarrow t+1$
4. Until $V_t\equiv V_{t-1}$

#### Linear Programming Formulation

**Vector Comparison** ($\succeq,\succ$)
: - For $X:S\to\R$ and $Y:S\to\R$ (equivalently $X,Y\in\R^n$) we define,
    $$
      X\succeq Y\iff \forall s\in S:X(s)\ge Y(s)\\\
      X\succ Y\iff X\succeq Y\And\exist s\in S:X(s)>Y(s)
    $$
  - For policies $\pi_1,\pi_2\in\Pi$ we define,
    $$
      \pi_1\succeq\pi_2\iff V^{\pi_1}\succeq V^{\pi_2}\\\
      \pi_1\succ\pi_2\iff V^{\pi_1}\succ V^{\pi_2}\\\
    $$
  - 2 policies can also be *incomparable* i.e. $\pi_1\not\succeq\pi_2$ and $\pi_2\not\succeq\pi_1$
  - $\pi_1\succeq\pi_2$ and $\pi_2\succeq\pi_1\iff V^{\pi_1}=V^{\pi_2}$

> **Result** : $B^\star$ preserves $\succeq$. $\forall X,Y:S\to\R^n$,
> $$
>   X\succeq Y\implies B^\star(X)\succeq B^\star(Y)
> $$
>
> $\therefore$ For all $V\not =V^\star$ in the feasible set, $V\succ V^\star$.
> $$
>   \implies\sum_{s\in S}V(s)>\sum_{s\in S}V^\star(s)
> $$

**Linear Programming Formulation**
: - Maximise $\left(-\sum_{s\in S}V(s)\right)$,
  - Subject to $V(s)\ge\sum_{s^\prime\in S}T(s,a,s^\prime)\\\{R(s,a,s^\prime)+\gamma V(s^\prime)\\\},\\ \forall s\in S,a\in A$.

> This LP has $n$ variables and $nk$ constraints and the solution is $V^\star$.
> The dual of this LP has nk variables with $n$ constraints and it's solution is $\pi^\star$.

#### Policy Improvement

**Action Value Function** ($Q^\pi:S\times A\to\R$)
: For $\pi\in\Pi,s\in S,a\in A$,
  $$Q^\pi(s,a)=\mathbb{E}[r^0+\gamma r^1+\gamma^2r^2+\dots|s^0=s;a^0=a;a^t=\pi(s^t),\\ \forall t\ge1$$

> For $s\in S,a\in A$,
> $$
>   Q^\pi(s,a) = \sum_{s^\prime\in S}T(s,a,s^\prime)\\\{R(s,a,s^\prime)+\gamma V^\pi(s^\prime)\\\}
> $$
>
> $Q^\pi(s,\pi(s))=V^\pi(s)$
>
> All optimal policies have the same optimal action value function $Q^\star$.

$\text{IA}:\Pi\times S\to \mathcal{P}(A)$
: For $\pi\in\Pi,s\in S$,
  $$\text{IA}(\pi,s)=\\\{a\in A:Q^\pi(s,a)>V^\pi(s)\\\}$$

$\text{IS}:\Pi\to\mathcal{P}(S)$
: For $\pi\in\Pi$,
  $$\text{IS}(\pi)=\\\{s\in S:|\text{IA}(\pi,s)|\ge 1\\\}$$

> **Policy Improvement Theorem** :
> 1. If $\text{IS}(\pi)=\emptyset$ then $\pi$ is an optimal policy, else
> 2. if $\pi^\prime$ is obtained by policy improvement on $\pi$, then $\pi^\prime\succ\pi$.
>
> $\text{IS}(\pi^\star)=\emptyset\iff B^\star(V^{\pi^\star})=V^{\pi^\star}$

**Bellman Operator** ($B^\pi:\R^n\to\R^n$)
: For $\pi\in\Pi,X:S\to\R,s\in S$,
  $$(B^\pi(X))(s)=\sum_{s^\prime\in S}T(s,\pi(s),s^\prime)(R(s,\pi(s),s^\prime)+\gamma X(s^\prime))$$

> $B^\pi$ is a contraction mapping with contraction factor $\gamma$.
>
> For $X:s\to\R,\\ \lim_{l\to\infty}(B^\pi)^l(X)=V^\pi$
> For $X:s\to\R,Y:S\to\R,\\ X\succeq Y\implies B^\pi(X)\succeq B^\pi(Y)$
>
> $B^{\pi^\prime}(V^\pi)(s)=Q^\pi(s,\pi^\prime(s))$

##### Policy Iteration Algorithm

```python
def Policy_iteration(mdp):
  Pi = mdp.rand_policy()
  while mdp.is_improvable(Pi):
    Pi = mdp.improve(Pi)
  return Pi
```

### PI Variants

**Howard's Policy Iteration**
: Greedy; switch all improvable states.

**Random Policy Iteration**
: Switch a non-empty subset of improvable states chosen uniformly at random.

**Simple Policy Iteration**
: Assume a fixed indexing of states and always improve the state with the highest index.

**Upper Bound** ($U(n,k)$)
: For a set of PI Variants $\mathcal{L}$ and MDP $M$, the expected number of policy evalutaions performed by $L$ on $M$ if initialised at any $\pi$ is at most $U(n,k)$.
> |PI Variant|Type|k=2|General k|
> |---|---|---|---|
> |Howard's PI|Deterministic|$\mathcal{O}(\frac{2^n}{n})$|$\mathcal{O}(\frac{k^n}{n})$|
> |Mansour and Singh's Random PI [MS99]|Randomized|$1.7172^n$|$\mathcal{O}(\frac{k}{2})^n$|
> |Mansour and Singh's Random PI [HPZ14]|Randomized|$\text{poly}(n)\cdot 1.5^n$|--|

**Lower Bound** ($X(n,k)$)
: For a set of PI Variants $\mathcal{L}$ and MDP $M$, the expected number of policy evalutaions performed by $L$ on $M$ if initialised at any $\pi$ is at least $X(n,k)$.
> - Howard's PI on $n$-state, 2-action MDPs : $\Omega(n)$
> - Simple PI on $n$-state, 2-action MDPs : $\Omega(2^n)$

#### Howard's PI with $k=2$

> Non-optimal policies $\pi,\pi^\prime\in\Pi$ cannot have the same set of improvable states.
>
> If $\pi$ has $m$ improvable states and $\pi$ states and $\pi,\pi^\prime$ (Howard's PI) then there exist $m$ policies $\pi^{\prime\prime}$ such that $\pi^\prime\succeq\pi^{\prime\prime}\succ\pi$.

> Number of iterations taken by Howard's PI: $O(\frac{2^n}{n})$

#### Batch-Switching Policy Iteration

> Howard's Policy Iteration takes at most 3 iterations on 2-state 2-action MDP!

**BSPI**
: Partition states in 2-sized batches arranged from right to left. Improve the rightmost set containing an improvable state.

> BSPI of batch size 2 is bounded by $\mathcal{O}(\sqrt{3}^n)$.
> Tighter bounds for higher batch-sizes. 