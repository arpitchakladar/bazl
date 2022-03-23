org 0x7c00
bits 16

_start:
init:; Initialize segment registers
	mov ax, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, KERNAL_START
	mov bp, KERNAL_START

	push dx ; Store the boot drive number

clear_screen:
	mov ah, 0x07
	mov al, 0x00
	mov bh, 0x07
	mov ch, 0
	mov cl, 0
	mov dh, 24
	mov dl, 79
	int 0x10

	mov ah, 0x02
	mov bh, 0
	mov dh, 0
	mov dl, 0
	int 0x10

	pop dx

load_kernal_sector:
	mov ah, 0x02
	mov al, KERNAL_SECTOR_COUNT - 1 ; the first sector is this boot loader
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov bx, KERNAL_START
	int 0x13

	jmp KERNAL_START

times 510-($-$$) db 0
dw 0xaa55
