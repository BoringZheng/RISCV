#ifndef PRINTF_H
#define PRINTF_H

#define UART0 0x10000000L

void print_hex(unsigned long value);
void putchar(char c);
void puts(const char *s);

#endif