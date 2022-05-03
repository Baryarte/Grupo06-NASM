# Grupo06-NASM

Trabalho de NASM 2022 - UnB - Software Básico

Compilação no Windows:

- nasm -f elf ./lfsr-NASM.asm
- nasm -f elf ./asm_io.asm
- gcc -m32 -o rotina.o rotina.c
- gcc -m32 -o rotinaASM ./lfsr-NASM.o ./asm_io.o rotina.o

Compilação no Linux:

- nasm -f elf -d ELF_TYPE ./lfsr-NASM.asm
- nasm -f elf -d ELF_TYPE ./asm_io.asm
- gcc -m32 -o rotina.o rotina.c
- gcc -m32 -o rotinaASM ./lfsr-NASM.o ./asm_io.o rotina.o

Executável: rotinaASM.exe
