CC = gcc
C_FLGAS = -g -m32 -fno-stack-protector -fno-builtin -Iinclude -Iarch/x86/include -Wall -Wextra -std=c11
CF = clang-format
ASM = nasm
ASM_FLAGS = -f elf32
LD = ld
LD_FLAGS = -m elf_i386
QEMU = qemu-system-i386
QEMU_FLAGS = -M smm=off -monitor stdio -d int -D arch/x86/kernelx86.log
ISO = ktwo.iso

all: code_format setup_folders setup_boot setup_kernel setup_image setup_qemu

code_format:
	$(CF) -i arch/x86/kernel/main.c
	$(CF) -i arch/x86/kernel/io.c
	$(CF) -i arch/x86/kernel/gdt/gdt.c
	$(CF) -i arch/x86/kernel/idt/idt.c
	$(CF) -i arch/x86/include/*
	$(CF) -i lib/memory.c
	$(CF) -i drivers/*
	$(CF) -i include/*

setup_folders:
	mkdir build

setup_boot:
	$(ASM) $(ASM_FLAGS) arch/x86/boot/boot.asm -o build/boot.o

setup_kernel:
	$(CC) $(C_FLGAS) -c arch/x86/kernel/main.c -o build/kernel.o
	$(CC) $(C_FLGAS) -c drivers/vga.c -o build/vga.o
	$(CC) $(C_FLGAS) -c arch/x86/kernel/gdt/gdt.c -o build/gdt.o
	$(ASM) $(ASM_FLAGS) arch/x86/kernel/gdt/gdt.asm -o build/gdts.o
	$(CC) $(C_FLGAS) -c lib/memory.c -o build/memory.o
	$(CC) $(C_FLGAS) -c arch/x86/kernel/io.c -o build/io.o
	$(CC) $(C_FLGAS) -c arch/x86/kernel/idt/idt.c -o build/idt.o
	$(ASM) $(ASM_FLAGS) arch/x86/kernel/idt/idt.asm -o build/idts.o
	$(CC) $(C_FLGAS) -c drivers/pit.c -o build/timer.o

setup_image:
	$(LD) $(LD_FLAGS) -T linker.ld -o ktwokernel build/* -z noexecstack
	mv ktwokernel ktwo/boot/kernel	
	grub-mkrescue -o ktwo.iso ktwo/
	rm -r build

setup_qemu:
	$(QEMU) $(ISO) $(QEMU_FLAGS)

# file ktwo.ios
# xorriso -indev ktwo.iso -find
# info registers
# addr2line -e ktwo/boot/kernel <addr>