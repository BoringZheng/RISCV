#include "printf.h"
#include "mm/vm.h"
#include "proc.h"

unsigned long sys_write_impl(unsigned long buf, unsigned long len, unsigned long a1,
                     unsigned long a2, unsigned long a3, unsigned long a4)
{
    const char *p = (const char *)buf;
    for (unsigned long i = 0; i < len; ++i) *(volatile char *)0x10000000 = p[i];
    return len;
}

unsigned long sys_exit_impl(unsigned long code, unsigned long a1, unsigned long a2, 
                            unsigned long a3, unsigned long a4, unsigned long a5)
{
    puts("proc "); print_hex(current_proc->pid); puts(" exit with code "); print_hex(code); puts("\n");
    current_proc->state = ZOMBIE;
    current_proc->exit_status = (int)code;
    yield();
    return 0;
}

unsigned long sys_yield_impl(unsigned long a0, unsigned long a1, unsigned long a2,
                              unsigned long a3, unsigned long a4, unsigned long a5)
{
    yield();
    return 0;
}

unsigned long sys_getpid_impl(unsigned long a0, unsigned long a1, unsigned long a2,
                               unsigned long a3, unsigned long a4, unsigned long a5)
{
    return current_proc->pid;
}

extern struct proc *allocproc(void);

unsigned long sys_fork_impl(unsigned long a0, unsigned long a1, unsigned long a2,
                              unsigned long a3, unsigned long a4, unsigned long a5)
{
    struct proc *parent = current_proc;
    struct proc *child = allocproc();
    if (!child) return -1;

    child->parent = parent;
    child->context = parent->context;
    child->context.a0 = 0; // child process returns 0 in a0
    parent->context.a0 = child->pid; // parent process returns child's pid in a0
    child->context.s[0] = 0;
    parent->context.s[0] = child->pid;
    const unsigned long stack_size = 4096;
    memmove((void *)(child->kstack), (void *)(parent->kstack), stack_size);

    unsigned long offset = parent->kstack + stack_size - parent->context.sp;
    child->context.sp = child->kstack + stack_size - offset;

    register unsigned long tmp asm("s0") = child->pid;
    register unsigned long ret_val asm("a0") = child->pid;
    return ret_val;
}

unsigned long sys_wait_impl(unsigned long status, unsigned long a1, unsigned long a2,
                              unsigned long a3, unsigned long a4, unsigned long a5)
{
    while (1)
    {
        for (int i = 0; i < NPROC; ++i)
        {
            struct proc *p = &procs[i];
            if (p->parent == current_proc && p->state == ZOMBIE)
            {
                if (status) *(int *)status = p->exit_status;
                int pid = p->pid;
                p->state = UNUSED;
                return pid;
            }
        }
        sys_yield_impl(0, 0, 0, 0, 0, 0);
    }
}