---
title: "Operating Systems"
date: 2022-08-19T10:31:05+05:30
draft: false
tags: ["Computer Science"]
---

## Resources

- ### [Operating Systems - Three Easy Pieces](https://techiefood4u.files.wordpress.com/2020/02/operating_systems_three_easy_pieces.pdf)

## Introduction to OS

Main objectives of OS include:-

1. **CPU Virtualization** : Making using the processor easy.
2. **Memory Virtualization** : Making storage in memory easy.
3. **Concurrency** : Ensuring correctness when multiple programs run together.
4. **Persistence** : Ensuring permanent memory does not get erased and stays organised.
5. **Design Goals** : Abstractions, performance, isolation, reliability, energy-efficiency

## Virtualization

### Abstraction : Process

The abstraction provided by the OS of a running program is called a ***process***.

The OS creates the illusion of **virtualization** the CPU by running one process, then stopping it and running another, and so forth. This is known as **time sharing** of the CPU.

> **Time sharing** is one of the most basic techniques used by an OS to share a resource. By allowing the resource to be used for a little while by one entity, and then a little while by another, and so forth. The natural counterpart of time sharing is **space sharing**, where a resource is divided (in space) among those who wish to use it.

### Process API

- **Create**: Spawns a new process.
- **Destroy**: Kills a process forcefully.
- **Wait**: Wait for a process to finish.
- **Status**: Every process has a state associated with it.
- **Miscellaneous Control**: Halt, resume, etc.

### Process Creation

1. Loading the *code* into executable format.
2. Initializing the process's runtime *stack*.
3. Initializing the program's *heap* memory.
4. Setup *file descriptors* associated with *input*, *output* and *error* streams.

### Process States

Following are the types of states a process can be in:-
- **Running**
- **Ready**
- **Blocked**

