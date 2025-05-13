.section .text
.globl __kernelvec
__kernelvec:
    addi sp, sp, -128
    sd ra,   0(sp)
    sd sp,   8(sp)
    sd s0,  16(sp)
    sd s1,  24(sp)
    sd s2,  32(sp)
    sd s3,  40(sp)
    sd s4,  48(sp)
    sd s5,  56(sp)
    sd s6,  64(sp)
    sd s7,  72(sp)
    sd s8,  80(sp)
    sd s9,  88(sp)
    sd s10, 96(sp)
    sd s11,104(sp)

    call trap_handler

    ld ra,   0(sp)
    ld sp,   8(sp)
    ld s0,  16(sp)
    ld s1,  24(sp)
    ld s2,  32(sp)
    ld s3,  40(sp)
    ld s4,  48(sp)
    ld s5,  56(sp)
    ld s6,  64(sp)
    ld s7,  72(sp)
    ld s8,  80(sp)
    ld s9,  88(sp)
    ld s10, 96(sp)
    ld s11,104(sp)

    addi sp, sp, 128
    mret
