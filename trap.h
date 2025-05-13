#ifndef TRAP_H
#define TRAP_H

#define CLINT_MTIME     0x0200BFF8L 
#define CLINT_MTIMECMP  0x02004000L 
#define INTERVAL 1000000

void trap_init(void);
void timer_init(void);

#endif