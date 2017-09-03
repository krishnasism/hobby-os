printf:
	;push everything to stack - dont interfere w/ other stuff
	pusha
	str_loop: 

		; move value at si to al
		mov al,	[si]
		; compare al to 0
		cmp al, 0
		if jne print_char 

		;if doesnt jump, i.e., end of STR
		popa
		ret

	print_char : 
		;refer to previous notes
		mov ah , 0x0e
		int 0x10
		;move forward mem loc by 1	
		add si, 1
		jmp str_loop
