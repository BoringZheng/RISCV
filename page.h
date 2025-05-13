#ifndef PAGE_H
#define PAGE_H

#define PAGE_SIZE 4096
#define SATP_MODE_SV39 (8ULL << 60)

void paging_init(void);

#endif