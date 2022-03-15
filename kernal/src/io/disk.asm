bits 16
global disk_read_sectors
global disk_write_sectors

disk_read_sectors:
	push bp
	mov bp, sp

	mov ah, 0x02
	mov al, [bp + 10]
	mov ch, [bp + 14]
	mov cl, [bp + 18]
	mov dh, [bp + 22]
	mov dl, [bp + 26]
	mov bx, [bp + 6]
	int 0x13

	mov sp, bp
	pop bp
	ret

disk_write_sectors:
	push bp
	mov bp, sp

	mov ah, 0x03
	mov al, [bp + 10]
	mov ch, [bp + 14]
	mov cl, [bp + 18]
	mov dh, [bp + 22]
	mov dl, [bp + 26]
	mov bx, [bp + 6]
	int 0x13

	mov sp, bp
	pop bp
	ret
