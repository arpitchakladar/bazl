bits 16

extern sys_call_end
extern file_create
extern file_rename
extern file_delete
extern file_write
extern file_read

global sys_call_file_create
global sys_call_file_rename
global sys_call_file_delete
global sys_call_file_write
global sys_call_file_read

sys_call_file_create:
	mov dx, 0
	push dx
	mov ax, [bp + 12]
	push ax
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call file_create
	jmp sys_call_end

sys_call_file_rename:
	mov dx, 0
	push dx
	mov ax, [bp + 12]
	push ax
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call file_rename

	jmp sys_call_end

sys_call_file_delete:
	mov dx, 0
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call file_rename
	jmp sys_call_end

sys_call_file_write:
	mov dx, 0
	push dx
	mov ax, [bp + 14]
	push ax
	push dx
	mov ax, [bp + 12]
	push ax
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call file_write
	jmp sys_call_end

sys_call_file_read:
	mov dx, 0
	push dx
	mov ax, [bp + 12]
	push ax
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call file_read
	jmp sys_call_end
