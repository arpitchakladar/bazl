bits 16

extern sys_call_cli_write
extern sys_call_cli_read
extern sys_call_dyn_alloc
extern sys_call_dyn_dealloc
extern sys_call_file_create
extern sys_call_file_rename
extern sys_call_file_delete
extern sys_call_file_write
extern sys_call_file_read

global sys_call
global sys_call_end

sys_call:
	push bp
	mov bp, sp

	mov ax, [bp + 8]
	mov dx, 2
	mul dx
	mov bx, .jmp_table
	add bx, ax
	jmp [bx]

.jmp_table:
	dw sys_call_cli_write
	dw sys_call_cli_read
	dw sys_call_dyn_alloc
	dw sys_call_dyn_dealloc
	dw sys_call_file_create
	dw sys_call_file_rename
	dw sys_call_file_delete
	dw sys_call_file_write
	dw sys_call_file_read

sys_call_end:
	mov sp, bp
	pop bp
	iret
