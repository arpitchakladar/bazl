bits 16

extern main

section .text
global _start
_start:
	call main
	jmp $
