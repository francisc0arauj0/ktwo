global idt_flush
idt_flush:
  mov eax, [esp+4]
  lidt [eax]
  sti
  ret

%macro ISR_NO_ERROR_CODE 1
  global isr%1
  isr%1:
    cli
    push long 0
    push long %1
    jmp isr_common_stub
%endmacro

%macro ISR_ERROR_CODE 1
  global isr%1
  isr%1:
    cli
    push long %1
    jmp isr_common_stub
%endmacro

%macro IRQ 2
  global irq%1
  irq%1:
    cli
    push long 0
    push long %2
    jmp irq_common_stub
%endmacro

ISR_NO_ERROR_CODE 0
ISR_NO_ERROR_CODE 1
ISR_NO_ERROR_CODE 2
ISR_NO_ERROR_CODE 3
ISR_NO_ERROR_CODE 4
ISR_NO_ERROR_CODE 5
ISR_NO_ERROR_CODE 6
ISR_NO_ERROR_CODE 7
ISR_ERROR_CODE 8
ISR_NO_ERROR_CODE 9
ISR_ERROR_CODE 10
ISR_ERROR_CODE 11
ISR_ERROR_CODE 12
ISR_ERROR_CODE 13
ISR_ERROR_CODE 14
ISR_NO_ERROR_CODE 15
ISR_NO_ERROR_CODE 16
ISR_NO_ERROR_CODE 17
ISR_NO_ERROR_CODE 18
ISR_NO_ERROR_CODE 19
ISR_NO_ERROR_CODE 20
ISR_NO_ERROR_CODE 21
ISR_NO_ERROR_CODE 22
ISR_NO_ERROR_CODE 23
ISR_NO_ERROR_CODE 24
ISR_NO_ERROR_CODE 25
ISR_NO_ERROR_CODE 26
ISR_NO_ERROR_CODE 27
ISR_NO_ERROR_CODE 28
ISR_NO_ERROR_CODE 29
ISR_NO_ERROR_CODE 30
ISR_NO_ERROR_CODE 31
; ISR_NO_ERROR_CODE 128 - syscalls
; ISR_NO_ERROR_CODE 177 - syscalls


IRQ  0, 32
IRQ  1, 33
IRQ  2, 34
IRQ  3, 35
IRQ  4, 36
IRQ  5, 37
IRQ  6, 38
IRQ  7, 39
IRQ  8, 40
IRQ  9, 41
IRQ 10, 42
IRQ 11, 43
IRQ 12, 44
IRQ 13, 45
IRQ 14, 46
IRQ 15, 47


extern isr_handler
isr_common_stub:
  pusha
  mov eax, ds
  push eax
  mov eax, cr2
  push eax

  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  push esp
  call isr_handler
  
  add esp, 8
  pop ebx
  mov ds, bx
  mov es, bx
  mov fs, bx
  mov gs, bx 

  popa
  add esp, 8
  sti
  iret

extern irq_handler
irq_common_stub:
  pusha
  mov eax, ds
  push eax
  mov eax, cr2
  push eax

  mov ax, 0x10
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  push esp
  call irq_handler
  
  add esp, 8
  pop ebx
  mov ds, bx
  mov es, bx
  mov fs, bx
  mov gs, bx 

  popa
  add esp, 8
  sti
  iret