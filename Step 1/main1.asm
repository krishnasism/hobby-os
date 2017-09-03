;load this code into 0x7c00 which is the mem pos of the boot sector

[org 0x7c00]

; store mem loc of STR in si
mov si, STR
; call label printf
call printf

mov si, STR_H
call printf

mov si, STR_TH
call printf


;infinite loop to hang bootsector
jmp $

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



STR: db "Krishnasis Mandal OS",0x0a,0x0d, 0
STR_H: db "Just getting started, doing random stuff",0x0a,0x0d, 0
STR_TH: db "Krishnasis Mandal OS", 0x0a,0x0d,0





;bootsector
;padding and magic number

times 510-($-$$) db 0
dw 0xaa55