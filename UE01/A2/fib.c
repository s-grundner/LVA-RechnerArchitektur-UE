#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>

uint32_t fib(uint32_t n) {
    uint32_t curr = 0;
    uint32_t prev = 1;
    uint32_t i = 0;

    while (i < n) {
        uint32_t tmp = curr + prev;
        prev = curr;
        curr = tmp;
        i = i + 1;
    }
    return curr;
}

void main(int argc, char *argv[])
{
    if (argc == 2) {
        printf("%u\n", fib(atoi(argv[1])));
    }
}
