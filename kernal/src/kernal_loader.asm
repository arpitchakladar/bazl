%define NL 0x0d, 0x0a

bits 16

extern print

section .text
global _start
_start:
	push message
	call print
	hlt

message:
	db "Hello, World!", NL, 0x0
