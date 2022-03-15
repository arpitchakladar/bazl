bits 16

extern main
extern BOOT_DRIVE_NUMBER

section .text
global _start
_start:
	mov [BOOT_DRIVE_NUMBER], dl
	call main
	jmp $
