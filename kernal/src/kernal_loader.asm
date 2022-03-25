bits 16

extern BOOT_DRIVE_NUMBER

extern main
extern sys_call

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
	call main
	jmp $
