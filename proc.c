#include "proc.h"
#include "syscall_wrap.h"
#include "printf.h"

volatile int need_sched = 0;

struct proc procs[NPROC];
static int nextpid = 4;
struct proc *current_proc;
struct context kernel_context;

void proc0_run()
{
    while (1) asm volatile("wfi");
}

void process_a()
{
    int pid = sys_fork();
    if (pid == 0)
    {
        while (1)
        {
            sys_write("child A\n", 8);
            sys_exit(7);
        }
    }
    else
    {
        int st;
        int cpid = sys_wait(&st);
        sys_write("parent got child exit\n", 22);
        while(1) sys_yield();
    }
}

void process_b()
{
    while (1) {
        sys_write("syscall B\n", 12);
        // if (need_sched) {
        //     need_sched = 0;
        //     yield();                 /* 现在是普通函数栈，安全 */
        // }
        sys_yield();
    }
}

__attribute__((naked)) void proc_a_entry()
{
    asm volatile(
        "addi sp, sp, -16\n"
        "sd ra, 8(sp)\n"
        "call process_a\n"
        "1: wfi\n"
        "j 1b\n"
    );
}

__attribute__((naked)) void proc_b_entry() 
{
    asm volatile(
        "addi sp, sp, -16\n"
        "sd ra, 8(sp)\n"
        "call process_b\n"
        "1: wfi\n"
        "j 1b\n"
    );
}

__attribute__((naked)) void scheduler_entry() 
{
    asm volatile(
        "addi sp, sp, -16\n"
        "sd ra, 8(sp)\n"
        "call scheduler\n"
        "1: wfi\n"
        "j 1b\n"
    );
}


static __attribute__((aligned(16))) char kernel_stack[4096];
static __attribute__((aligned(16))) char kstack0[4096];
static __attribute__((aligned(16))) char kstack1[4096];
static __attribute__((aligned(16))) char kstack2[4096];

void proc_init() 
{
    procs[0].pid = 0;
    procs[0].state = SLEEPING;
    procs[0].context.ra = (uint64_t)proc0_run;
    procs[0].context.sp = (uint64_t)(kstack0 + 4096);
    procs[0].kstack = (uint64_t)kstack0;

    procs[1].pid = 1;
    procs[1].state = RUNNABLE;
    procs[1].context.ra = (uint64_t)proc_a_entry;
    procs[1].context.sp = (uint64_t)(kstack1 + 4096);
    procs[1].kstack = (uint64_t)kstack1;

    procs[2].pid = 2;
    procs[2].state = RUNNABLE;
    procs[2].context.ra = (uint64_t)proc_b_entry;
    procs[2].context.sp = (uint64_t)(kstack2 + 4096);
    procs[2].kstack = (uint64_t)kstack2;

    kernel_context.sp = (uint64_t)(kernel_stack + 4096);
    kernel_context.ra = (uint64_t)scheduler_entry;
}

extern void switch_context(struct context*, struct context*);

void scheduler() 
{
    while (1)
    {
        for (int i = 0; i < NPROC; i++)
        {
            if (procs[i].state == RUNNABLE)
            {
                puts("switch to proc "); print_hex(procs[i].pid); puts("\n");
                puts("a0= "); print_hex(procs[i].context.a0); puts("\n");
                current_proc = &procs[i];
                procs[i].state = RUNNING;
                switch_context(&kernel_context, &current_proc->context);
            }
        }
    }
    while (1) asm volatile("wfi");
}

void yield() 
{
    if (current_proc && current_proc->state == RUNNING) current_proc->state = RUNNABLE;
    switch_context(&current_proc->context, &kernel_context);
}

struct proc *allocproc(void)
{
    for (int i = 1; i < NPROC; ++i)
    {
        if (procs[i].state == UNUSED)
        {
            struct proc *p = &procs[i];

            extern void *alloc_page(void);
            void *kstack = alloc_page();
            if (!kstack) return 0;

            p->kstack = (uint64_t)kstack;
            p->context.sp = (uint64_t)(kstack + 4096);
            p->state = RUNNABLE;
            p->pid = nextpid++;
            p->parent = current_proc;
            return p;
        }
    }
    return 0;
}