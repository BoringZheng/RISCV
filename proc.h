#ifndef PROC_H
#define PROC_H

#include "types.h"  // 一定放在最顶部！

typedef enum { UNUSED, RUNNING, SLEEPING } proc_state;

struct context
{
    uint64_t ra;
    uint64_t sp;
    uint64_t s[12]; // s0-s11
};

struct proc
{
    int pid;
    proc_state state;
    struct context context;
    uint64_t kstack;
};

#define NPROC 3
extern struct proc procs[NPROC];
extern struct proc *current_proc;
extern struct context kernel_context;

void proc_init();
void scheduler();
void yield();

#endif
