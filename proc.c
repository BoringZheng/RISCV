#include "proc.h"
#include "syscall_wrap.h"
#include "printf.h"

volatile int need_sched = 0;

struct proc procs[NPROC];
struct proc *current_proc;
struct context kernel_context;

void proc0_run()
{
    while (1) asm volatile("wfi");
}

void process_a()
{
    while (1) {
        sys_write("syscall A\n", 12);
        if (need_sched) {
            need_sched = 0;
            yield();                 /* 现在是普通函数栈，安全 */
        }
    }
}

void process_b()
{
    while (1) {
        sys_write("syscall B\n", 12);
        if (need_sched) {
            need_sched = 0;
            yield();                 /* 现在是普通函数栈，安全 */
        }
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
    procs[0].state = UNUSED;
    procs[0].context.ra = (uint64_t)proc0_run;
    procs[0].context.sp = (uint64_t)(kstack0 + 4096);
    procs[0].kstack = (uint64_t)kstack0;

    procs[1].pid = 1;
    procs[1].state = RUNNING;
    procs[1].context.ra = (uint64_t)proc_a_entry;
    procs[1].context.sp = (uint64_t)(kstack1 + 4096);
    procs[1].kstack = (uint64_t)kstack1;

    procs[2].pid = 2;
    procs[2].state = RUNNING;
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
            if (procs[i].state == RUNNING)
            {
                current_proc = &procs[i];
                switch_context(&kernel_context, &current_proc->context);
            }
        }
    }
    while (1) asm volatile("wfi");
}

void yield() 
{
    switch_context(&current_proc->context, &kernel_context);
}
