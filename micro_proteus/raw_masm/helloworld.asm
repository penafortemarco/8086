;====================================================================
; helloworld.asm file for 8086 (MASM)
;====================================================================
.MODEL SMALL
 
.CODE
START:
    MOV AX, 0F000H     	 
    MOV CS, AX        	 ; Set DS (data segment) to F0000H
 	MOV AX, 0F200H   	 ; LCD I/O address  
    MOV DS, AX
    MOV BX, 0000H     	 ; Load 0000H

LP:	MOV AH, 08H
	CALL lcd_command
	MOV AH, 0FH
	CALL lcd_command
    JMP LP
         
END START

lcd_command PROC
	; Send the command in AH
	; Set RS = 0, RW = 0 for command mode
    MOV DX, 01H		; RS | RW | E1 | E2
    MOV AL, 0000B
    OUT DX, AL

    ; Send the command
    MOV DX, 00H		; Data port
    OUT DX, AH

    ; Pulse the E pin
    MOV DX, 01H		; RS | RW | E1 | E2
    MOV AL, 0010B
    OUT DX, AL
    RET

lcd_command ENDP

;print_char PROC

;print_char ENDP

.DATA
