;====================================================================
; helloworld.asm file for 8086 (NASM)
;====================================================================

; MAIN CODE - ROM
BITS 16
ORG 0x0000
 
SECTION .text

_start:
 	MOV AX, 0xA000   	; LCD I/O address  
    MOV DS, AX

LP:
	MOV AH, 08h
	CALL lcd_command
	
	MOV AH, 0Fh
	CALL lcd_command

    JMP LP
         

lcd_command:		 	; Send the command expressed in AH
	
						; Set RS = 0, RW = 0 for command mode
    MOV DX, 01h			; RS | RW | E1 | E2
    MOV AL, 0000b
    OUT DX, AL

    					; Send the command AX to I/O
    MOV DX, 00h			; Data port
	MOV AL, AH
    OUT DX, AL

   				 		; Pulse the E pin
    MOV DX, 01h			; RS | RW | E1 | E2
    MOV AL, 0010b
    OUT DX, AL
    RET

;print_char:


SECTION .data
