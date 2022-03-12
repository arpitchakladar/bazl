org 0x7c00
bits 16

_start: ; initialize segment registers
	mov ax, 0
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00
	mov bp, 0x7c00

	mov ah, 2
	mov al, SECTOR_COUNT
	mov ch, 0
	mov cl, 2
	mov dh, 0
	mov bx, kernal
	int 0x13

	jmp kernal

times 510-($-$$) db 0
dw 0xaa55
kernal:
