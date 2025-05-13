#include "trap.h"
#include "proc.h"
#include "syscall.h"
#include "printf.h"

static unsigned long sys_write_impl(unsigned long, unsigned long, unsigned long,
                                    unsigned long, unsigned long, unsigned long);
static unsigned long sys_exit_impl(unsigned long, unsigned long, unsigned long,
                                    unsigned long, unsigned long, unsigned long);
static unsigned long sys_yield_impl(unsigned long, unsigned long, unsigned long,
                                      unsigned long, unsigned long, unsigned long);
static unsigned long sys_getpid_impl(unsigned long, unsigned long, unsigned long,
                                      unsigned long, unsigned long, unsigned long);
static unsigned long sys_fork_impl(unsigned long, unsigned long, unsigned long,
                                      unsigned long, unsigned long, unsigned long);
static unsigned long sys_wait_impl(unsigned long, unsigned long, unsigned long,
                                      unsigned long, unsigned long, unsigned long);

static unsigned long (*sys_table[NR_SYSCALLS])(unsigned long, unsigned long, unsigned long,
                                    unsigned long, unsigned long, unsigned long) = 
{
    sys_write_impl,
    sys_exit_impl,
    sys_yield_impl,
    sys_getpid_impl,
    sys_fork_impl,
    sys_wait_impl,
};

void trap_handler(void);

void trap_init(void)
{
    extern void __kernelvec();
    asm volatile("csrw mtvec, %0" : : "r"(__kernelvec));
    // supervisor mode 需要用stvec， 但是裸机没有OPENSBI只能用mtvec， 最让人红温的一集
}

void timer_init(void)
{
    *(volatile unsigned long *)(CLINT_MTIMECMP) = *(volatile unsigned long *)(CLINT_MTIME) + INTERVAL;
    //puts("1");
    asm volatile("csrs mie, %0" : : "r"(1 << 7));
    //puts("1");
    asm volatile("csrs mstatus, %0" : : "r"(1 << 3));
    //puts("1");
    
    // unsigned long mtime = *(volatile unsigned long *)CLINT_MTIME;
    // unsigned long mtimecmp = mtime + INTERVAL;
    // *(volatile unsigned long *)CLINT_MTIMECMP = mtimecmp;

    //print_hex(mtime);

    //puts("1");

    //print_hex(mtimecmp);
    //*(volatile unsigned long *)(CLINT_MTIMECMP) = *(volatile unsigned long *)(CLINT_MTIME) + INTERVAL;
}

void trap_handler()
{
    unsigned long mcause, mepc;
    asm volatile("csrr %0, mcause" : "=r"(mcause));
    asm volatile("csrr %0, mepc" : "=r"(mepc));

    int is_interrupt = (mcause >> 63) & 1;
    int cause_code = mcause & 0xff;

    if (!is_interrupt && cause_code == 11)
    {
        register unsigned long a7 asm("a7");
        register unsigned long a0 asm("a0");
        register unsigned long a1 asm("a1");
        register unsigned long a2 asm("a2");
        register unsigned long a3 asm("a3");
        register unsigned long a4 asm("a4");
        register unsigned long a5 asm("a5");

        if (a7 < NR_SYSCALLS && sys_table[a7])
        {
            a0 = sys_table[a7](a0, a1, a2, a3, a4, a5);
        }
        else
        {
            a0 = -1;
        }
        asm volatile("csrw mepc, %0" : : "r"(mepc + 4));
    }
    else if (is_interrupt && cause_code == 7)
    {
        *(volatile unsigned long *)(CLINT_MTIMECMP) = *(volatile unsigned long *)(CLINT_MTIME) + INTERVAL;
        extern volatile int need_sched;
        need_sched = 1;
    }
    else
    {
        puts("[trap] strange interrupt!\n");
        puts("mcause:"); print_hex(mcause); puts("\n");
        puts("mepc:"); print_hex(mepc); puts("\n");
    }
    //while (1) asm volatile("wfi");
}
