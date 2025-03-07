; BOOTLOADER
; That is the first program BIOS will run.
; Here we will load the LascadOS Kernel to RAM.
; Load the Kernel to RAM is the only purpose of this code.
; Nothing more. Seriously.

ORG 0x7C00
BITS 16

start:
	CLI
	CLD
	
	MOV AL, 30 			; Number of sectors to read
	MOV CH, 0 			; Track
	MOV CL, 2			; Sector
	MOV DH, 0  			; Head
	MOV DL, 0 			; Drive
	MOV BX, 0x1000
	MOV DS, BX   		; Sets DS to 0x1000
	MOV ES, BX          ; Sets ES to 0x1000
	XOR BX, BX          ; BX to 0x0000
	MOV AH, 02h
	INT 13h
	JC  error			; Jump to 'error' if error happens

	JMP 0x1000:0x0000

error:
	MOV AL, 'E'
	MOV AH, 0Eh
	INT 10h
	HLT

times 510 - ($-$$) db 0
dw 0xAA55
