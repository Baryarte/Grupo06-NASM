#include <stdint.h>
#include <stdio.h>
#include <math.h>
#define MAX 16777216
#define Fe 4096
extern void _lfsr();

long int numbers[MAX];
long int size = 0;

// Funcao para salvar os valores calculados pelo LFSR
void _save(int n) {
    numbers[size] = n;
    size++;
}

// Calcula o Chi Quadrado em um intervalo especificado
void Chi_Square(int begin, int end) {
    double Chi = 0, power;
    for(int i = begin; i < end; i++) {
        power = (numbers[i] - Fe) * (numbers[i] - Fe);
        Chi += power/Fe;
    }

    printf("Chi Quadradro (%d - %d) = %lf\n", begin, end, Chi);
}

// Calcula o Chi Quadrado em todos os intervalos
void _Chi_Square() {
    for(int i = 0; i < size; i += 4096) {
        Chi_Square(i, 4096 + i);
    } 
}

int main(){
    _lfsr();
    return 0;
}
