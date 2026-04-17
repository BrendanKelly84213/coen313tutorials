#include <stdio.h>
#include <stdlib.h>

int fib(int n) {
    if (n == 0 || n == 1) {
        return n;
    } 

    return fib(n - 1) + fib(n - 2);
}

int main(int argc, char** argv)
{
    int n = atoi(argv[1]);

    int result = fib(n);
    
    printf("fibonacci of: %d is: %d\n", n, result);

    int fib_result = 0;
    int fib1 = 0;
    int fib2 = 0;
    
fib:
    if (n = 1 || n = 0) {
        fib_result = n;
        goto done;
    }
    n = n - 1;
    goto fib;

    fib2 = n - 2;
        
done:
    return 0;
}
