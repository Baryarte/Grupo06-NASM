; Grupo 6
;
; Implementação do gerador de números aleatórios com LFSR em NASM
;
;
; Comando para gerar objeto: nasm -f elf lfsr-NASM.asm
; 
; Comando para compilação: gcc -m32 lfsr-NASM.o -o lfsr asm_io.o
;
; (necessário gerar objeto do asm_io: nasm -f elf asm_io.asm)


%include "asm_io.inc"
%define NN 4096 ; numero de intervalos

SECTION .data
	seed	dd 8388609	; seed inicial

SECTION .bss
	class resd NN ; vetor com a frequencia de cada intervalo

SECTION .text
extern _save, _Chi_Square
global _lfsr
_lfsr:
	mov ebx, [seed]   ; inicializa ebx com a semente 
    mov eax, ebx
    ;call print_int
    ;call print_nl
    push eax
    call _save
    pop eax

	mov edx, 0      ; inicializa edx com 0
	do:
        ; feedback polinomial -> x^24 + x^23 + x^22 + x^17 + 1

		mov ecx, ebx    
		mov eax, ebx   
		shr ecx, 1      
		xor eax, ecx    
		shr ecx, 1      
		xor eax, ecx
		shr ecx, 5
		xor eax, ecx
		and eax, 1

		shl eax, 23 ; (novo_bit << 23)
		shr ebx, 1  ; (estado >> 1)
		or eax, ebx ; (estado >> 1) | (novo_bit << 23);
		mov ebx, eax ; salva o estado em ebx
		;call print_int
        ;call print_nl
        push ebx
        call _save
        pop ebx
        
		inc edx
		cmp edx, 16777215
	jne do



	; fim do programa
	call _Chi_Square
	mov ebx, 0
	mov eax, 1
	int 0x80