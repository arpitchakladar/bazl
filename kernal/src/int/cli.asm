bits 16

global int_cli_write
global int_cli_read

extern cli_write
extern cli_read

int_cli_write:
	push bp
	mov bp, sp

	mov ax, [bp + 8]
	push ax
	mov ax, 0
	push ax
	call cli_write

	mov sp, bp
	pop bp
	iret

int_cli_read:
	push bp
	mov bp, sp

	mov ax, [bp + 12]
	push ax
	mov ax, 0
	push ax
	mov ax, [bp + 10]
	push ax
	mov ax, 0
	push ax
	mov ax, [bp + 8]
	push ax
	mov ax, 0
	push ax
	call cli_read

	mov sp, bp
	pop bp
	iret
