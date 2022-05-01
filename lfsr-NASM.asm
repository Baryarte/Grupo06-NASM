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
	output1 db "intervalo ", 0
	output2 db " tem ", 0
	output3 db " elementos", 0
	seed	dd 8388609	; seed inicial

SECTION .bss
	class resd NN ; vetor com a frequencia de cada intervalo

SECTION .text
global _main
_main:

	mov ebx, [seed]   ; inicializa ebx com a semente 
    mov eax, ebx
    call print_int
    call print_nl
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
        call print_int
        call print_nl
		and eax, 0x00FFFFFF

		; Calculando a intervalo em que o numero pertence
		and eax, 0x0FFF

		; incrementa um nesse intervalo no vetor de frequencias
		add dword [class + eax*4], 1

		inc edx
		cmp edx, 16777215
	jne do

	; imprime as frequencias
	; mov ecx, 0
	; results:
	; 	mov eax, output1
	; 	call print_string

	; 	mov eax, ecx
	; 	call print_int

	; 	mov eax, output2
	; 	call print_string

	; 	mov eax, [class + ecx*4]
	; 	call print_int

	; 	mov eax, output3
	; 	call print_string

	; 	call print_nl
	; 	inc ecx
	; 	cmp ecx, NN
	; jne results


	; fim do programa

	mov ebx, 0
	mov eax, 1
	int 0x80