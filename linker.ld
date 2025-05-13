OUTPUT_ARCH(riscv)
ENTRY(_start)

SECTIONS
{
    . = 0x80000000;

    .text : 
    {
        *(.text)
    }
    .rodata :
    {
        *(.rodata)
    }

    .bss : 
    {
        *(.bss COMMON)
    }

    .data :
    {
        *(.data)
    }
}