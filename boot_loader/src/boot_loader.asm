[org 0x7c00]

; Constants in memory
KERNEL_LOCATION equ 0x1000
CODE_SEG equ code_descriptor - GDT_Start
DATA_SEG equ data_descriptor - GDT_Start

_start:
init:
	; Initialize segment registers
	mov [BOOT_DISK], dl
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov bp, 0x8000              ; Sets Base Pointer (stack frame) to 0x8000
	mov sp, bp

	mov bx, KERNEL_LOCATION   ; Sets BX to the target address for the kernel (0x1000)
	mov dh, 2                   ; Specifies to load 2 sectors

	mov ah, 0x02                ; BIOS interrupt 0x13, function 0x02 (Read Disk Sectors)
	mov al, dh                  ; AL = number of sectors to read (2)
	mov ch, 0x00                ; CH = cylinder number (0)
	mov dh, 0x00                ; DH = head number (0)
	mov cl, 0x02                ; CL = sector number (start from sector 2)
	mov dl, [BOOT_DISK]         ; DL = drive number (obtained from BIOS earlier)
	int 0x13                    ; Calls BIOS interrupt 0x13 to perform the read

	mov ah, 0x0                 ; BIOS interrupt 0x10, function 0x00 (Set Video Mode)
	mov al, 0x3                 ; AL = mode 0x03 (80x25 color text mode)
	int 0x10                    ; Calls BIOS interrupt 0x10 to set the video mode

	cli ; disable interrupts
	lgdt [GDT_Descriptor]
	mov eax, cr0
	or eax, 1
	mov cr0, eax
	jmp CODE_SEG:start_protected_mode
	jmp $

BOOT_DISK: db 0
GDT_Start:
null_descriptor:
	dd 0x0 ; 00000000
	dd 0x0 ; 00000000
code_descriptor:
	dw 0xffff ; first 16 bits of limit
	; first 24 bits of the base
	dw 0x0 ; 16 +
	db 0x0 ; 8 = 24
	; ppt + type flags
	db 0b10011010
	; other flags + last 4 bit of limit
	db 0b11001111
	; last 8 bits of base
	db 0x0
data_descriptor:
	dw 0xffff
	dw 0x0
	db 0x0
	db 0b10010010 ; different type flags
	db 0b11001111
	db 0x0
GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1 ; size
	dd GDT_Start ; start

[bits 32]
start_protected_mode:
	mov ax, DATA_SEG        ; Load data segment selector into AX
	mov ds, ax              ; Set Data Segment register
	mov ss, ax              ; Set Stack Segment register
	mov es, ax              ; Set Extra Segment register
	mov fs, ax              ; Set FS register
	mov gs, ax              ; Set GS register

	mov ebp, 0x90000        ; Set 32-bit stack base pointer
	mov esp, ebp            ; Set 32-bit stack pointer

	jmp KERNEL_LOCATION   ; Jump to the loaded kernel

times 510-($-$$) db 0
dw 0xaa55
