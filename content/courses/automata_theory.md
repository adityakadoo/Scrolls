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

An ***alphabet*** $ (\sum) $ is a finite nonempty set of symbols.

1. $ \sum= ${$1, 0$}$ $
2. $ \sum = ${$a,b,...,z$}$ $

### Strings

A ***string*** $(w)$ is a finite sequence of symbols chosen from $ \sum $.

#### Empty String

The ***empty string*** $(\epsilon)$ is a string with zero symbols.

#### Length of a String

$(|w|)=$ #Symbols in $w$

> $|\epsilon|=0$

#### Powers of Alphabets

- $\sum^k=$ {$w:|w|=k$}
- $\sum^+=\sum^1\cup\sum^2\cup...$
- $\sum^*=\sum^+\cup$ { $\epsilon$ }

> $\sum^0=$ {$\epsilon$}

#### Concatenation of Strings

For strings $w_1$ and $w_2$, their ***concatenation*** is $w_1w_2$.

> $|w_1w_2| = |w_1|+|w_2|$

### Languages

A language $(L)$ over $\sum$ is basically $L\sube\sum$.

> A common way on defining languages is to use set-builder form as,
> {$w\in\sum:$ something about $w$}.

#### Empty Language

$\phi$ contains no words.

> $\phi\ne$ {$\epsilon$}

### Problems

Any ***problem*** is, given a $w$ in $\sum^*$, decide whether or not $w$ is in $L$.

> If test membership in $L_X$ is hard, then compiling programs in programming language $X$ is hard.