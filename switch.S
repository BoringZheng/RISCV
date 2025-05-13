/* switch.S  —— RISC-V 上下文切换，必须保存 a0 */
    .section .text
    .globl switch_context

/* a0 = &old, a1 = &new */
switch_context:
    sd  ra,  0*8(a0)
    sd  sp,  1*8(a0)
    sd  a0,  2*8(a0)      /* ★ 保存 a0 ★ */
    sd  s0,  3*8(a0)
    sd  s1,  4*8(a0)
    sd  s2,  5*8(a0)
    sd  s3,  6*8(a0)
    sd  s4,  7*8(a0)
    sd  s5,  8*8(a0)
    sd  s6,  9*8(a0)
    sd  s7, 10*8(a0)
    sd  s8, 11*8(a0)
    sd  s9, 12*8(a0)
    sd  s10,13*8(a0)
    sd  s11,14*8(a0)

    ld  ra,  0*8(a1)
    ld  sp,  1*8(a1)
    ld  a0,  2*8(a1)      /* ★ 恢复 a0 ★ */
    ld  s0,  3*8(a1)
    ld  s1,  4*8(a1)
    ld  s2,  5*8(a1)
    ld  s3,  6*8(a1)
    ld  s4,  7*8(a1)
    ld  s5,  8*8(a1)
    ld  s6,  9*8(a1)
    ld  s7, 10*8(a1)
    ld  s8, 11*8(a1)
    ld  s9, 12*8(a1)
    ld  s10,13*8(a1)
    ld  s11,14*8(a1)
    ret
