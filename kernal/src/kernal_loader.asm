bits 16

extern main
extern BOOT_DRIVE_NUMBER
extern int_cli_write
extern int_cli_read

section .text
global _start
_start:
	mov [BOOT_DRIVE_NUMBER], dl

	call initialize_interrupts
	mov ax, message
	push ax
	int 0x22
	call main
	jmp $

initialize_interrupts:
	cli
	mov bx, int_cli_write
	mov [0x0088], bx
	mov [0x008a], cs
	mov bx, int_cli_read
	mov [0x008c], bx
	mov [0x008e], cs
	sti
	ret

message:
	db "THIS WAS CALLED BY AN INTERRUPT!", 0x0d, 0x0a, 0
