;====================================================================
; helloworld.asm file for 8086 (MASM)
;====================================================================
 
section .text

_start:
    MOV AX, 0F000H     	 
    MOV CS, AX        	 ; Set DS (data segment) to F0000H
 	MOV AX, 0F200H   	 ; LCD I/O address  
    MOV DS, AX
    MOV BX, 0000H     	 ; Load 0000H

LP:	MOV AL, 08H
	CALL lcd_command
	MOV AL, 0FH
	CALL lcd_command
    JMP LP
         

lcd_command:
	; Send the command expressed in AH
	
	; Set RS = 0, RW = 0 for command mode
    MOV DX, 01H		; RS | RW | E1 | E2
    MOV AL, 0000B
    OUT DX, AL

    ; Send the command
    MOV DX, 00H		; Data port
    MOV AL, AH
    OUT DX, AL

    ; Pulse the E pin
    MOV DX, 01H		; RS | RW | E1 | E2
    MOV AL, 0010B
    OUT DX, AL
    RET

;print_char:


section .data
