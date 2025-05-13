#ifndef SYSCALL_H
#define SYSCALL_H

enum
{
    SYS_write = 0,
    SYS_exit = 1,
    SYS_yield = 2,
    SYS_getpid = 3,
    SYS_fork = 4,
    SYS_wait = 5,
    NR_SYSCALLS
};

unsigned long fork(void);
unsigned long getpid(void);
unsigned long wait(int *status);

#endif
