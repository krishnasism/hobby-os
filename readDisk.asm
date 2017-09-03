readDisk:
	pusha
	mov ah, 0x02
	;booting from a harddisk - 0x80 - floppydisk - 0x00 -- https://en.wikipedia.org/wiki/INT_13H
	mov dl, 0x80
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

