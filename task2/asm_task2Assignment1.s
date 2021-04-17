section	.rodata						; we define (global) read-only variables in .rodata section
	format_string: db "%s", 10, 0	; format string

section .bss						; we define (global) uninitialized variables in .bss section
	an: resb 33						; enough to store integer in [-2,147,483,648 (-2^31) : 2,147,483,647 (2^31-1)]

section .text
	global convertor
	extern printf
	extern exit

convertor:
	push ebp
	mov ebp, esp	
	pushad			

	mov ecx, dword [ebp+8]			; get function argument (pointer to string)

	cmp byte [ecx], 113 			; check if the first char is 'q'
	jz close						; if so quit the function
	mov eax, 3						; reset EAX reg to 3
	mov edx, 1						; reset EDX reg to 1
	jnz looping						; otherwise, go to loop
	
	looping:
		mov ebx, 0					; reset EBX reg to 0
		cmp byte [ecx], 57			; compare to '9'
		jle is_number				; if less or equal to '9', jumps to the number converting code
		jg is_letter				; if not, jumps to the letter converting code

	is_number:
		sub byte [ecx], 48			; substract 48 from char ASCII value in order to get number value
		jmp test_if_first			; jump to test_if_first

	is_letter:
		sub byte [ecx], 55			; substract 48 from char ASCII value in order to get letter value
		jmp test_if_first			; jump to test_if_first
	
	test_if_first:
		cmp edx, 1					; compare edx to 1 ; means we are in the first letter
		jz dec_to_binary_first		; is so, go to dec_to_binary_first
		jnz dec_to_binary			; if not, go to dec_to_binary

	
	dec_to_binary_first:
		cmp byte [ecx], 0			; compare [ecx] to 0
		jz next_char				; if so, continue to next_chat
		shr byte [ecx], 1			; shift [eax] right = devide [eax] by 2
		jc with_carry				; if shifting have carry
		jnc without_carry			; if shifting have no carry
		
	dec_to_binary:
		cmp ebx, 4					; compare EBX to 4
		je next_char				; if so, move to the next char
		shr byte [ecx], 1			; shift [eax] right = devide [eax] by 2
		jc with_carry				; if shifting have carry
		jnc without_carry			; if shifting have no carry

	with_carry:
		mov byte [an + eax], 31h	; insert to [an + eax] 1
		dec eax						; decrease string location couter
		inc ebx						; decrease num of bits counter
		jmp test_if_first			; go back to dec_to_binary

	without_carry:
		mov byte [an + eax], 30h	; insert to [an + eax] 0
		dec eax						; decrease string location couter
		inc ebx						; decrease num of bits counter
		jmp test_if_first			; go back to dec_to_binary

    next_char:
		cmp edx, 1
		jz add_first
		jnz add_not_first
		
	add_first:
		add an, ebx ; how to write?? {0x0, 0x0, 0x31h}
		add ebx, 4
		add eax, ebx
		mov edx, 0
		jmp next_char_continue

	add_not_first:
		add eax, 8					; add 8 to ecx value; now [an + eax] points to the 4th free space
		jmp next_char_continue

		
	next_char_continue:
		inc ecx      	  	  		; increment ecx value; now ecx points to the next character of the string
		cmp byte [ecx], 10			; check if the next character (character = byte) is new line \n
		jz finish					; if so, print string
		jnz looping     			; if not, keep looping until meet null termination character

	
	finish:
		sub eax, 3					; sub 3 from eax value; now [an + eax] points to the the first free space
		mov byte [an + eax], 0		; add null termination to string
		push an						; call printf with 2 arguments -  
		push format_string			; pointer to str and pointer to format string
		call printf
		add esp, 8					; clean up stack after call

		popad
		mov esp, ebp
		pop ebp
		ret

	close:
		popad
		mov esp, ebp	
		pop ebp
		call exit
