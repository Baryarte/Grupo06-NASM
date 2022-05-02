#include <inttypes.h>
#include <stdio.h>
#include <math.h>

#define MAX 16777216
#define Fe 4096


extern void lfsr();

uint32_t numbers[MAX];
int classes[Fe];
uint32_t size = 0;

// Funcao para salvar os valores calculados pelo LFSR
void save(uint32_t n) {
    // printf("ué %lu\n", size);
    numbers[size] = n;
    if( size == 16777000){
        printf("%lu\n", numbers[size]);
    }
    // size = size + 1;
}

void defineClasses(){
    for (uint32_t i = 0; i < size; i++) {
        uint32_t intervalo = numbers[i] / Fe;
        classes[intervalo]++;
    }
    for (uint32_t i = 0; i < Fe; i++) {
        if(classes[i] != 4096){
        printf("%d\n", classes[i]);}
        }
}

// Calcula o Chi Quadrado 
void _Chi_Square() {
    double Chi = 0, power;
    defineClasses();
    

    for (uint32_t i = 0; i < Fe; i++) {
    power = (classes[i] - Fe) * (classes[i] - Fe);
    Chi += power/Fe;
    }
    printf("Chi Quadrado:  %lf\n", Chi);
    
}



int main(){
    lfsr();
    printf("fim\n");
    return 0;
}
