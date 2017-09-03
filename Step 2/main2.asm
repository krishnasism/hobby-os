;load this code into 0x7c00 which is the mem pos of the boot sector

[org 0x7c00]




call readDisk
jmp test

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


readDisk:
	pusha
	mov ah, 0x02
	;booting from a harddisk - 0x80 - floppydisk - 0x00 -- https://en.wikipedia.org/wiki/INT_13H
	mov dl, 0x00
	mov ch, 0
	mov dh, 0
	mov al, 1
	mov cl, 2

	push bx
	mov bx, 0
	mov es, bx
	pop bx
	mov bx, 0x7c00 + 512

	int 0x13

	jc disk_err
	popa
	

	ret

	disk_err:
		mov si, DISK_ERR_MSG
		call printf
		jmp $



STR: db 'Krishnasis Mandal OS',0x0a,0x0d, 0
STR_T: db '....Welcome to KMOS',0x0a,0x0d, 0
STR_TH: db '....loading you in',0x0a,0x0d, 0
DISK_ERR_MSG: db 'Error Loading Disk', 0x0a, 0x0d,0
TEST_STRING: db 'You are in the second sector..',0x0a,0x0d, 0



;bootsector
;padding and magic number

times 510-($-$$) db 0
dw 0xaa55

test:
mov si, TEST_STRING
call printf
mov si, STR
call printf
mov si, STR_TH
call printf
mov si, STR_T
call printf
jmp $
;note to remove the hang code when not testing

times 512 db 0
