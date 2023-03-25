%include "asm_io.inc"

segment .data
 msg: dw"invalid operation!"

segment .text
        global  _asm_main
_asm_main:
        enter   0,0
        pusha

		call read_int
		mov ebx, eax;first number is sotored in ebx
		call read_char
		mov ecx, eax;the operatore sotored in ecx;
		call read_int;
		mov edx,eax;the second operand is stored in edx;
		mov eax ,ebx;
		cmp ecx,43;for +
		je  sum;
		cmp ecx,45;for-
		je sub;
		cmp ecx,42;for*
		mov eax,0;
		je mul
		cmp ecx,47;for div
		je div;
		cmp ecx,37
		je baghi;
	invalid:
		mov ecx,10
		jmp div	
	baghi:
		sub ebx,edx;
		cmp ebx,edx;
		jge baghi;
		mov eax,ebx;
		jmp result1
	sum:
		add ebx,edx;
		mov eax,ebx;
		jmp result1
	sub:
		sub ebx,edx;
		mov eax,ebx;
		jmp result1
	mul:	
		add eax,ebx;
		dec edx
		cmp edx,0
		je result1
		jmp mul
	div:	
		mov eax,ebx;
		mov ebx,edx;
		cdq
		idiv ebx;
		cmp ecx,10
		je result2
		jmp result1
	result1:
		call print_int	
		call read_int
		jmp end
	result2:
		call print_int	
		call read_int
	end:
        popa
        mov     eax, 0
        leave                     
        ret
 