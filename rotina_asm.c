#include <stdint.h>
#include <stdio.h>
#include <math.h>
#define MAX 16777215
#define Fe 4096.0
extern void _lfsr();

long int numbers[MAX];
long int freq[MAX];
long int size = 0;

// Funcao para salvar os valores calculados pelo LFSR
void _save(int n) {
    numbers[size] = n;
    size++;
}

// Funcao para determinar a frequencia observada em um intervalo especificado
int getFrequency(int begin, int end) {
    int count = 0;
    for(int i = 0; i < MAX; i++) {
        freq[i] = 0;
    }

    for(int i = begin; i < end; i++) {
        freq[numbers[i]-1]++;
    }

    for(int i = 0; i < MAX; i++) {
        if(freq[i] != 0) count++;
    }

    return count;
}

// Calcula o Chi Quadrado em um intervalo especificado
void Chi_Square(int begin, int end) {
    double Chi = 0, power, Fo;
    
    Fo = getFrequency(begin, end);
    power = (Fo - Fe) * (Fo - Fe);
    Chi += power/Fe;
    
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
