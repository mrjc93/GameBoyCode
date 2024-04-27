
#include <rand.h>
#include <stdio.h>
#include <gb/gb.h>

void initialize_random(void)
{
    UWORD seed;

    seed |= (UWORD)DIV_REG << 8;
    initarand((UWORD)DIV_REG << 8);
}

int random_number(int min, int max)
{
    return min + rand() % (max - min + 1);
}