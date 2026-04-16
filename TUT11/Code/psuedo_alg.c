#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    int r = a;
    int q = 0;
loop:
    if (r < b)
        goto done;
    q = q + 1;
    r = r - b;
    if (r >= b)
        goto loop;

done:
    printf("quotient: %d, remainder: %d\n", q, r);
    return 0;
}
