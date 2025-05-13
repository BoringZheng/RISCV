#pragma once
#include "syscall.h"

static inline long __syscall(unsigned long num,
                             unsigned long a0, unsigned long a1, unsigned long a2,
                             unsigned long a3, unsigned long a4, unsigned long a5)
{
    register unsigned long _a7 asm("a7") = num;
    register unsigned long _a0 asm("a0") = a0;
    register unsigned long _a1 asm("a1") = a1;
    register unsigned long _a2 asm("a2") = a2;
    register unsigned long _a3 asm("a3") = a3;
    register unsigned long _a4 asm("a4") = a4;
    register unsigned long _a5 asm("a5") = a5;

    asm volatile(
        "ecall"
        : "+r"(_a0), "+r"(_a1), "+r"(_a2), "+r"(_a3), "+r"(_a4), "+r"(_a5)
        : "r"(_a7)
        : "memory");

    return a0;
}

static inline long sys_write(const char *buf, unsigned long len)
{
    return __syscall(SYS_write, (unsigned long)buf, len, 0, 0, 0, 0);
}

static inline void sys_exit(int code)
{
    __syscall(SYS_exit, code, 0, 0, 0, 0, 0);
    while(1) asm volatile("wfi");
}

static inline void sys_yield(void)
{
    __syscall(SYS_yield, 0, 0, 0, 0, 0, 0);
}

static inline unsigned long sys_getpid(void)
{
    return __syscall(SYS_getpid, 0, 0, 0, 0, 0, 0);
}

static inline unsigned long sys_fork(void)
{
    return __syscall(SYS_fork, 0, 0, 0, 0, 0, 0);
}

static inline unsigned long sys_wait(int *status)
{
    return __syscall(SYS_wait, (unsigned long)status, 0, 0, 0, 0, 0);
}