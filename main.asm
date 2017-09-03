;load this code into 0x7c00 which is the mem pos of the boot sector

[org 0x7c00]




call readDisk
jmp test

;infinite loop to hang bootsector
jmp $


%include "./printf.asm"
%include "./readDisk.asm"

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
