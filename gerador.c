#include <stdint.h>
#include <stdio.h>
#include <math.h>

#define print_bits(x)                                            \
  do {                                                           \
    unsigned long long a__ = (x);                                \
    size_t bits__ = sizeof(x) * 8;                               \
    printf(#x ": ");                                             \
    while (bits__--) putchar(a__ &(1ULL << bits__) ? '1' : '0'); \
    putchar('\n');                                               \
  } while (0)


int estado_inicial = 1 << 23 | 1;

int contador = 0;

int main(){

    int estado = estado_inicial;

    while(1){

        int novo_bit = ((estado >> 0) ^ (estado >> 17) ^ (estado >> 22) ^ (estado >> 23) ^ (estado >> 24)) & 1;
        estado = (estado >> 1) | (novo_bit << 23);


        contador++;

        if(estado == estado_inicial){
            break;
        }

    }

    printf("%d\n", contador);

    return 0;
}
-+