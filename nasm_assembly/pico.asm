; PICO: A TEXT EDITOR

ORG 0x10200
BITS 16

section .text

program:
	MOV AX, 0
	MOV DH, 0    
    je clearS

start:  
    mov ah, 0
    int 16h       ; Lê um caractere do teclado (BIOS)
    cmp al, 27    ; Se for ESC, sai do programa
    je 0x1000			; Back to the kernel's main loop
    cmp ax, 4800h ; Seta para cima
    je moveUp
    cmp ax, 4B00h ; Seta para esquerda
    je moveLeft
    cmp ax, 4D00H ; Seta para direita
    je moveRight
    cmp ax, 5000h ; Seta para baixo
    je moveDown

    CALL put_char
    jmp start

moveRight:
    mov dl, [posX]
    mov dh, [posY]
	CMP DL, 79
    JE  start
    inc dl
    mov [posX], dl
    jmp prntCrs

moveLeft:
    mov dl, [posX]
    mov dh, [posY]
	CMP DL, 0
    JE  start
    dec dl
    mov [posX], dl
    jmp prntCrs

moveUp: 
    mov dl, [posX]
    mov dh, [posY]
    CMP DH, 0
    JE  start
    dec dh
    mov [posY], dh
    jmp prntCrs

moveDown:   
    mov dl, [posX]
    mov dh, [posY]
    CMP DH, 24
    JE  start
    inc dh
    mov [posY], dh
    jmp prntCrs

prntCrs:
    mov dh, [posY]
    mov dl, [posX]
	CALL set_cursor
    jmp start

clearS:
	CALL clear_screen

    MOV DX, 0
    CALL set_cursor
    int 10h
    jmp start

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

section .bss
posX resb 1
posY resb 1

section .data

msg db "CAIO FELIPE HEROI NACIONAL", 0
times 510 - ($ - $$) db 0
