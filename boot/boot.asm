bits 32

section .text
  align 4
  dd 0x1BADB002
  dd 0x00000000
  dd -(0x1BADB002 + 0x00000000)

global start
extern kmain

start:
  cli
  mov esp, stack_space
  call kmain
  hlt

HatlKernel:
  cli 
  hlt
  jmp HatlKernel

section .bss
resb 8192       ; Reserves 8192 bytes for use (stack)
stack_space: