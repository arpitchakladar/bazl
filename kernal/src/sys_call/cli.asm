bits 16

extern sys_call_end
extern cli_write
extern cli_read

global sys_call_cli_write
global sys_call_cli_read

sys_call_cli_write:
	mov dx, 0
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call cli_write
	jmp sys_call_end

sys_call_cli_read:
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
	call cli_read
	jmp sys_call_end
