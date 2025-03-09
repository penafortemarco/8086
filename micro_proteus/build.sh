#!/bin/bash

asm_nasm() {
	nasm -f bin raw_nasm/helloworld.asm -o helloworld.bin	
}

asm_nasm
