global _start

section .data
	align 16
quad1:
	dq	0xffffffff0fffffff
quad2:
	dq	0x0000abcd80000000
quad3:
	dq	0xaaaaaaaaffffff00
mydword:
	dd	0xcafebabe
myaddress:
	dq	0x00adbeefc0de00ce

MBALIGN     equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
FLAGS       equ  0                      ; this is the Multiboot 'flag' field
MAGIC       equ  0x1BADB002             ; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum of above, to prove we are multiboot
section .multiboot
align 4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM

section .text

_start:
main:
	movq		mm0, [quad1]
	movq		mm1, [quad2]
	movq		mm2, [quad3]
	movq		mm3, [quad2]

	packssdw	mm0, mm2
	packssdw	mm0, [quad1]
	packssdw	mm1, [quad3]
	packssdw	mm2, [quad1]
	packssdw	mm3, [quad1]


loop:
	hlt
	jmp     loop
