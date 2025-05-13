#include "printf.h"
#define UART0 0x10000000L

void putchar(char c)
{
    *(volatile char *)UART0 = c;
}

void puts(const char *s)
{
    while(*s)
    {
        putchar(*s++);
    }
}

void print_hex(unsigned long value)
{
    const char *hex_chars = "0123456789ABCDEF";
    for (int i = 0; i < 16; i++) { // 64 位共 16 个字符
        unsigned char nibble = (value >> (60 - i*4)) & 0xF;
        *(volatile char *)0x10000000 = hex_chars[nibble];
    }
    *(volatile char *)0x10000000 = '\r';
    *(volatile char *)0x10000000 = '\n';
}