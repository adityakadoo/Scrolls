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

#### Chess Theorem

In chess, one and only one of the following statements is true
- $s_W^\ast$ exists
- $s_B^\ast$ exists
- $s_W^\prime$ and $s_B^\prime$ exist