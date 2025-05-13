#include "printf.h"
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
    current_proc->state = UNUSED;
    yield();
    return 0;
}

unsigned long sys_yield_impl(unsigned long a0, unsigned long a1, unsigned long a2,
                              unsigned long a3, unsigned long a4, unsigned long a5)
{
    yield();
    return 0;
}