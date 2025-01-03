CC = gcc
C_FLGAS = -m32 -fno-stack-protector -fno-builtin -Iinclude -Wall -Wextra -std=c11

all:
	clang-format -i kernel/*
	clang-format -i include/*
	mkdir build
	$(CC) $(C_FLGAS) -c kernel/main.c -o build/kernel.o
	$(CC) $(C_FLGAS) -c kernel/vga.c -o build/vga.o
	nasm -f elf32 boot/boot.asm -o build/boot.o
	ld -m elf_i386 -T linker.ld -o ktwokernel build/boot.o build/kernel.o build/vga.o  -z noexecstack
	mv ktwokernel ktwo/boot/kernel
	grub-mkrescue -o ktwo.iso ktwo/
	rm -r build
	qemu-system-i386 ktwo.iso

# file ktwo.ios
# xorriso -indev ktwo.iso -find
# sudo apt install grub-pc-bin
