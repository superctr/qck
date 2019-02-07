#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

int main(int argc, char* argv [])
{

	unsigned long i;

	printf("C352 Mulaw->LPCM conversion tool\n");
	printf("Output format: signed 16 bit PCM little endian\n");
		
	if(argc<3)
	{
		printf("Usage: <file> <destination file> \n");
		exit(EXIT_FAILURE);
	}

	char* file1 = argv[1];
	char* file2 = argv[2];

	int16_t mulaw_tab[256];

	int j=0;

	for(i=0;i<128;i++)
	{
		mulaw_tab[i] = j<<5;
		if(i < 16)
			j += 1;
		else if(i < 24)
			j += 2;
		else if(i < 48)
			j += 4;
		else if(i < 100)
			j += 8;
		else
			j += 16;
	}
	for(i=128;i<256;i++)
		mulaw_tab[i] = (~mulaw_tab[i-128])&0xffe0;
	int res;

	FILE* sourcefile;
	/* Load sample file */
	sourcefile = fopen(file1,"rb");
	if(!sourcefile)
	{
		printf("Could not open %s\n",file1);
		exit(EXIT_FAILURE);
	}
	fseek(sourcefile,0,SEEK_END);
	unsigned long sourcefile_size = ftell(sourcefile);
	rewind(sourcefile);
	uint8_t* source = (uint8_t*)malloc(sourcefile_size);
	uint16_t* dest = (uint16_t*)malloc(sourcefile_size*2);
	res = fread(source,1,sourcefile_size,sourcefile);
	if(res != sourcefile_size)
	{
		printf("Reading error\n");
		exit(EXIT_FAILURE);
	}
	fclose(sourcefile);

	int length = sourcefile_size;

	for(i=0;i<length;i++)
	{
		dest[i] = mulaw_tab[source[i]];
	}
	printf("memory ok %lu\n",length);

	FILE *destfile;
	destfile = fopen(file2,"wb");
	if(!destfile)
	{
		printf("Could not open %s\n",file2);
		exit(EXIT_FAILURE);
	}
	for(i=0;i<sourcefile_size*2;i++)
	{
		putc(*((uint8_t*)dest+i),destfile);
	}
	fclose(destfile);
	printf("write ok %lu\n",length);

	free(source);
}
