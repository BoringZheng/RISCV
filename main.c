#include "page.h"
#include "printf.h"
#include "proc.h"
#include "trap.h"
#define UART0 0x10000000L

void main()
{
     paging_init();
     trap_init();
     timer_init();
     proc_init();
     scheduler();
}
