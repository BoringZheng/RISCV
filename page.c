#include "page.h"
#include "mm/vm.h"
#include "printf.h"

extern void* alloc_page();

void paging_init(void)
{
    pde_t kernel_pagetable = (pde_t) alloc_page();
    //puts("1");
    for (int i = 0; i < PTE_COUNT; ++i) kernel_pagetable[i] = 0;
    //puts("1");
    map_page(kernel_pagetable, 0x80000000, 0x80000000, PAGE_READ | PAGE_WRITE | PAGE_EXEC);
    //puts("1");
    switch_pagetable(kernel_pagetable);
    unsigned long satp;
    asm volatile("csrr %0, satp" : "=r"(satp));
    puts("SATP: 0x"); print_hex(satp); putchar('\n');
}