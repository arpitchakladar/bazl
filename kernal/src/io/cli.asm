bits 16
global cli_write
global cli_read

cli_write:
	push bp
	mov bp, sp

	mov si, [bp + 6]
.loop:
	lodsb
	cmp al, 0x00
	je .end
	mov ah, 0x0e
	mov bh, 0
	int 0x10
	jmp .loop
.end:

	mov sp, bp
	pop bp
	ret

cli_read:
	push bp
	mov bp, sp

	mov di, [bp + 6]
	mov dx, [bp + 14]

	mov cx, 2
.loop:
	cmp dx, cx
	jl .end
	mov ah, 0
	int 0x16
	mov ah, al
	cmp ah, [bp + 10]
	je .end
	mov ah, al
	cmp ah, 0x08
	je .handle_backspace
	mov ah, 0x0e
	mov bh, 0
	int 0x10
	stosb
	jmp .end_handle_backspace
.handle_backspace:
	cmp di, [bp + 6]
	je .end_handle_backspace
	mov al, 0
	mov [di], al
	sub di, 1
	sub cx, 2
	mov ah, 0x0e
	mov bh, 0
	mov al, 0x08
	int 0x10
	mov al, 0x20
	int 0x10
	mov al, 0x08
	int 0x10
.end_handle_backspace:
	inc cx
	jmp .loop
.end:

	mov al, 0x00
	mov [di], al

	mov sp, bp
	pop bp
	ret
