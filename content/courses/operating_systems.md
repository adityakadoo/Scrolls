---
title: "Operating Systems"
date: 2022-08-19T10:31:05+05:30
draft: false
tags: ["Computer-Science"]
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

#### Process API

- **Create**: Spawns a new process.
- **Destroy**: Kills a process forcefully.
- **Wait**: Wait for a process to finish.
- **Status**: Every process has a state associated with it.
- **Miscellaneous Control**: Halt, resume, etc.

#### Process Creation

1. Loading the *code* into executable format.
2. Initializing the process's runtime *stack*.
3. Initializing the program's *heap* memory.
4. Setup *file descriptors* associated with *input*, *output* and *error* streams.

#### Process States

Following are the types of states a process can be in:-
- **Running**
- **Ready**
- **Blocked**

```goat
 .-------.  Descheduled  .-----.
| Running |------------>| Ready |
|  state  |<------------| state |
 '-------'   Scheduled   '-----'
      \                     /
  I/O: \                   / I/O:
  start \    .-------.    /  done
         +->| Blocked |<-+
            |  state  |
             '-------'
```

#### Data Structures

- **Process List**: A list maintained by the OS of all the processes and their PCB.
- **Process Control Block** (PCB): A C struct that keeps track of all the meta-data associated with one process.

### Process API

In UNIX systems new processes are created with the use of 2 system calls `fork()` and `exec()`.

#### `fork()` system call

```c
int main(){
    printf("%d:hello world.",getpid());
    int rc = fork();
    if (rc<0) {
        // fork failed
        fprintf(stderr, "fork failed\n");
    } else if (rc == 0) {
        // only executed by child
        printf("%d:hello, I am child.\n",getpid());
    } else {
        // only executed by parent
        printf("%d:hello, I am parent of %d.\n", getpid(), rc);
    }
    return 0;
}
```

#### Adding `wait()` system call

```c
int main(){
    printf("%d:hello world.",getpid());
    int rc = fork();
    if (rc<0) {
        // fork failed
        fprintf(stderr, "fork failed\n");
    } else if (rc == 0) {
        // only executed by child
        printf("%d:hello, I am child.\n",getpid());
    } else {
        // only executed by parent
        // after waiting for child
        while(wait(NULL)>0);
        printf("%d:hello, I am parent of %d.\n", getpid(), rc);
    }
    return 0;
}
```

#### Finally, the `exec()` system call

```c
int main(){
    printf("%d:hello world.",getpid());
    int rc = fork();
    if (rc<0) {
        // fork failed
        fprintf(stderr, "fork failed\n");
    } else if (rc == 0) {
        // only executed by child
        printf("%d:hello, I am child.\n",getpid());
        char *myargs[3];
        myargs[0] = strdup("wc");
        myargs[1] = strdup("p3.c");
        myargs[2] = NULL;
        execvp(myargs[0], myargs);
        // Child converted to a different program now
        printf("somethings wrong; I can feel it\n");
    } else {
        // only executed by parent
        // after waiting for child
        while(wait(NULL)>0);
        printf("%d:hello, I am parent of %d.\n", getpid(), rc);
    }
    return 0;
}
```

### Limited Direct Execution

Direct Execution can be explained by the following table,

| OS                            | Program                      |
| ----------------------------- | ---------------------------- |
| Create entry for process list |                              |
| Allocate memory to program    |                              |
| Load program into memory      |                              |
| Set up stack with argc/argv   |                              |
| Clear registers               |                              |
| Execute call `main()`         |                              |
|                               | Run `main()`                 |
|                               | Execute return from `main()` |
| Free memory of process        |                              |
| Remove from process list      |                              |

#### Problem \#1: Restricted Operations

> How to perform restricted operations such as I/O or networking without giveing complete control over the system?

We add processor modes:-
- ***User mode***: The code that runs here is restricted and can't issue I/O requests and it will kill the process.
- ***Kernel mode***: In this mode the operating system runs the code and can do whatever it likes.

> What should a user program do to perform some kind of privileged operation?
 
The answer is ***system calls***.

Every system call runs a special `trap` instruction which jumps the execution to kernel mode to do any privileged operation. Once finished the program can return to user mode by executing `return-from-trap` instruction.

While executing `trap`, the hardware needs to ensure the register state of the user program is stored and must be restored when `return-from-trap` is executed.

> How does the trap know which code to run inside the OS?

The kernel sets-up a **trap table** at boot time in priviledged mode. OS informs the hardware of the locations of the **trap handlers**. Using this, whenever a hardware interrupt is 
passed this code is run by the hardware from the trap handlers.
All these operation are also **priviledge** operations.

| OS                            | Hardware                                      | Program                     |
| ----------------------------- | --------------------------------------------- | --------------------------- |
| Initialize trap table         | Remember addresses of syscall handler         |                             |
| ----------------------------- | --------------------------------------------- | --------------------------- |
| Create entry for process list |                                               |                             |
| Allocate memory to program    |                                               |                             |
| Load program into memory      |                                               |                             |
| Set up stack with argc/argv   |                                               |                             |
| Clear registers               |                                               |                             |
| `return-from-trap`            |                                               |                             |
|                               | restores regs to kernel stack                 |                             |
|                               | move to user mode                             |                             |
|                               | jump to `main()`                              |                             |
|                               |                                               | Run `main()`                |
|                               |                                               | Call syscall                |
|                               |                                               | `trap` into OS              |
|                               | save regs to kernel stack                     |                             |
|                               | move to kernel mode                           |                             |
|                               | jump to trap handler                          |                             |
| Handle trap                   |                                               |                             |
| Execute system call           |                                               |                             |
| `return-from-trap`            |                                               |                             |
|                               | restore regs from kernel stack                |                             |
|                               | move to kernel mode                           |                             |
|                               | jump to PC after trap                         |                             |
|                               |                                               | return from main            |
|                               |                                               | `trap` via `exit()`         |
| Free memory of process        |                                               |                             |
| Remove from process list      |                                               |                             |


### Switching Between Process

> How can the operating system **regain control** of the CPU so that it can switch process?

- ***Wait for system calls***: When ever the user program makes system call or makes an error it returns the control back to the OS. Otherwise it can also make a `yield` call to return the control to the OS periodically.
- ***OS takes controls***: This can be done using a simple `timer interrupt` that is raised after a fixed amount milliseconds.

#### Saving and Restoring Context

> Once the OS gains control, how to decide which process gets executed next?

This is done by the **scheduler**. Once the decision is made the OS executes a low-level piece of code which is called **context switch**. It is basically saving the register values of the current process and restoring the same for the next process.