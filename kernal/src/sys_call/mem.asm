bits 16

extern sys_call_end
extern dyn_alloc
extern dyn_dealloc

global sys_call_dyn_alloc
global sys_call_dyn_dealloc

sys_call_dyn_alloc:
	mov dx, 0
	push dx
	mov ax, [bp + 12]
	push ax
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call dyn_alloc
	jmp sys_call_end

sys_call_dyn_dealloc:
	mov dx, 0
	push dx
	mov ax, [bp + 10]
	push ax
	push dx
	call dyn_dealloc
	jmp sys_call_end
