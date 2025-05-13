#ifndef VM_H
#define VM_H

#include "../page.h"

#define PAGE_PRESENT 0x001
#define PAGE_WRITE 0x002
#define PAGE_USER 0x004
#define PAGE_EXEC 0x008
#define PAGE_READ 0x010
#define PTE_COUNT 512

typedef unsigned long pte_t;
typedef pte_t *pde_t;

int map_page(pde_t pagetable, unsigned long va, unsigned long pa, int flags);
void switch_pagetable(pde_t pagetable);
void *alloc_page(void);

#endif