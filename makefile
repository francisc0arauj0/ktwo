KERNEL_ARCH = x86
BITS_ARCH = 32
LD_QEMU_ARCH = i386

CC = gcc
C_FLGAS = -g -m$(BITS_ARCH) -fno-stack-protector -fno-builtin -Iinclude -Iinclude/std -Iarch/x86/include -Wall -Wextra -std=c11
CF = clang-format
ASM = nasm
ASM_FLAGS = -f elf$(BITS_ARCH)
LD = ld
LD_FLAGS = -m elf_$(LD_QEMU_ARCH)
QEMU = qemu-system-$(LD_QEMU_ARCH)
QEMU_FLAGS = -M smm=off -monitor stdio -d int -D arch/$(KERNEL_ARCH)/kernel$(KERNEL_ARCH).log
ISO = ktwo.iso

all: code_format setup_folders setup_boot setup_kernel setup_image setup_qemu

code_format:
	$(CF) -i arch/$(KERNEL_ARCH)/kernel/x86.c
	$(CF) -i arch/$(KERNEL_ARCH)/kernel/io.c
	$(CF) -i arch/$(KERNEL_ARCH)/kernel/gdt/gdt.c
	$(CF) -i arch/$(KERNEL_ARCH)/kernel/idt/idt.c
	$(CF) -i arch/$(KERNEL_ARCH)/include/*
	$(CF) -i lib/memory.c
	$(CF) -i drivers/*
	$(CF) -i include/**/*
	$(CF) -i lib/**/*

setup_folders:
	mkdir build

setup_boot:
	$(ASM) $(ASM_FLAGS) arch/$(KERNEL_ARCH)/boot/boot.asm -o build/boot.o

setup_kernel:
	$(CC)	$(C_FLGAS) -c arch/$(KERNEL_ARCH)/kernel/$(KERNEL_ARCH).c -o build/kernel.o
	$(CC)	$(C_FLGAS) -c drivers/vga.c -o build/vga.o
	$(CC)	$(C_FLGAS) -c arch/$(KERNEL_ARCH)/kernel/gdt/gdt.c -o build/gdt.o
	$(ASM)	$(ASM_FLAGS) arch/$(KERNEL_ARCH)/kernel/gdt/gdt.asm -o build/gdts.o
	$(CC)	$(C_FLGAS) -c lib/memory.c -o build/memory.o
	$(CC)	$(C_FLGAS) -c lib/std/stdio.c -o build/stdio.o
	$(CC)	$(C_FLGAS) -c arch/$(KERNEL_ARCH)/kernel/io.c -o build/io.o
	$(CC)	$(C_FLGAS) -c arch/$(KERNEL_ARCH)/kernel/idt/idt.c -o build/idt.o
	$(ASM)	$(ASM_FLAGS) arch/$(KERNEL_ARCH)/kernel/idt/idt.asm -o build/idts.o
	$(CC)	$(C_FLGAS) -c drivers/pit.c -o build/timer.o

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