#include "vm.h"
#include "printf.h"

#define MAX_ALLOC_PAGES 64
#define VA_BITS 39
#define LEVELS 3

#define VPNMASK 0x1FF
#define VA2VPN(va, level) (((va) >> (12 + (level) * 9)) & VPNMASK)
#define PTE2PA(pte) (((pte) >> 10) << 12)
//#define MAKE_PTE(pa, flags) (((pa) >> 12) << 10 | (flags))
#define MAKE_PTE(pa, flags) (((pa) & ~0xFFFUL) | ((flags) & 0x3FF))


#define BASE_ADDR 0x80200000

static char *page_pool[MAX_ALLOC_PAGES];
static int page_used[MAX_ALLOC_PAGES] = {0};

void* alloc_page() {
    for (int i = 0; i < MAX_ALLOC_PAGES; i++) {
        if (!page_used[i]) {
            page_used[i] = 1;
            page_pool[i] = (char *)(BASE_ADDR + i * PAGE_SIZE);
            // 清空页内容
            for (int j = 0; j < PAGE_SIZE; j++)
                ((volatile char*)page_pool[i])[j] = 0;
            // puts("Alloc page: ");
            // print_hex((unsigned long)page_pool[i]);
            // putchar('\n');
            return page_pool[i];
        }
    }
    return 0;
}

// void *alloc_page(void)
// {
//     for (int i = 0; i < MAX_ALLOC_PAGES; ++i)
//     {
//         if (!page_used[i])
//         {
//             page_used[i] = 1;
//             for (int j = 0; j < PAGE_SIZE; ++j) page_pool[i][j] = 0;
//             puts("Alloc page: ");
//             print_hex((unsigned long)page_pool[i]);
//             putchar('\n');
//             return (void *)page_pool[i];
//         }
//     }
//     return 0;
// }

int map_page(pde_t pagetable, unsigned long va, unsigned long pa, int flags)
{
    for (int level = LEVELS - 1; level > 0; level--)
    {
        int vpn = VA2VPN(va, level);
        pte_t *pte = &pagetable[vpn];
        
        // puts("\n the pagetable is "); print_hex(pagetable);
        // puts("\n the level is "); print_hex(level);
        // puts("\n the pte is "); print_hex(pte);
        // puts("\n the vpn is "); print_hex(vpn);
        if (*pte & PAGE_PRESENT)
        {
            pagetable = (pde_t)PTE2PA(*pte);
        }
        else
        {
            pde_t new_pagetable = (pde_t)alloc_page();
            if (!new_pagetable)
            {
                return -1; // 分配失败
            }
            for (int i = 0; i < PTE_COUNT; ++i) new_pagetable[i] = 0;
            *pte = MAKE_PTE((unsigned long)new_pagetable, PAGE_PRESENT);
            pagetable = new_pagetable;
        }
        // puts("\n the *pte now is "); print_hex(*pte);
    }

    int vpn0 = VA2VPN(va, 0);
    pagetable[vpn0] = MAKE_PTE(pa, flags | PAGE_PRESENT);
    // puts("\n the level is 0");
    // puts("\n the pagetable is "); print_hex(pagetable);
    // puts("\n the vpn0 is "); print_hex(vpn0);
    // puts("\n the pagetable[vpn0] is "); print_hex(pagetable[vpn0]);
    return 0;
}

void switch_pagetable(pde_t pagetable)
{
    unsigned long satp = (SATP_MODE_SV39 | (((unsigned long)pagetable >> 12) & 0xFFFFFFFFFFF));
    asm volatile("csrw satp, %0"::"r"(satp));
    asm volatile("sfence.vma");
}