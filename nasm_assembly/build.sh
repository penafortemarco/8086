#!/bin/sh

write_to_diskette(){

	local image="disk.img"
	nasm -f bin bootloader.asm -o bootloader
	nasm -f bin kernel.asm -o kernel
	nasm -f bin pico.asm -o pico
	echo "Compiled!"

	dd conv=notrunc if=bootloader of=$image bs=512 count=1 seek=0
	dd conv=notrunc if=kernel of=$image bs=512 count=1 seek=1
	dd conv=notrunc if=pico of=$image bs=512 count=1 seek=2
	echo "Writed!"

	qemu-system-i386 -machine q35 -fda disk.img -monitor stdio
}

write_to_sdb(){
	
	local device="$1"

	if [[ -z "$device" ]]; then
        echo "Usage: write_to_sdb <device>"
        echo "Example: write_to_sdb /dev/sdb"
        return 1
    fi

    sudo umount "$device" 2>/dev/null

    nasm -f bin bootloader.asm -o bootloader
   	nasm -f bin kernel.asm -o kernel
   	nasm -f bin pico.asm -o pico
   	echo "Compiled!"
   
   	dd conv=notrunc if=bootloader of=$device bs=512 count=1 seek=1
   	dd conv=notrunc if=kernel of=$device bs=512 count=1 seek=2
   	dd conv=notrunc if=pico of=$device bs=512 count=1 seek=3
   	echo "Writed!"

   	qemu-system-i386 -machine q35 -fda $device -monitor stdio

}

write_to_sdb /dev/sdb
