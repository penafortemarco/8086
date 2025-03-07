; KERNEL
; Here the magic happens... Things... To do
; The Kernel is located on sector 2 (0x1000)
; DS and ES are already with 0x1000 value!

ORG 0x10000
BITS 16

CMP AL, 27
JE kml

start:
	CALL clear_screen

	MOV DH, 12
	MOV DL, 26
	CALL set_cursor
	MOV SI, wel1
	CALL print_string
	MOV DH, 13
	MOV DL, 24
	CALL set_cursor
	MOV SI, wel2
	CALL print_string
	MOV AH, 00h
	INT 16h
	CALL clear_screen
	MOV DX, 00h
	CALL set_cursor
		
kml:                 			; Kernel main loop
	MOV SI, prompt
	CALL print_string
	CALL get_string
	MOV SI, cli_buffer
	
	CALL new_line				; To debbug
	;CALL print_string  		; To debbug
	
	CALL exe_command
	
	JMP kml
	
wel1 db "Welcome to LascadOS!", 0
wel2 db "Press any key to continue", 0
prompt db "xandao@lascados:/$ ", 0

; ========== KERNEL PROCEDURES ============

; ROUTINE: exe_command
; 	SI -> cli_buffer that contains the command

exe_command:
	MOV DI, cmd_echo_str
	CALL strcmp
	CMP AL, 0
	JE  .cmd_echo
	
	MOV DI, cmd_clear_str
	CALL strcmp
	CMP AL, 0
	JE  .cmd_clear

	MOV DI, cmd_pico_str
	CALL strcmp
	CMP AL, 0
	JE  .cmd_pico

	MOV DI, cmd_reboot_str
	CALL strcmp
	CMP AL, 0
	JE .cmd_reboot

	JMP .cmd_invalid

.cmd_reboot:
	INT 19h

.cmd_pico:
	JMP 0x1000:0x0200	

.cmd_echo:
	MOV DX, echo_msg
	MOV SI, DX
	CALL print_string
	CALL new_line
	RET

.cmd_clear:
	CALL clear_screen
	MOV DX, 0
	CALL set_cursor
	RET

.cmd_invalid:
	MOV DX, invalid_msg
	MOV SI, DX
	CALL print_string
	CALL new_line
	RET

; ^------------ CMDs ------------^

cmd_reboot_str db "reboot", 0
cmd_pico_str db "pico", 0
cmd_clear_str db "clear", 0
cmd_echo_str db "echo", 0
echo_msg db "E C H O !", 0

invalid_msg db "Invalid command!", 0

; ROUTINE: strcmp
; 	SI -> str1 	(persist)
;	DI -> str2	(discard)
;   OUT: AL 1 if not equal, 0 if equal

strcmp:
	MOV BP, SI
.scloop:
	MOV AH, [BP]
	MOV AL, [DI]
	CMP AH, AL
	JNE .scne
	CMP BYTE [BP], 0
	JE  .sce
	INC BP
	INC DI
	JMP .scloop
.scne:
	MOV AL, 1
	RET
.sce:
	XOR AL, AL
	RET


; ========== TEXT IN PROCEDURES ===========

; ROUTINE: get_char
; 	BP -> terminal buffer offset 

get_char:
	MOV AH, 00h
	INT 16h
	MOV [BP], AL
	RET

; ROUTINE: get_string

get_string:
	MOV BP, cli_buffer
.gsloop: 
	CALL get_char
	CMP AL, 08h			; Does "Backspace"
	JE  .gsback   	 	
	CMP AL, 0Dh			; Done with "Return"
	JE  .gsdone
	CMP AL, 20h			; Ignore certain chars
	JB  .gsloop
	CALL put_char
	INC BP
	JMP .gsloop

.gsback:
	CMP BP, cli_buffer	; Stop the user from deleting the prompt
	JZ .gsloop			

	DEC BP				; Erase from buffer
	MOV BYTE [BP], 0
	
	MOV AH, 03h			; Get the cursor pos
	INT 10h
	DEC DL
	MOV BX, 0
	CALL set_cursor		; Back cursor one position
	MOV AL, 0
	MOV AH, 0Ah
	INT 10h
	JMP .gsloop
	
.gsdone:				; Put a 0 in the end of the buffer
	MOV AL, 0
	MOV [BP], AL		 
	RET
	

; ========== TEXT OUT PROCEDURES ==========

; ROUTINE: new_line

new_line:
	MOV AL, 0Ah
	CALL put_char
	MOV AL, 0Dh
	CALL put_char
	RET

; ROUTINE: clear_screen

clear_screen:	
	MOV DL, 79  ; Cols (expected)
	MOV DH, 24	; Rows (expected)
	MOV AL, 00h 
	MOV BH, 07h 
	MOV CX, 00h ; Start (0,0)
	MOV AH, 06h
	INT 10h     ; Clears the screen by scrolling
	RET


; ROUTINE: set_cursor
; 	DH -> Y (row) coordinate
;	DL -> X	(col) coordinate

set_cursor:
	MOV BH, 0h
	MOV AH, 02h
	INT 10h
	RET


; ROUTINE: put_char
;	AL -> Char (ASCII)

put_char:
	MOV CX, 1h
	MOV AH, 0Eh
	INT 10h
	RET


; ROUTINE: print_string
;	DS:SI -> String address

print_string:
PUT:
	MOV AL, [SI]
	CMP AL, 0h
	JZ RETZ 
	
	CALL put_char
	INC SI
	JMP PUT
		
RETZ:
	RET

cli_buffer db 0

times (512 - ($ - $$)) db 0
