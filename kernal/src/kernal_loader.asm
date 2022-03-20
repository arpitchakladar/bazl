bits 16

extern main
extern BOOT_DRIVE_NUMBER
extern user_name_max_len

section .text
global _start
_start:
	mov [BOOT_DRIVE_NUMBER], dl

	call initialize_interrupts

	mov ax, message
	push ax
	int 0x22

	mov ax, [user_name_max_len]
	push ax
	mov ax, file_name
	push ax
	int 0x24

	mov ax, file_name2
	push ax
	mov ax, file_name
	push ax
	int 0x25

	call main
	jmp $

extern int_cli_write
extern int_cli_read
extern int_file_create
extern int_file_rename
extern int_file_delete
extern int_file_write
extern int_file_read

initialize_interrupts:
	cli

	mov bx, int_cli_write ; int 0x22
	mov [0x0088], bx
	mov [0x008a], cs

	mov bx, int_cli_read ; int 0x23
	mov [0x008c], bx
	mov [0x008e], cs

	mov bx, int_file_create ; int 0x24
	mov [0x0090], bx
	mov [0x0092], cs

	mov bx, int_file_rename ; int 0x25
	mov [0x0094], bx
	mov [0x0096], cs

	mov bx, int_file_delete ; int 0x26
	mov [0x0098], bx
	mov [0x009a], cs

	mov bx, int_file_write ; int 0x27
	mov [0x009c], bx
	mov [0x009e], cs

	mov bx, int_file_read ; int 0x28
	mov [0x00a0], bx
	mov [0x00a2], cs

	sti
	ret

file_name:
	db "Username1.txt", 0

file_name2:
	db "Username.txt", 0

message:
	db "Finished booting bazl...", 0x0d, 0x0a, 0
