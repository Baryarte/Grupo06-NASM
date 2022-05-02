#include <stdint.h>
#include <stdio.h>
#define MAX 16777216
#define Fe 4096.00
extern void _lfsr();

uint32_t numbers[MAX];
uint32_t freq[4096];
uint32_t size = 0;

// Funcao para salvar os valores calculados pelo LFSR e determinar suas classes
void _save(uint32_t n) {
    numbers[size] = n;
    size++;
}

// Funcao para determinar a frequencia observada
double getFrequency() {
    int count = 0;
    for(uint32_t i = 0; i < size; i++) {
        freq[numbers[i]/4096]++;
    }

    for(uint32_t i = 0; i < 4096; i++) {
        if(freq[i] > 0) count++;
    }

    return count/1.0;
}

// Calcula o Chi Quadrado
void _Chi_Square() {
    double Chi, power, Fo;

    Fo = getFrequency();
    power = (Fo - Fe) * (Fo - Fe);
    Chi = power/Fe;

    printf("Frequencia Observada = %.2f\t", Fo);
    printf("Frequencia Esperada = %.2f\t", Fe);
    printf("Chi Quadradro = %.2f\n", Chi);
}

int main(){
    for(uint32_t i = 0; i < 4096; i++) {
        freq[i] = 0;
    }

    _lfsr();
    return 0;
}
