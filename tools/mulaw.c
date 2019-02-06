#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

int main(int argc, char* argv [])
{

    unsigned long i;

    if(argc<3)
    {
        printf("Usage: <file> <destination file> \n");
        exit(EXIT_FAILURE);
    }

    char* file1 = argv[1];
    char* file2 = argv[2];
/*
    int16_t mulaw_tab[256];

    double x_max = 32752.0;
    double y_max = 127.0;
    double u = 10.0;

    for(i=0;i<256;i++)
    {
        double y = (double) (i & 0x7f);
        double x = (exp (y / y_max * log (1.0 + u)) - 1.0) * x_max / u;
        if (i & 0x80)
            x = -x;
        mulaw_tab[i] = (int16_t)x;
	}
*/
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
	int8_t s, s2;

    for(i=0;i<length;i++)
    {
		s = source[i];

		s2 = s&0x7f;
		dest[i] = (s2*s2)<<1;
		if(s&0x80)
			dest[i] = -dest[i];
        //dest[i] = mulaw_tab[source[i]];
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
