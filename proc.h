#include "types.h"  // 一定放在最顶部！
#ifndef PROC_H
#define PROC_H


extern volatile int need_sched;


typedef enum { UNUSED, RUNNABLE, RUNNING, SLEEPING, ZOMBIE } proc_state;

struct context
{
    uint64_t ra;
    uint64_t sp;
    uint64_t a0;
    uint64_t s[12]; // s0-s11
};

struct proc
{
    int pid;
    proc_state state;
    struct proc *parent;
    int exit_status;
    struct context context;
    uint64_t kstack;
};

#define NPROC 16
extern struct proc procs[NPROC];
extern struct proc *current_proc;
extern struct context kernel_context;

void proc_init();
void scheduler();
void yield();

#endif
