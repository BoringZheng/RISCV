#ifndef VM_TEST_H
#define VM_TEST_H

#include "vm.h"

void test_mapping_rw(void);
void test_invalid_access(void);
void dump_pagetable(pde_t pagetable);

#endif