; IO PROCEDURES

; ROUTINE: clear
; Calls: INT 10h, AH: 

clear:
	MOV AH, 0h
	MOV AL, 13h
	INT 10h         ; Call BIOS video service
	RET

; ROUTINE: set_cursor
; Usage:
; 	DH -> Y (row) coordinate
;	DL -> X	(col) coordinate
; Calls: INT 10h, AH: 02h

set_cursor:
	MOV AH, 02h
	INT 10h
	RET

; ROUTINE: put_char
; Usage:
;	AL -> Char (ASCII)	
;	BL -> Text Color
; Calls: INT 10h, AH: 09h

put_char:
	MOV CX, 1h
	MOV AH, 0Eh
	INT 10h
	RET

; ROUTINE: print_string
; Usage:
;	DS:SI -> String address
;	BL -> Text Color
; Calls: put_char, set_cursor

print_string:
PLP:
	MOV AL, [DS:SI]
	CMP AL, 0h
	JZ RETZ 
	
	CALL put_char
	INC SI
	JMP PLP
		
RETZ:
	RET
