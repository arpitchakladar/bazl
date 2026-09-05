[org 0x7c00]
[bits 16]

; Constants in memory
CODE_SEG equ code_descriptor - GDT_Start ; Offset in GDT
DATA_SEG equ data_descriptor - GDT_Start

_start:
	; Initialize segment registers
	mov byte [BOOT_DISK], dl
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov bp, word 0x8000              ; Sets Base Pointer (stack frame) to 0x8000
	mov sp, bp

	mov bx, word KERNEL_START        ; Sets BX to the target address for the kernel
	mov dh, byte KERNEL_SECTOR_COUNT ; Specifies to load number of sectors

	mov ah, byte 0x02                ; BIOS interrupt 0x13, function 0x02 (Read Disk Sectors)
	mov al, dh                       ; AL = number of sectors to read (2)
	mov ch, byte 0x00                ; CH = cylinder number (0)
	mov dh, byte 0x00                ; DH = head number (0)
	mov cl, byte 0x02                ; CL = sector number (start from sector 2)
	mov dl, byte [BOOT_DISK]         ; DL = drive number (obtained from BIOS earlier)
	int 0x13                         ; Calls BIOS interrupt 0x13 to perform the read

	mov ah, byte 0x00                ; BIOS interrupt 0x10, function 0x00 (Set Video Mode)
	mov al, byte 0x03                ; AL = mode 0x03 (80x25 color text mode)
	int 0x10                         ; Calls BIOS interrupt 0x10 to set the video mode

	; Enable A20 line
	mov ax, 0x2401        ; BIOS INT 15h Fast A20 enable
	int 0x15
	jnc .a20_done         ; If Carry Flag is clear, it succeeded

	in al, 0x92           ; Fallback: Fast A20 via Port 0x92
	or al, 2
	and al, 0xFE
	out 0x92, al

.a20_done:
	cli ; disable interrupts
	; Enter 32 bit protected mode
	lgdt [GDT_Descriptor]
	mov eax, cr0
	or eax, dword 1
	mov cr0, eax
	jmp CODE_SEG:start_protected_mode

BOOT_DISK: db 0x00

; Using Flat memory (the entire memory is both code and data)
GDT_Start:
null_descriptor:
	dd 0x00000000 ; 00000000
	dd 0x00000000 ; 00000000
code_descriptor:
	dw 0xffff ; first 16 bits of limit
	; first 24 bits of the base
	dw 0x0000 ; 16 +
	db 0x00 ; 8 = 24
	; ppt + type flags
	db 0b10011010
	; other flags + last 4 bit of limit
	db 0b11001111
	; last 8 bits of base
	db 0x00
data_descriptor:
	dw 0xffff
	dw 0x0000
	db 0x00
	db 0b10010010 ; different type flags
	db 0b11001111
	db 0x00
GDT_End:

GDT_Descriptor:
	dw GDT_End - GDT_Start - 1 ; size
	dd GDT_Start ; start

[bits 32]
start_protected_mode:
	mov ax, word DATA_SEG   ; Load data segment selector into AX
	mov ds, ax              ; Set Data Segment register
	mov ss, ax              ; Set Stack Segment register
	mov es, ax              ; Set Extra Segment register
	mov fs, ax              ; Set FS register
	mov gs, ax              ; Set GS register

	mov ebp, dword 0x9FC00  ; Set 32-bit stack base pointer
	mov esp, ebp            ; Set 32-bit stack pointer

	jmp KERNEL_START   ; Jump to the loaded kernel

times 510-($-$$) db 0
dw 0xaa55
