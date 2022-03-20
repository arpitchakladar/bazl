bits 16
global int_file_create
global int_file_rename
global int_file_delete
global int_file_write
global int_file_read

extern file_create
extern file_rename
extern file_delete
extern file_write
extern file_read

extern cli_write_int

int_file_create:
	push bp
	mov bp, sp

	mov dx, 0
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	mov ax, [bp + 8]
	push ax
	push dx
	call file_create

	mov sp, bp
	pop bp
	iret

int_file_rename:
	push bp
	mov bp, sp

	mov dx, 0
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	mov ax, [bp + 8]
	push ax
	push dx
	call file_rename

	mov sp, bp
	pop bp
	iret

int_file_delete:
	push bp
	mov bp, sp

	mov dx, 0
	push dx
	mov ax, [bp + 8]
	push ax
	push dx
	call file_rename

	mov sp, bp
	pop bp
	iret

int_file_write:
	push bp
	mov bp, sp

	mov dx, 0
	push dx
	mov ax, [bp + 12]
	push ax
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	mov ax, [bp + 8]
	push ax
	push dx
	call file_write

	mov sp, bp
	pop bp
	iret

int_file_read:
	push bp
	mov bp, sp

	mov dx, 0
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	mov ax, [bp + 8]
	push ax
	push dx
	call file_read

	mov sp, bp
	pop bp
	iret
