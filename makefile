CC = gcc
C_FLGAS = -m32 -fno-stack-protector -fno-builtin -Iinclude -Wall -Wextra -std=c11
CF = clang-format
ASM = nasm
ASM_FLAGS = -f elf32

all: code_format setup_folders setup_boot setup_kernel setup_image

code_format:
	$(CF) -i kernel/*
	$(CF) -i include/*

setup_folders:
	mkdir build

setup_boot:
	$(ASM) $(ASM_FLAGS) boot/boot.asm -o build/boot.o
	$(ASM) $(ASM_FLAGS) boot/gdt.asm -o build/gdts.o

setup_kernel:
	$(CC) $(C_FLGAS) -c kernel/main.c -o build/kernel.o
	$(CC) $(C_FLGAS) -c kernel/vga.c -o build/vga.o
	$(CC) $(C_FLGAS) -c kernel/gdt.c -o build/gdt.o

setup_image:
	ld -m elf_i386 -T linker.ld -o ktwokernel build/boot.o build/kernel.o build/vga.o build/gdt.o build/gdts.o  -z noexecstack
	mv ktwokernel ktwo/boot/kernel	
	grub-mkrescue -o ktwo.iso ktwo/
	rm -r build
	qemu-system-i386 ktwo.iso

# file ktwo.ios
# xorriso -indev ktwo.iso -find
# sudo apt install grub-pc-bin
