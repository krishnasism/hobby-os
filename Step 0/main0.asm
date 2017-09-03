;bios command to move cursor forward. allows for lateral printing of character
mov ah, 0x0e 
;move character to print into al register
mov al, 'K'

;BIOS interrupt to print to screen
int 0x10



;infinite loop to hang bootsector
jmp $

;bootsector
;padding and magic number

times 510-($-$$) db 0
dw 0xaa55