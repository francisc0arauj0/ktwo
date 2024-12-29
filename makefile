all:
	mkdir build
	gcc -m64 -fno-stack-protector -fno-builtin -c kernel/main.c -o build/kernel.o
	nasm -f elf64 boot/boot.asm -o build/boot.o
	ld -m elf_x86_64 -T linker.ld -o ktwokernel build/boot.o build/kernel.o -z noexecstack
	mv ktwokernel ktwo/boot/kernel
	grub-mkrescue -o ktwo.iso ktwo/
	rm -r build
	qemu-system-x86_64 ktwo.iso


# file ktwo.ios
# xorriso -indev ktwo.iso -find
# sudo apt install grub-pc-bin