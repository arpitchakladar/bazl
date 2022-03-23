bits 16

extern main
extern BOOT_DRIVE_NUMBER
extern sys_call
extern USER_NAME_MAX_LENGTH

section .text
global _start
_start:
	mov [BOOT_DRIVE_NUMBER], dl

; initialize system calls
	cli
	mov bx, sys_call
	mov [0x0088], bx
	mov [0x008a], cs
	sti

; start
	mov ax, message
	push ax
	mov ax, 0
	push ax
	int 0x22

	mov ax, [USER_NAME_MAX_LENGTH]
	push ax
	mov ax, wrong_file_name
	push ax
	mov ax, 4
	push ax
	int 0x22

	mov ax, correct_file_name
	push ax
	mov ax, wrong_file_name
	push ax
	mov ax, 5
	push ax
	int 0x22

	call main
	jmp $

wrong_file_name:
	db "Username1.txt", 0

correct_file_name:
	db "Username.txt", 0

message:
	db "Finished booting bazl...", 0x0d, 0x0a, 0
