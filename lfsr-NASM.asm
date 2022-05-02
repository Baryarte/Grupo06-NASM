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

SECTION .data
	seed	dd 8388609	; seed inicial

SECTION .bss

SECTION .text
extern __Chi_Square
extern _size, _numbers
global _lfsr
_lfsr:
	push ebp
	mov ebp,esp 
	mov ebx, [seed]   ; inicializa ebx com a semente 
    mov eax, ebx

	mov edx, 0      ; inicializa edx com 0
	do:
        ; feedback polinomial -> x^24 + x^23 + x^22 + x^17 + 1

		mov ecx, ebx   
		mov eax, ebx   ; na primeira iteracao eax tera na sua direita o bit 24
		shr ecx, 1     ; ecx tera o bit 23
		xor eax, ecx    
		shr ecx, 1     ; ecx tera o bit 22 
		xor eax, ecx
		shr ecx, 5	   ; ecx tera o bit 17
		xor eax, ecx
		and eax, 1	   ; novo_bit = (bit24 xor bit23 xor bit22 xor bit17)

		shl eax, 23 ; (novo_bit << 23)
		shr ebx, 1  ; (estado >> 1)
		or eax, ebx ; (estado >> 1) | (novo_bit << 23);
		mov ebx, eax ; salva o estado em ebx
		; call print_int
        ; call print_nl
		mov [_size], edx
		mov dword [_numbers + edx * 4], ebx
	
        
		inc edx
		cmp edx, 0x00FFFFFF ; 16777215
	jne do
	; mov eax, edx
	; call print_int
	; call print_nl


	; fim do programa
	call __Chi_Square
	mov esp, ebp
	pop ebp
	mov eax, 0
	ret