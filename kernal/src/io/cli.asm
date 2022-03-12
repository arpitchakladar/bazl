bits 16
global cli_write
global cli_read

cli_write:
	push bp
	mov bp, sp

	mov si, 6
	mov si, [bp + si]
.loop:
	lodsb
	or al, al
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
	mov dx, [bp + 10]

	mov cx, 2
.loop:
	cmp dx, cx
	jl .end
	mov ah, 0
	int 0x16
	mov ah, al
	cmp ah, 0x0d
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
	xor di, [bp + 6]
	je .end_handle_backspace
	mov al, 0
	sub di, 1
	sub cx, 2
	mov [di], al
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

	mov ah, 0x0e
	mov bh, 0
	mov al, 0x0a
	int 0x10
	mov al, 0x0d
	int 0x10
	mov al, 0x00
	stosb

	mov sp, bp
	pop bp
	ret
