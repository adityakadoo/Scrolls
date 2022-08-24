---
title: "Automata Theory"
date: 2022-08-19T17:00:34+05:30
draft: false
math: true
tags: ["Computer-Science"]
---

## Resources

- ### [Hopcrot-Motwani-Ullman](https://www-2.dc.uba.ar/staff/becher/Hopcroft-Motwani-Ullman-2001.pdf)

## Central Concepts

### Alphabets

Alphabet $ (\Sigma) $
: An ***alphabet*** is a finite nonempty set of symbols.

1. $ \Sigma= \\\{1, 0\\\} $
2. $ \Sigma = \\\{a,b,...,z\\\}$

### Strings

String $(w)$
: A ***string*** is a finite sequence of symbols chosen from $ \Sigma $.

#### Empty String

Empty String $(\epsilon)$
: The ***empty string*** is a string with zero symbols.

#### Length of a String

$|w|=\\\#$ Symbols in $w$

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

Language $(L)$
: A ***language*** over $\Sigma$ is basically $L\sube\Sigma$.

> A common way on defining languages is to use set-builder form as,
> $\\\{w\in\Sigma:$ something about $w\\\}$.

#### Empty Language

Empty Language $(\empty)$
: The ***empty language*** contains no words.

> $\empty\ne\\\{\epsilon\\\}$

### Problems

Problem
: Any ***problem*** is, given a $w$ in $\Sigma^*$, decide whether or not $w$ is in $L$.

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
    L(A)=\\\{w\in\Sigma:\hat\delta(q_0,w)\cap F\ne\empty\\\}
$$

#### Equivalence of DFA and NFA

Given an NFA $(N=\\\{Q_N,\Sigma,\delta_N,q_0,F_N\\\})$ it can be converted to a DFA $D=\\\{Q_D,\Sigma,\delta_D,\\\{q_0\\\},F_D\\\}$ such that $L(D)=L(N)$ using ***subset construction*** method.

1. $Q_D=P(Q_N)$
2. $F_D=\\\{S\sube Q_N:S\cap F_N\ne\empty\\\}$
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
3. $F_D=\\\{S:S\in Q_D$ and $S\cap F_E\ne\empty\\\}$
4. $\delta_D:Q_D\times\Sigma$ is defined as follows,
$$
\delta_D(S,a)=\bigcup_{r\in\bigcup_{p\in S}\delta_E(p,a)}\text{Ecl}(r)
$$

##### **Theorem** : A language $L$ is accepted by some $\epsilon$-NFA iff $L$ is accepted by some DFA.
Proof
- *Basis*: Since $\hat\delta_E(q_0, \epsilon)=\text{Ecl}(q_0)$ and $\hat\delta_D(q_D, \epsilon)=\hat\delta_D(\text{Ecl}(q_D),\epsilon)=\text{Ecl}(q_0)$, $\hat\delta_E(q_0, \epsilon) = \hat\delta_D(q_D, \epsilon)$ 
- *Induction*: As $\hat\delta_E(q_0, w[:-1])=\hat\delta_D(q_D,w[:-1])$ and,
$$
    \hat\delta_E(q_0,w)=\bigcup_{r\in\bigcup_{p\in\hat\delta_E(q_0, w[:-1])}\delta_E(p,w[-1])}\text{Ecl}(r)
$$
and $\hat\delta_D(q_D,w)$ is defined in a similar way,
$$
    \therefore\hat\delta_E(q_0, w)=\hat\delta_D(q_D,w)
$$

## Regular Expressions and Languages

### Regular Expressions

#### Operators on Regular Languages

1. ***Union***: The union of two languages $L$ and $M$ is defined as $L\cup M$.
2. ***Concatenation***: The concatenation of two languages $L$ and $M$ is defined as $LM=\\\{xy:x\in L,y\in M\\\}$.
3. ***Kleene closure***: The Kleene closure of a language $L$ is defined inductively as,
    
    - *Basis*: $\epsilon\in L^&ast;$

    - *Induction*: If $w\in L^&ast;$ and $x\in L$ then, $wx\in L^&ast;$

#### Building Regular-Expressions

- *Basis*: It contains 2 parts:
  1. The constants $\boldsymbol{\epsilon}$ and $\boldsymbol{\empty}$ are regular expressions such that $L(\boldsymbol{\epsilon})=\\\{\epsilon\\\}$ and $L(\boldsymbol{\empty})=\empty$.
  2. Every symbol $\boldsymbol{a}$ such that $a\in\Sigma$ is a regular expression then $L(\boldsymbol{a})=\\\{a\\\}$
- *Induction*: There are four parts for the induction step where $E$ and $F$ are regular expressions:
  1. $L(E+F)=L(E)\cup L(F)$
  2. $L(EF)=L(E)L(F)$
  3. $L(E^&ast;)=(L(E))^&ast;$
  4. $L((E))=L(E)$

#### Precedence of Regular-Expression Operators

> &ast; >> . >> +

### Finite Automata and Regular-Expressions

#### From DFA to Regular Expressions

##### **Theorem**: If $L=L(A)$ for some DFA $A$, then there is a regular expression $R$ such that $L=L(R)$.
Proof

Let the DFA have $n$ nodes each labelled with a number from $[1,n]$.

> $R_{ij}^{(k)}=\\\{w:\hat\delta(i,w)=j$ and $\forall t$ such that $0<t<|w|-1,\ \hat\delta(i,w[:t])\le k\\\}$

- *Basis*: Let $S=\\\{a:\delta(i,a)=j\\\}$. If $S=\empty$ then $R_{ij}^{(0)}=\empty$ else $R_{ij}^{(0)}=\sum_{a\in S}a$
- *Induction*:
    $$
        R_{ij}^{(k)}=R_{ij}^{(k-1)} + R_{ik}^{(k-1)}(R_{kk}^{(k-1)})^&ast;R_{kj}^{(k-1)}
    $$

#### Coverting Regular Expressions to Automata

##### **Theorem**: Every language accepted by a regular expression is also accepted by a finite automaton.
Proof
Let $L=L(R)$ for some regular expression $R$. We show that $L=L(E)$ for some $\epsilon$-NFA $E$ with:
1. Exactly on accepting state.
2. No arcs into the initial state.
3. No arcs out of the accepting state.

- *Basis*: For the 3 base cases:
  1. $$
  2. $$
  3. $$
  
- *Induction*: 
  1. $$
  2. $$
  3. $$

### Algebraic Laws for Regular Expressions

#### Associativity and Commutativity

- $L+M=M+L$
- $(L+M)+N=L+(M+N)$
- $(LM)N$=$L(MN)$

#### Identities and Annihilators

- $\empty+L=L+\empty=L$
- $\epsilon L=L\epsilon=L$
- $\empty L=l\empty=\empty$

#### Distributive Laws

- $L(M+N)=LM+LN$
- $(M+N)L=ML+NL$

#### Idempotent Law

- $L+L=L$

#### Laws with Closure

- $(L^&ast;)^&ast;=L^&ast;$
- $\empty^&ast;=\epsilon$
- $\epsilon^&ast;=\epsilon$
> $L^+=LL^&ast;$
- $L^&ast;=L^++\epsilon$
> $L?=\epsilon+L$
- $(L^&ast;M^&ast;)^&ast;=(L+M)^&ast;$

## Properties of Regular Languages

### Pumping Lemma

##### **Theorem**: (*The pumping lemma for regular languages*) For all $L$ such that $L$ is a regular language, there exists a constant $n$ such that for all $|w|\ge n$ we can break $w$ into three strings, $w=xyz$, such that:
##### 1. $y\ne\epsilon$
##### 2. $|xy|\le n$
##### 3. $\forall k\ge0,xy^kz\in L$
Proof
Let $L=L(A)$ be a regular language for DFA $A$. Consider a $w$ such that $|w|\ge n$.
We define,
$$
    S = \\\{p
    _i:0\le i\le n,\hat\delta(q_0,w[:i]),\\\}
$$

As size of $S$ is n+1 there must be 2 $p_i$ and $p_j$ such that $p_i=p_j$. We can break $w$ as,
1. $x=w[:i]$
2. $y=w[i:j]$
3. $z=w[j:]$

#### Proving languages not to be Regular

We do a game between 2 players as follows:
1. Player 1 picks the language $L$ to be proved nonregular.
2. Player 2 picks $n$, but doesn't reveal to player 1 what $n$ is; player 1 must devise a play for all possible $n$'s.
3. Player 1 picks $w$, which may depend on $n$ and which must be of length at least $n$ and $w\in L$.
4. Player 2 divides $w$ into $x$, $y$ and $z$, obeying the constraints that are stipulated in the pumping lemma; $y\ne\epsilon$ and $|xy|\le n$ and doesn't tell player 1 what $x$, $y$ and $z$.
5. Player 1 "wins" by picking $k$, which may be a function of $n$, $x$, $y$ and $z$, such that $xy^kz$ is not in $L$.

Thus L must not be regular as it doesn't follow the pumping lemma.

### Closure Properties

#### Closure under Boolean Operations

> $R_L =$ regular expression for language $L$

1. Closure under *union*
    ##### **Theorem**: If $L$ and $M$ are regular then $L\cup M$ is also regular.
    Proof: 
    $L\cup M=L(R_L+R_M)$

2. Closure under *complementation*
    ##### **Theorem**: If $L$ is regular then so is $\bar L$.
    Proof: Convert $R_L$ to DFA and take complement of it and construct the regular expression again to get $R_{\bar L}$

3. Closure under *Intersection*
    ##### **Theorem**: If $L$ and $M$ are regular then $L\cap M$ is also regular.
    Proof: $L\cap M=\overline{\overline L\cup\overline M}$

4. Closure under *difference*
    ##### **Theorem**: If $L$ and $M$ are regular then $L-M$ is also regular.
    Proof: $L-M=L\cap\overline M$

#### Reversal

> $L^R$ is defined as the reversal of the language $L$.

##### **Theorem**: If $L$ is regular language then so is $L^R$.
Proof
Construct the DFA $A$ of $L$ and reverse all the edges of $A$ and make final states as start states and start states as end states.

### Descision Properties

#### Converting among Representations

- NFA to DFA: $\mathcal O(n^32^n)$
- DFA to NFA: $\mathcal O(n)$
- DFA to RegEx: $\mathcal O(n^34^n)$
- NFA to RegEx: $\mathcal O(n^34^{n^32^n})$
- RegEx to $\epsilon$-NFA: $\mathcal O(n^3)$

#### Testing Emptiness of Regular Languages

Given a DFA apply BFS to check if any final state is reachable from the start state.

For a Regular Expression,
- *Basis*: $\empty$ is the empty language.
- *Induction*: Four cases must be considered:
  1. $R=R_1+R_2$ then $L(R)$ is empty iff both $L(R_1)$ and $L(R_2)$ are empty.
  2. $R=R_1R_2$ then $L(R)$ is empty iff both $L(R_1)$ or $L(R_2)$ are empty.
  3. $R=R_1^&ast;$ then $L(R)$ is not empty.
  4. $R=(R_1)$ then $L(R)$ is empty iff $L(R_1)$ is empty.

#### Testing Membership in a Regular Language

For a string $w$ with $|w|=n$ and $s$ states,
- DFA: $\mathcal O(n)$
- $\epsilon$-NFA: $\mathcal O(ns^2)$
- RegEx: $\mathcal O(ns^2)$

### Equivalence and Minimization of Automata

#### Testing Equivalence of States

Equivalent States $(p,q)$
: For all input strings $w$, $\hat\delta(p,w)$ is an accepting state iff $\hat\delta(q,w)$ is an accepting state.

Finding all pairs of distinguishable pairs by table method.
- *Basis*: If $p$ is an accepting atate and $q$ is a nonaccepting, then the pair $\\\{p,q\\\}$ is distinguishable.
- *Induction*: Let $r=\delta(p,a)$ and $s=\delta(q,a)$ then $p$ and $q$ are distinguishable if $r$ and $s$ are known to be distinguishable.

##### **Theorem**: Any pair that is left indistinguishable from the table-filling algorithm then the states are equivatent.

#### Minimization of DFA's

##### **Theorem**: The equivalence states are transitive. That is, if in some DFA $A=(Q,\sum,\delta,q_0,F)$ we find that states $p$ and $q$ are equivalent, and we also find that $q$ and $r$ are equivalent, then it must be that $p$ and $r$ are equivalent.

Therfore the "equivalence of states" is an equivalence relation over $Q$. This means we can divide the $Q$ into different equivalence classes and the Minimal DFA needs to have at least these many states.
