/*
Filename:      egghunter-poc-dec.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  30.01.2019
Note:          x64
Compiler:      gcc -ggdb -fno-stack-protector -z execstack egghunter-poc-dec.c -o egghunter-poc-dec
*/

#include<stdio.h>
#include<string.h>

#define egg  "\x90\x50\x90\x50"

#define shellcode "\x48\x31\xc0\x48\xff\xc0\x48\x31\xff\x48\xff\xc7\x48\x31\xf6\x56\x49\xb9\x6e\x64\x21\x0a\x20\x20\x20\x20\x41\x51\x49\xb9\x45\x67\x67\x73\x20\x66\x6f\x75\x41\x51\x48\x89\xe6\x48\x31\xd2\xb2\x10\x0f\x05\x48\x31\xc0\xb0\x3c\x48\x31\xff\x0f\x05"

#define dummy  "\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\
\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f\x20\
\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\
\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f\x40\
\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f\x50\
\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f\x60\
\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f\x70\
\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f\x80\
\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f\x90\
\x91\x92\x93\x94\x95\x96\x97\x98\x99\x9a\x9b\x9c\x9d\x9e\x9f\xa0\
\xa1\xa2\xa3\xa4\xa5\xa6\xa7\xa8\xa9\xaa\xab\xac\xad\xae\xaf\xb0\
\xb1\xb2\xb3\xb4\xb5\xb6\xb7\xb8\xb9\xba\xbb\xbc\xbd\xbe\xbf\xc0\
\xc1\xc2\xc3\xc4\xc5\xc6\xc7\xc8\xc9\xca\xcb\xcc\xcd\xce\xcf\xd0\
\xd1\xd2\xd3\xd4\xd5\xd6\xd7\xd8\xd9\xda\xdb\xdc\xdd\xde\xdf\xe0\
\xe1\xe2\xe3\xe4\xe5\xe6\xe7\xe8\xe9\xea\xeb\xec\xed\xee\xef\xf0\
\xf1\xf2\xf3\xf4\xf5\xf6\xf7\xf8\xf9\xfa\xfb\xfc\xfd\xfe\xff"

unsigned char code[] =
dummy
egg
egg
shellcode
dummy;

unsigned char egghunter[] =
"\x4d\x31\xc0\x48\x31\xf6\x48\x31\xff\x41\xb8"
egg
"\x48\x31\xc9\x48\xf7\xe1\xb8\xff\xff\xff\xff\x66\xba\xff\x7f\xff\xc2\x48\xf7\xe2\x66\x05\xff\x7f\x48\x89\xc2\x4d\x31\xc9\x66\x41\xb9\xff\x0f\x66\x41\xf7\xd1\x66\x44\x21\xca\x48\xff\xca\x48\x8d\x7a\xfc\x48\x31\xc0\xb0\x15\x0f\x05\x3c\xf2\x74\xea\x44\x39\x42\xfc\x75\xe8\x44\x39\x42\xf8\x75\xe2\x48\x83\xea\x08\xff\xe2";

void
main() {

    printf("Shellcode Length: %d\n", strlen(egghunter));
    int (*ret)() = (int(*)())egghunter;
    ret();

}
