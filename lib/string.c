#include <stddef.h>

void *memmove(void *dst, const void *src, size_t n)
{
    unsigned char *d = dst;
    const unsigned char *s = src;
    if (d < s)           /* 正向复制 */
        for (size_t i = 0; i < n; i++) d[i] = s[i];
    else                 /* 反向复制，防重叠 */
        while (n--) d[n] = s[n];
    return dst;
}

void *memcpy(void *dst, const void *src, size_t n)
{
    unsigned char *d = dst;
    const unsigned char *s = src;
    for (size_t i = 0; i < n; i++) d[i] = s[i];
    return dst;
}

void *memset(void *dst, int c, size_t n)
{
    unsigned char *d = dst;
    while (n--) *d++ = (unsigned char)c;
    return dst;
}
