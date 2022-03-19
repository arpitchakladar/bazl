bits 16
global cli_write
global cli_read

cli_write:
	push bp
	mov bp, sp

	mov ax, [bp + 6]
	push ax
	int 0x22

	mov sp, bp
	pop bp
	ret

cli_read:
	push bp
	mov bp, sp

	mov ax, [bp + 14]
	push ax
	mov ax, [bp + 10]
	push ax
	mov ax, [bp + 6]
	push ax
	int 0x23

	mov sp, bp
	pop bp
	ret
