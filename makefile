CC = gcc
C_FLGAS = -m32 -fno-stack-protector -fno-builtin -Iinclude -Wall -Wextra -std=c11
CF = clang-format
ASM = nasm
ASM_FLAGS = -f elf32
LD = ld
LD_FLAGS = -m elf_i386
LD_FILES = build/boot.o build/kernel.o build/vga.o build/gdt.o build/gdts.o build/memory.o
QEMU = qemu-system-i386
QEMU_FLAGS = -M smm=off -monitor stdio
ISO = ktwo.iso

all: code_format setup_folders setup_boot setup_kernel setup_image setup_qemu

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
	$(CC) $(C_FLGAS) -c kernel/memory.c -o build/memory.o

setup_image:
	$(LD) $(LD_FLAGS) -T linker.ld -o ktwokernel $(LD_FILES) -z noexecstack
	mv ktwokernel ktwo/boot/kernel	
	grub-mkrescue -o ktwo.iso ktwo/
	rm -r build

setup_qemu:
	$(QEMU) $(ISO) $(QEMU_FLAGS)

# file ktwo.ios
# xorriso -indev ktwo.iso -find
# info registers
