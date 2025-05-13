#include "vm.h"
#include "../printf.h"
#include "vm_test.h"

#define MAX_ALLOC_PAGES 64
#define VA_BITS 39
#define LEVELS 3

#define VPNMASK 0x1FF
#define VA2VPN(va, level) (((va) >> (12 + (level) * 9)) & VPNMASK)
#define PTE2PA(pte) (((pte) >> 10) << 12)
//#define MAKE_PTE(pa, flags) (((pa) >> 12) << 10 | (flags))
#define MAKE_PTE(pa, flags) (((pa) & ~0xFFFUL) | ((flags) & 0x3FF))

// void test_mapping_rw(void)
// {
//     pde_t pagetable = (pde_t)alloc_page();
//     void *data_page = alloc_page();
//     unsigned long pa = (unsigned long)data_page;
//     if (map_page(pagetable, 0x40000000, pa, PAGE_PRESENT | PAGE_WRITE | PAGE_EXEC) == 0) puts("map_page success\n");
//     else puts("map_page failed\n");

//     map_page(pagetable, 0x80000000, 0x80000000, PAGE_PRESENT | PAGE_WRITE | PAGE_EXEC);
//     switch_pagetable(pagetable);
//     unsigned long satp;
//     asm volatile("csrr %0, satp" : "=r"(satp));
//     puts("SATP: 0x"); print_hex(satp); putchar('\n');


//     volatile int *p = (int *)0x40000000;
//     *p = 12345;

    
//     if (*p == 12345)
//     {
//         puts("Memory mapping and write test passed\n");
//     }
//     else
//     {
//         puts("Memory mapping and write test failed\n");
//     }
// }

void test_mapping_rw(void)
{
    pde_t pt = (pde_t)alloc_page();

    void *data_page = alloc_page();
    unsigned long pa = (unsigned long)data_page;

    // puts("Data page pa = ");
    // print_hex(pa); putchar('\n');

    map_page(pt, 0x40000000, pa, PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_PRESENT);
    map_page(pt, 0x80000000, 0x80000000, PAGE_READ | PAGE_WRITE | PAGE_EXEC | PAGE_PRESENT);

    switch_pagetable(pt);

    volatile int *p = (int *)0x40000000;
    *p = 12345;
    if (*p == 12345)
        puts("Memory mapping and write test passed\n");
    else
        puts("Memory mapping and write test failed\n");
}

void test_invalid_access(void)
{
    volatile int *p = (int *)0x40100000;
    *p = 1;
}

void dump_pagetable(pde_t pagetable)
{
    for (int i = 0; i < PTE_COUNT; ++i)
    {
        if (pagetable[i] & PAGE_PRESENT)
        {
            puts("PTE[");
            print_hex(i);
            puts("]: ");

            print_hex(pagetable[i]);
            puts("\n");
        }
    }
}