global print
print:
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
	mov sp, bp
	ret
