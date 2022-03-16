bits 16
global disk_read_sec
global disk_write_sec

extern BOOT_DRIVE_NUMBER

disk_read_sec:
	push bp
	mov bp, sp

	mov ah, 0x02
	mov al, [bp + 14]
	mov ch, 0
	mov cl, [bp + 10]
	mov dh, 0
	mov dl, [BOOT_DRIVE_NUMBER]
	mov bx, [bp + 6]
	int 0x13

	mov sp, bp
	pop bp
	ret

disk_write_sec:
	push bp
	mov bp, sp

	mov ah, 0x03
	mov al, [bp + 14]
	mov ch, 0
	mov cl, [bp + 10]
	mov dh, 0
	mov dl, [BOOT_DRIVE_NUMBER]
	mov bx, [bp + 6]
	int 0x13

	mov sp, bp
	pop bp
	ret
