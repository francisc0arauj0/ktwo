# ktwo kernel

This is a kernel I am developing as a hobby project. I have no plans to release it for general use; it’s simply an opportunity to fulfill my desire to create something of my own and explore the challenge of building a kernel from scratch.

<div align="center">
  <img src=".github/Demo.png" />
</div>

## TODO List

### Boot and basic setup
- [X] Boot
- [X] GDT (Global Descriptor Table)
- [ ] IDT (Interrupt Descriptor Table)

### Hardware Drivers
- [X] VGA
- [ ] Keyboard
- [ ] Mouse
- [ ] Disk
- [ ] Timer

### Filesystem
- [ ] Filesystem

## Build

### **Windows**

Install wsl2

```bash
wsl --install
```


Clone repository

```bash
git clone https://github.com/francisc0arauj0/ktwo/
```

Install tools

- nasm
- gcc
- grub-mkrescue
- grub-pc-bin
- qemu
- make

Build

```bash
make
```

### **Linux**

Clone repository

```bash
git clone https://github.com/francisc0arauj0/ktwo
```

Install tools

- nasm
- grub-mkrescue
- qemu

Build

```bash
make
```
