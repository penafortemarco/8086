#!/bin/bash

asm_nasm() {

	nasm -f bin raw_nasm/reset.asm -o raw_nasm/reset.bin
	nasm -f bin raw_nasm/main.asm -o raw_nasm/main.bin

	dd if=/dev/zero of=rom.bin bs=1 count=65536 					# Create an empty 64KB ROM file
	dd conv=notrunc if=raw_nasm/reset.bin of=raw_nasm/rom.bin bs=1 seek=65520	# Put reset code at ROM's 0xFFF0
	dd conv=notrunc if=raw_nasm/main.bin of=raw_nasm/rom.bin bs=1 seek=0 		# Put main code at ROM's 0x0000
	
}

asm_nasm
