---
title: "Automata Theory"
date: 2022-08-19T17:00:34+05:30
draft: false
math: true
tags: ["Computer Science"]
---

## Resources

- ### [Hopcrot-Motwani-Ullman](https://www-2.dc.uba.ar/staff/becher/Hopcroft-Motwani-Ullman-2001.pdf)

## Central Concepts

### Alphabets

An ***alphabet*** $ (\Sigma) $ is a finite nonempty set of symbols.

1. $ \Sigma= \\\{1, 0\\\} $
2. $ \Sigma = \\\{a,b,...,z\\\}$

### Strings

A ***string*** $(w)$ is a finite sequence of symbols chosen from $ \Sigma $.

#### Empty String

The ***empty string*** $(\epsilon)$ is a string with zero symbols.

#### Length of a String

$(|w|)=\\\#$ Symbols in $w$

> $|\epsilon|=0$

#### Powers of Alphabets

- $\Sigma^k=\\\{w:|w|=k\\\}$
- $\Sigma^+=\Sigma^1\cup\Sigma^2\cup...$
- $\Sigma^*=\Sigma^+\cup\\\{\epsilon\\\}$

> $\Sigma^0= \\\{\epsilon\\\}$

#### Concatenation of Strings

For strings $w_1$ and $w_2$, their ***concatenation*** is $w_1w_2$.

> $|w_1w_2| = |w_1|+|w_2|$

### Languages

A language $(L)$ over $\Sigma$ is basically $L\sube\Sigma$.

> A common way on defining languages is to use set-builder form as,
> $\\\{w\in\Sigma:$ something about $w\\\}$.

#### Empty Language

$\phi$ contains no words.

> $\phi\ne\\\{\epsilon\\\}$

### Problems

Any ***problem*** is, given a $w$ in $\Sigma^*$, decide whether or not $w$ is in $L$.

> If testing membership in $L_X$ is hard, then compiling programs in programming language $X$ is hard.

## Finite State Automaton

### Deterministic Finite Automaton

A ***deterministic  finite automaton*** $( A(Q,\Sigma,\delta,q_0,F) )$ consists of:
1. A finite set of *states* $(Q)$.
2. A finite set of *input symbols* $(\Sigma)$.
3. A *transition function* $(\delta:Q\times\Sigma\rightarrow Q)$
4. A *start state* $(q_0\in Q)$
5. A set of *final states* $F\sube Q$

#### Transition diagram

A ***transition diagram*** for a $A$ is a graph $G(V,E)$ defined as follows:-

1. $V=\\\{q:\forall q\in Q\\\}$
2. $E=\\\{q_1\xrightarrow{s}q_2:s\in\Sigma\text{ and }\delta(q_1,s)=q_2\\\}$
3. An arrow pointing into $q_0$.
4. All nodes in $F$ are denoted with double circle.

#### Extended transition function

The ***extended transition function*** $(\hat\delta:Q\times\Sigma^*\rightarrow Q)$ can be defined inductively as:

- *Basis*: $\hat\delta(q,\epsilon)=q$
- *Induction*: $\hat\delta(q,w)=\delta(\hat\delta(q,w[:-1]),w[-1])$

#### Language of a DFA

The ***language*** of DFA $(L(A))$ is defined as,
$$
    L(A)=\\\{w\in\Sigma:\hat\delta(q_0,w)\in F\\\}
$$

### Nondeterministic Finite Automaton

A ***non-deterministic  finite automaton*** $( A(Q,\Sigma,\delta,q_0,F) )$ consists of:
1. A finite set of *states* $(Q)$.
2. A finite set of *input symbols* $(\Sigma)$.
3. A *transition function* $(\delta:Q\times\Sigma\rightarrow P(Q))$
4. A *start state* $(q_0\in Q)$
5. A set of *final states* $F\sube Q$

> $P(S)=\\\{A:A\sube S\\\}$

#### Extended transition function

The ***extended transition function*** $(\hat\delta:Q\times\Sigma^*\rightarrow P(Q))$ can be defined inductively as:

- *Basis*: $\hat\delta(q,\epsilon)=\\\{q\\\}$
- *Induction*: $\hat\delta(q,w)=\bigcup_{p\in \hat\delta(q,w[:-1])}\delta(p,w[-1])$

#### Language of an NFA

The ***language*** of NFA $(L(A))$ is defined as,
$$
    L(A)=\\\{w\in\Sigma:\hat\delta(q_0,w)\cap F\ne\phi\\\}
$$

#### Equivalence of DFA and NFA

Given an NFA $(N=\\\{Q_N,\Sigma,\delta_N,q_0,F_N\\\})$ it can be converted to a DFA $D=\\\{Q_D,\Sigma,\delta_D,\\\{q_0\\\},F_D\\\}$ such that $L(D)=L(N)$ using ***subset construction*** method.

1. $Q_D=P(Q_N)$
2. $F_D=\\\{S\sube Q_N:S\cap F_N\ne\phi\\\}$
3. $\delta_D:P(Q_N)\times\Sigma\rightarrow P(Q_N)$ is defined as,
$$
    \delta_D(S,a)=\bigcup_{p\in S}\delta_N(p,a)
$$

##### **Theorem** : $L(D)=L(N)$ i.e. $\forall w\in\Sigma,\\\ \hat\delta_D(\\\{q_0\\\},w)=\hat\delta_N(q_0,w)$
Proof
- *Basis*: For $w=\epsilon,\\\ \hat\delta_D(\\\{q_0\\\},w)=\\\{q_0\\\}$ and $\hat\delta_N(q_0,w)=\\\{q_0\\\}$
- *Induction*: As $\hat\delta_N(q_0,w[:-1])=\hat\delta_D(\\\{q_0\\\},w[:-1])$
$$
\hat\delta_N(q_0,w)=\bigcup_{p\in\hat\delta_N(\\\{q_0\\\},w[:-1])}\delta_N(p,w[-1])
$$
$$
\hat\delta_D(\\\{q_0\\\},w)=\delta_D(\hat\delta_D(\\\{q_0\\\},w[:-1]),w[-1])=\bigcup_{p\in\hat\delta_D(\\\{q_0\\\},w[:-1])}\delta_N(p,w[-1])
$$
$$
\therefore\hat\delta_D(\\\{q_0\\\},w)=\hat\delta_N(q_0,w)
$$

##### **Theorem** : A language $L$ is accepted by some DFA iff $L$ is accepted by some NFA.

> A bad case for subset construction is $L=\\\{w\in\\\{1,0\\\}^*:w[-n]=1\\\}$

### Finite Automaton with $\epsilon$-transition

A ***non-deterministic  finite automaton with $\epsilon$-transitions*** $( A(Q,\Sigma,\delta,q_0,F) )$ is defined similar to the NFA with only difference in $\delta:Q\times\Sigma\cup\\\{\epsilon\\\}\rightarrow P(Q)$.

#### Epsilon Closure

- *Basis*: $q\in\text{Ecl}(q)$
- *Induction*: If $p\in\text{Ecl}(q)$ and $r\in\delta(p,\epsilon)$ then $r\in\text{Ecl}(q)$

#### Extended Transition Function

- *Basis*: $\hat\delta(q,\epsilon)=\text{Ecl}(q)$
- *Induction*: $$\hat\delta(q,w)=\bigcup_{r\in\bigcup_{p\in\hat\delta(q,w[:-1])}\delta(p,w[-1])}\text{Ecl}(r)$$

#### Eliminating $\epsilon$-transitions

Given an $\epsilon$-NFA $(E=\\\{Q_E,\Sigma,\delta_E,q_0,F_E\\\})$ it can be converted to a DFA $D=\\\{Q_D,\Sigma,\delta_D,\\\{q_D\\\},F_D\\\}$ such that $L(D)=L(E)$ as follows,

1. $Q_D=P(Q_E)$
2. $q_D=\text{Ecl}(q_0)$
3. $F_D=\\\{S:S\in Q_D$ and $S\cap F_E\ne\phi\\\}$
4. $\delta_D:Q_D\times\Sigma$ is defined as follows,
$$
\delta_D(S,a)=\bigcup_{r\in\bigcup_{p\in S}\delta_E(p,a)}\text{Ecl}(r)
$$

##### **Theorem** : A language $L$ is accepted by some $\epsilon$-NFA iff $L$ is accepted by some DFA.
- *Basis*: 
- *Induction*: 