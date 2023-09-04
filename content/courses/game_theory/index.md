---
title: "Game Theory"
date: 2023-08-25T16:05:24+05:30
draft: true
math: true
tags: [Economics, Computer-Science, Math]
description: "Notes for CS6001 course"
resources:
- name: thumbnail
  src: 
toc: true
footer: true
---

## Central Concepts

### Game

- **Game**
: It is a formal representation of the *strategic* interaction between *players*
- **Actions**
: *Choices* available to players
- **Strategy**
: *Mapping* from state of the game to set of valid actions

> **Normal Form**, **Extensive Form**, **Static**, **Dynamic**, **Repeated**, **Stochastic**, etc. are different kinds of games

### Game Theory

- **Game Theory**
: It is the formal study of strategic interactions between player, who are *rational* and *intelligent*
- **Rational Player**
: A player who always picks the action that *maximizes* their *utility*
- **Intelligent Player**
: A player who knows the rules of the game *perfectly* and can pick the best action considering that there are other rational and intelligent players in the game
- **Common Knowledge**
: A *fact* is common knowledge if,
  - all players know the fact
  - all players know that all players know the fact
  - all players know that all players know the fact
  - ...ad infinitum

### Chess Example

- **Game situations**($H$)
: Set of all finite sequence $(x_0, x_1,x_2,...,x_k)$ of board positions such that,
  - $x_0$ is the opening board position
  - $x_k\rightarrow x_{k+1}$
    - $k$ even $\implies$ single action of $W$
    - $k$ odd $\implies$ single action of $B$
- **Strategy** for $W$($s_W$)
: Function $s_W$ that associates every game situation $(x_0,x_1,x_2,...,x_k)\in H$, where $k$ is even, with a board position $x_{k+1}$ such that the move $x_k\rightarrow x_{k+1}$ is a single valid move for $W$
- **Strategy** for $B$($s_B$)
: Defined similarly as above
- **Outcome**
: Determined by a pair of $(s_W, s_B)$. Could be one of the following for chess,
  - $W$ wins: $W$ captures $B$ king
  - $B$ wins: $B$ captures $W$ king
  - Draw: Both players agree to draw
- **Winning Strategy** for $W$($s_W^\ast$)
: A strategy such that $\forall s_B$, the outcome for $(s_W^\ast,s_B)$ is a win for $W$
- **Draw Guaranteeing Strategy** for $W$($s_W^\prime$)
: A strategy such that $\forall s_B$, the outcome for $(s_W^\prime, s_B)$ is either a win for $W$ or a draw.

> **Theorem** : In chess, one and only one of the following statements is true
> - $s_W^\ast$ exists
> - $s_B^\ast$ exists
> - $s_W^\prime$ and $s_B^\prime$ exist

## Pure Strategies

### Normal Form Games

**Static Game** $\langle N, \\\{S_i|i\in N\\\}, \\\{u_i | i\in N\\\} \rangle$
: A game where player interact only once
- **Set of players**
: $N =\\\{1,2,\dots,n\\\}$
- **Set of Strategies for $i$**
: $s_i\in S_i$
- **Strategy profile**
: $s=(s_1,s_2,\dots,s_n)\in S$
- **Set of strategy profiles**
: $S=\times_{i\in N}S_i$
- **Strategy profile w/o $i$**
: $s_{-i}=(s_1,\dots,s_{i-1},s_{s+1},\dots,s_n)$
- **Utility function for player $i$**
: $u_i:S\rightarrow \R$

> **Finite Game** : A static game where $\forall i\in N,\\ S_i$ is finite

### Dominance

**Strictly Dominated Strategy**
: $s_i^\prime\in S_i,\\ \exists s_i\in S_i,\\ \forall s_{-i}\in S_{-i},\\ u_i(s_i, s_{-i})>u_i(s_i^\prime,s_{-i})$

**Weakly Dominated Strategy**
: $s_i^\prime\in S_i,\\ \exists s_i\in S_i,\\ \forall s_{-i}\in S_{-i},\\ u_i(s_i, s_{-i})\ge u_i(s_i^\prime,s_{-i})$ and $\exists \tilde s_{-i}\in S_{-i},\\ u_i(s_i, \tilde s_{-i}) > u_i(s_i^\prime, \tilde s_{-i})$

**Strictly Dominant Strategy**
: $s_i^\prime\in S_i, \forall s_i\in S_i-\\\{s_i^\prime\\\},\\ s_i$ is strictly dominated by $s_i^\prime$

**Weakly Dominant Strategy**
: $s_i^\prime\in S_i, \forall s_i\in S_i-\\\{s_i^\prime\\\},\\ s_i$ is weakly dominated by $s_i^\prime$

### Equilibria

#### Dominant Strategy Equilibrium

**Strictly Dominant Strategy Equilibrium [SDSE]**
: A strategy profile $(s_1^\ast,s_2^\ast,\dots,s_n^\ast)$, such that $\forall i\in N,\\ s_i^\ast$ is a strictly dominant strategy

**Weakly Dominant Strategy Equilibrium [WDSE]**
: A strategy profile $(s_1^\ast,s_2^\ast,\dots,s_n^\ast)$, such that $\forall i\in N,\\ s_i^\ast$ is a weakly dominant strategy

> **Rational player never play dominated strategies.**
> So it can be useful to remove such strategies. 
> Strictly dominated strategies can be removed in any order.
> Weakly dominated strategies' order of removal matters as it can remove important outcomes.

#### Nash Equilibrium

**Pure Strategy Nash Equilibrium [PSNE]**
: A strategy profile $(s_i^\ast, s_{-i}^\ast)$ such that $\forall i\in N$ and $\forall s_i\in S_i$,
$$
  u_i(s_i^\ast, s_{-i}^\ast)\ge u_i(s_i,s_{-i}^\ast)
$$

**Best Response** ($B_i(s_{-i})$)
: $B_i(s_{-i}) = \\\{s_i\in S_i|\\ \forall s_i^\ast\in S_i,\\ u_i(s_i,s_{-i})\ge u_i(s_i^\ast,s_{-i})\\\}$

> For a PSNE $(s_i^\ast,s_{-i}^\ast)$, $s_i^\ast\in B_i(s_{-i}^\ast),\\ \forall i\in N$

> SDSE $\implies$ WDSE $\implies$ PSNE

### Risk Aversion

**Max-Min Strategy** ($s_i^{\max\min}$)
: $s_i^{\max\min}\in\arg\max_{s_i\in S_i}\min_{s_{-i}\in S_i}u_i(s_i,s_{-i})$

**Max-Min value** ($\underline v_i$)
: $\underline v_i = \max_{s_i\in S_i}\min_{s_{-i}\in S_i}u_i(s_i,s_{-i})$

> $u_i(s_i^{\max\min},s_{-i})\ge\underline v_i,\\ \\ \forall s_{-i}\in S_{-i}$

> **Theorem** : $s_i^\ast$ is dominant strategy $\implies$ $s_i^\ast$ is a max-min strategy

> **Theorem** : Every PSNE $s^\ast=(s_1^\ast,\dots,s_n^\ast)$ satisfies $u_i(s^\ast)\ge\underline v_i,\\ \forall i\in N$

### Elimination of dominated strategies

#### Preservation of Max-Min value

> **Theorem** : For NFG $G$, let $s_j^\prime\in S_j$ be a dominant strategy. Let $G^\prime$ be the residual game after removing $s_j^\prime$. Then, the maxmin value of $j$ in $G^\prime$ is equal to the maxmin value in $G$

#### Preservation of PSNE

> **Theorem** : For NFG $G$ and $G^\prime$ after elimination of **any** strategy, if $s^\ast$ is a PSNE in $G$ and survives in $G^\prime$, then $s^\ast$ is a PSNE in $G^\prime$ too.

> No new PSNE if eliminated strategy is dominated.
> Old PSNE could be killed.

### Matrix Games

**Matrix Game**
: A NFG $\langle N, \\\{S_i|i\in N\\\}, \\\{u_i|i\in N\\\}\rangle$ with $N=\\\{1,2\\\}$ and $u_1(s)+u_2(s)=0,\\ \forall$ strategy profile $s\in S$

**Utility Matrix** ($U$)
: $[U]_{ij} = u_1(s_i,s_j)$

> Player 2's MaxMin value is negative of the column-wise MinMax of this matrix.

**Saddle Point**
: An element in the matrix that is maximum in it's column and minimum in it's row

> **Theorem** : In a Matrix game, $(s_1^\ast,s_2^\ast)$ is a saddle point $\iff$ $(s_1^\ast,s_2^\ast)$ is a PSNE

**Max-Min Value** ($\underline v$)
: $\underline v = \max_{s_1\in S_1}\min_{s_2\in S_2}U(s_1, s_2)$

**Min-Max Value** ($\bar v$)
: $\bar v = \min_{s_1\in S_1}\max_{s_2\in S_2}U(s_1, s_2)$

> **Lemma** : For matrix games, $\bar v\ge\underline v$

> **PSNE Theorem** : A Matrix game has a PSNE $\iff$ $\bar v=\underline v=U(s_1^\ast, s_2^\ast)$ where $s_1^\ast$ and $s_2^\ast$ are $\max\min$ and $\min\max$ strategies for player 1 and 2 respectively. $(s_1^\ast, s_2^\ast)$ is that PSNE.

## Mixed Strategies

**Mixed Strategy Set** ($\Delta A$)
: $\Delta A = \\\{p:A\to[0,1]^{|A|}\\ |\\ \sum_{a\in A}p(a) = 0\\\}$

**Mixed Strategy** ($\sigma_i$)
: For player $i$, $\sigma_i:S_i\to[0,1]$ such that $\sum_{s_i\in S_i}\sigma_i(s_i)=1$

**Utility** ($u_i(\sigma_i,\sigma_{-i})$)
: $u_i(\sigma_i,\sigma_{-i}) = \sum_{s_1\in S_1}\sum_{s_2\in S_2}\cdots\sum_{s_n\in S_n}\prod_{j=1}^N\sigma_j(s_j)\cdot u_i(s_1,s_2,\dots,s_n)$

### Mixed Strategy Nash Equilibrium

**MSNE**
: A mixed strategy profile $(\sigma_i^\ast, \sigma_{-i}^\ast)$ such that,
$$
  u_i(\sigma_i^\ast, \sigma_{-i}^\ast)\ge u_i(\sigma_i, \sigma_{-i}^\ast),\\ \forall\sigma_i\in\Delta S_i,\\ \forall i\in N
$$

> PSNE $\implies$ MSNE

> **Theorem** : $(\sigma_i^\ast, \sigma_{-i}^\ast)$ is an MSNE $\iff$ $\forall s_i\in S_i,\\ \forall i\in N$, 
> $$ u_i(\sigma_i^\ast,\sigma_{-i}^\ast)\ge u_i(s_i,\sigma_{-i}^\ast)$$

### MSNE Characterization Theorem

**Support for Mixed Strategy** ($\delta(\sigma_i)$)
: $\delta(\sigma_i)=\\\{s_i\in S_i|\\ \sigma_i(s_i)>0\\\}$

> **Theorem** : $(\sigma_i^\ast,\sigma_{-i}^\ast)$ is a MSNE $\iff$ $\forall i\in N$,
> - $u_i(s_i,\sigma_{-i}^\ast)$ is identical $\forall s_i\in \delta(\sigma_i^\ast)$
> - $u_i(s_i,\sigma_{-i}^\ast)\ge u_i(s_i^\prime, \sigma_{-i}^\ast),\\ \forall s_i\sube \delta(\sigma_i^\ast),\\ s_i^\prime \not\in\delta(\sigma_i^\ast)$

- Maximizing w.r.t. a distribution $\Leftrightarrow$ Whole probability mass at max
$$ \max_{\sigma_i\in\Delta S_i}u_i(\sigma_i,\sigma_{-i})=\max_{s_i\in S_i}u_i(s_i,\sigma_{-i}) $$
- If $(\sigma_i^\ast, \sigma_{-i}^\ast)$ is an MSNE, then
$$ u_i(\sigma_i^\ast,\sigma_{-i}^\ast)=\max_{\sigma_i\in\Delta S_i}u_i(\sigma_i,\sigma_{-i}^\ast)=\max_{s_i\in S_i}u_i(s_i,\sigma_{-i}^\ast)=\max_{s_i\in\delta(\sigma_i)}u_i(s_i,\sigma_{-i}^\ast) $$

### Algorithm for MSNE

For every support profile $X_1\times X_2\times\cdots X_n$ where $X_i\sube S_i$, solve the following feasibility program to get the MSNE,
$$
  w_i = \sum_{s_{-i}\in S_{-i}}(\prod_{j\not =i}\sigma_j(s_j))\cdot u_i(s_i,s_{-i}),\\ \forall s_i\in X_i,\\ \forall i\in N\\\
  w_i \ge \sum_{s_{-i}\in S_{-i}}(\prod_{j\not =i}\sigma_j(s_j))\cdot u_i(s_i,s_{-i}),\\ \forall s_i\in S_i\backslash X_i,\\ \forall i\in N\\\
  \sigma_j(s_j)\ge0,\\ \forall s_j\in S_j,\\ \forall j\in N\\\
  \sum_{s_j\in X_j}\sigma_j(s_j)=1,\\ \forall j\in N
$$

- Not linear unless $n=2$
- No poly-time algorithm for general game
- This is PPAD-complete (Polynomial Parity Argument on Directed graphs)

### Existence of MSNE

**Finite Game**
: A game with finite number of players and each player has a finite set of strategies

> **Theorem** : Every finite game has a (mixed) Nash equilibrium.

## Correlated Strategies

**Correlated Strategy** ($\pi$)
: A mapping $\pi:S_1\times S_2\times\cdots\times S_n\rightarrow[0,1]$ such that $\sum_{s\in S}\pi(s)=1$

**Correlated Equilibrium**
: A correlated strategy $\pi$ such that,
$$
  \sum_{s_{-i}\in S_{-i}}\pi(s_i,s_{-i})\cdot u_i(s_i, s_{-i})\ge \sum_{s_{-i}\in S_{-i}}\pi(s_i,s_{-i})\cdot u_i(s_i^\prime, s_{-i}),\\ \forall s_i,s_i^\prime\in S_i,\\ \forall i\in N
$$

To find a CE following linear equations must be solved,
$$
  \sum_{s_{-i}\in S_{-i}}\pi(s_i,s_{-i})\cdot u_i(s_i, s_{-i})\ge \sum_{s_{-i}\in S_{-i}}\pi(s_i,s_{-i})\cdot u_i(s_i^\prime, s_{-i}),\\ \forall s_i,s_i^\prime\in S_i,\\ \forall i\in N\\\
  \pi(s)\ge 0,\\ \forall s\in S,\\ \sum_{s\in S}\pi(s)=1
$$

> **Theorem** : For every MSNE $\sigma^\ast$ there exists a CE $\pi^\ast$

## Perfect Information Extensive Form Games

**Perfect Information Extensive Form Games** [PIEFG] $\langle N, A, H, X, P, (u_i)_{i\in N}\rangle$
: A game where players interact one after the other
- **Set of players**: $N$
- **Set of all possible actions**: $A$
- **Set of all sequences of actions**: $H$
  - empty history $\varnothing\in H$
  - if $h\in H$ and any sub-sequence $h^\prime$ of $h$ starting at the root then $h^\prime\in H$
  - $h=(a^{(0)},a^{(1)},\dots,a^{(T-1)})$ is **terminal** if $\nexists a^{(T)}$ such that $(a^{(0)},a^{(1)},\dots,a^{(T)})\in H$
  - **Set of terminal histories**: $Z\sube H$
- **Action set selection function**: $X:H\backslash Z\rightarrow 2^A$
- **Player function**: $P:H\backslash Z\rightarrow N$
- **Utility**: $u_i:Z\rightarrow\R$

**Strategy** ($S_i$)
: $S_i = \times_{\\\{h\in H:P(h)=i\\\}}X(h)$

> PSNE of PIEFG doesn't always give credible threats for equilibrium

### Subgame Perfection

**Subgame**
: Subtree of a PIEFG $G$ rooted at a history $h$. It is the *restriction* of $G$ to the descendants of $h$.

**Subgame Perfect Nash Equilibrium** [SPNE]
: A strategy profile $s\in S$ such that $\forall$ subgame $G^\prime$ of $G$, the restriction of $s$ to $G^\prime$ is a PSNE of $G^\prime$

### Backward Induction Algorithm

```python
def BACK_IND(history h):
  if h in Z:
    return u(h),[]
  best_util = -INT_MAX
  for a in X(h):
    util_at_child = BACK_IND((h, a))
    if util_at_child > best_util:
      best_util = util_at_child best_action = a
  return best_util, best_action
```

### SPNE Limitations

**Advantages**
1. SPNE is guaranteed to exist in finite PIEFG
2. An SPNE is a PSNE
3. The algorithm to find SPNE is simple

**Disadvantages**
1. The whole tree needs to be parsed
2. Cognitive limit of real players may prohibit playing SPNE