/*
	Quattro Wave ROM creator

	ctr 2016-09-22 - 2016-09-25
	
	2016-09-22: initial
	2016-09-25: now supports "mu-law" samples ("square-law" might be more accurate)
	2017-02-06: now able to fill gaps (created by sample alignment) with more samples
	2017-05-31: Updated mulaw algorithm.
	2017-08-02: reverse & bidi sample support
*/

#include "stdio.h"
#include "stdint.h"
#include "stdlib.h"
#include "string.h"
#include "fileio.h"
#include "math.h"
#include "ini.h"

typedef struct WaveRom WaveRom; 
typedef struct WaveFile WaveFile;

enum {
	NO_LOOP = 0,
	IS_REVERSE = 1,
	IS_LOOPING = 2,
	IS_BIDI    = 3
};

enum {
	WAVE_DEFINED = 1<<1,
	FREQ_DEFINED = 1<<2,
	TRANSPOSE_DEFINED = 1<<3,
	NOISE_DEFINED = 1<<4,
	MULAW_DEFINED = 1<<5,
	PHASELF_DEFINED = 1<<6,
	PHASELR_DEFINED = 1<<7,
	PHASER_DEFINED = 1<<8,
	NOFILTER_DEFINED = 1<<9,
	LOOPTYPE_DEFINED = 1<<10,
	OFFSET_DEFINED = 1<<11,
	FILENAME_DEFINED = 1<<12,
	COPY_F_DEFINED = 1<<13,
	COPY_W_DEFINED = 1<<14,
	NOT_READY = 1<<15
};


struct Gap {
	int start;
	int length;
};

struct WaveRom {
	uint8_t data[0x1000000];
	int counter;
	int maxsize;
	struct Gap gaps[2048];
	int gapcount;
};

struct WaveFile {
	char filename[256];
	int copy_f;
	int copy_w;
	
	long start;
	long end;
	long loop;
	long loopend;
	
	unsigned int defined;
	
	int offset;
	
	int looptype;

	int noise;
	int mulaw;
	int phasel_f;
	int phasel_r;
	int phaser;
	int nofilter;
	
	int freq;
	int transpose;
};

 	WaveFile defs[2048];
	WaveFile files[2048];
	WaveRom *rom;
	char* incdir;
	char default_incdir[] = ".";

#define FAIL(msg,...) {fprintf(stderr,"[FAIL] %s: " msg,w->filename , ##__VA_ARGS__); free(wavebuf); return -1;}
#define WARN(msg,...) {fprintf(stderr,"[WARN] %s: " msg,w->filename , ##__VA_ARGS__);}
#define DEBUG(msg,...) {fprintf(stderr,"[DEBUG] %s: " msg,w->filename , ##__VA_ARGS__);}
//#define DEBUG(msg,...) 
void addgap(WaveRom* r,int start,int length)
{
	if(r->gapcount<2048)
	{
		r->gaps[r->gapcount].start = start;
		r->gaps[r->gapcount].length = length;
		r->gapcount++;
	}
}

int readwav(WaveFile* w,WaveRom* r)
{
	uint8_t* wavebuf;
	uint32_t filesize;
	int wfilesize;
	long i,j;
	uint32_t chunk;
	
	int step = 0;
	uint16_t channels = 0;
	uint16_t stype = 0;
	uint16_t sbits = 0;
	uint32_t srate = 0;
	uint32_t slength = 0;
	
	uint32_t ltype = 0;
	uint32_t lstart = 0;
	uint32_t lend = 0;
	
	int transpose;
	
	uint8_t* dataptr = NULL;
	
	int chunksize;
	
	i=0;
	if(load_file(w->filename,&wavebuf,&filesize))
	{
		printf("failed to load file...\n");
		return -1;
	}
	
	printf("reading %s...\n",w->filename);
	
	if(filesize < 13)
		FAIL("Filename unexpectedly short\n")
	
	if(memcmp(&wavebuf[0],"RIFF",4))
		FAIL("Riff header not found\n");
	i+=4;

	wfilesize = *(uint32_t*)(wavebuf+i);
	i+=4;
	
	wfilesize+=i;
	if(filesize != wfilesize)
	{
		WARN("warning: reported file size and actual file size do not match\n"
			"reported = %d\nactual = %d\n",wfilesize,filesize
		);
	}
	
	if(memcmp(&wavebuf[i],"WAVE",4))
		FAIL("Not a WAVE format file\n");
	
	i+=4;
	
	while(i<wfilesize)
	{
		// chunks must be word aligned
		if(i&1)
			i++;
		
		chunk = *(uint32_t*)(wavebuf+i);
		chunksize = *(uint32_t*)(wavebuf+i+4);
		
		//DEBUG("Chunk id: %c%c%c%c (%08x)\nSize = %d\n",
		//	    wavebuf[i],wavebuf[i+1],wavebuf[i+2],wavebuf[i+3],chunk,chunksize);	
		//DEBUG("Left : %d\n", wfilesize - i);
		
		j=i+8;
		
		switch(chunk)
		{
		default: // ignore all other chunks
			break;
		case 0x20746d66: // 'fmt '
			if(chunksize < 16)
				FAIL("fmt chunk is too small\n");
			
			stype = *(uint16_t*)(wavebuf+i+0x08);
			channels = *(uint16_t*)(wavebuf+i+0x0a);
			sbits = *(uint16_t*)(wavebuf+i+0x16);
			if(sbits == 8)
				step = 1;
			else if(sbits == 16)
				step = 2;
			if(stype != 1 || channels != 1 || step == 0)
				FAIL("sample type must be 8- or 16-bit mono PCM\n");
			srate = *(uint32_t*)(wavebuf+i+0x0c);		
			break;
		case 0x61746164: // 'data'
			if(step==0)
				FAIL("data chunk may not precede fmt chunk\n");
			dataptr = wavebuf+j;
			slength = chunksize/step;
			break;
		case 0x6c706d73: // 'smpl'
			if(step==0)
				FAIL("smpl chunk may not precede fmt chunk\n");
			if(chunksize >= 0x10)
			{
				transpose = *(uint32_t*)(wavebuf+i+0x14);
				if(transpose)
					transpose -= 60;
			}
			if(chunksize >= 0x2c && *(uint32_t*)(wavebuf+i+0x24))
			{
				j=i+0x2c;
				ltype = *(uint32_t*)(wavebuf+j+4);
				lstart = *(uint32_t*)(wavebuf+j+8);
				lend = *(uint32_t*)(wavebuf+j+12);
			}
			break;
		}
		i+=chunksize+8;
	}
	
	if(lend && lend>slength)
		slength = lend;
	
	int counter = r->counter;
	int gapid = -1;
	int gapsize = 0x10000;
	
	for(i=0;i<r->gapcount;i++)
	{
		// look for the smallest gap that fits our sample
		if(r->gaps[i].length > (slength+2) && r->gaps[i].length < gapsize)
		{
			gapid = i;
			counter = r->gaps[i].start;
			gapsize = r->gaps[i].length;
		}
	}
	
	if(gapid != -1)
	{
		DEBUG("using gap at %06x (size=%d => %d)\n",counter,gapsize,gapsize-slength-2);
	}
	
	if(lend)
	{
		//printf("Got loop : %d, %d (type %d)\n",lstart,lend,ltype);
		if((lend-lstart) < 0x10000 && ((counter+lstart)&0xff0000) != ((counter+lend)&0xff0000))
		{
			gapsize = 0x10000 - ((counter+lstart)&0xffff);
			DEBUG("adding %d bytes to fit loop within bank\n",gapsize);
			addgap(r,counter,gapsize);
			counter += gapsize;
			
		}
		
		if(~w->defined & LOOPTYPE_DEFINED)
			w->looptype = (ltype == 1) ? IS_BIDI : IS_LOOPING;
	}
	
	//printf("Sample length = %d\n",slength);
	//printf("S=%06x E=%06x (LS=%06x LE=%06x)\n",counter,counter+slength,counter+lstart,counter+lend);
	
	if(~w->defined & WAVE_DEFINED)
	{
		w->start = counter;
		w->end = counter+slength;
		w->loop = counter+lstart;
		w->loopend = counter+lend;
		if(~w->defined & MULAW_DEFINED)
			w->mulaw = (step>1) ? 1 : 0;
		w->defined |= WAVE_DEFINED|MULAW_DEFINED;
	}
	if(~w->defined & FREQ_DEFINED)
		w->freq = srate;
	if(~w->defined & TRANSPOSE_DEFINED)
		w->transpose = transpose;

	if(counter+slength > r->maxsize)
	{
		FAIL("no more ROM space\n");
	}
	else
	{
		for(i=0;i<slength;i++)
		{
			if(step==2)
			{
				j = *(int16_t*)(dataptr+(i*step));
				
				// mulaw (12-bit) conversion
				if(w->mulaw)
				{
					
					j+=0x10;
					int k;
					k = abs(j);
					int m=0;
					if(k>0x7a00)
						m=0x7f;
					else if(k>0x4400)
						m=0x64 + ((k-0x4400)/0x200);
					else if(k>0x1000)
						m=0x30 + ((k-0x1000)/0x100);
					else if(k>0x400)
						m=0x18 + ((k-0x400)/0x80);
					else if(k>0x200)
						m=0x10 + ((k-0x200)/0x40);
					else
						m=k/0x20;

					r->data[counter+i] = m | ((j<0) ? 0x80 : 0); 
				}
				// Linear 8 bit PCM quantization
				else
				{
					// no dither for now...
					r->data[counter+i] = (int8_t)(j>>8);
				}
			}
			else
			{
				j = dataptr[i]^0x80;
				r->data[counter+i] = dataptr[i*step]^0x80;	
			}
		}
		if(gapid != -1)
		{
			r->gaps[gapid].length -= slength-2;
			r->gaps[gapid].start += slength+2;
		}
		else
		{
			r->counter = counter+slength+2;	
		}
	}
	
	free(wavebuf);
	return 0;
}

void copy_def(WaveFile *dest, WaveFile *src)
{
	
	if(~dest->defined & WAVE_DEFINED)
	{
		dest->start = src->start;
		dest->end = src->end;
		dest->loop = src->loop;
		dest->loopend = src->loopend;
	}
	if(~dest->defined & FREQ_DEFINED)
		dest->freq = src->freq;
	if(~dest->defined & TRANSPOSE_DEFINED)
		dest->transpose = src->transpose;
	if(~dest->defined & NOISE_DEFINED)
		dest->noise = src->noise;
	if(~dest->defined & MULAW_DEFINED)
		dest->mulaw = src->mulaw;
	if(~dest->defined & PHASELF_DEFINED)
		dest->phasel_f = src->phasel_f;
	if(~dest->defined & PHASELR_DEFINED)
		dest->phasel_r = src->phasel_r;
	if(~dest->defined & PHASER_DEFINED)
		dest->phaser = src->phaser;
	if(~dest->defined & NOFILTER_DEFINED)
		dest->nofilter = src->nofilter;
	if(~dest->defined & LOOPTYPE_DEFINED)
		dest->looptype = src->looptype;
	if(~dest->defined & OFFSET_DEFINED)
		dest->offset = src->offset;
	
	dest->defined |= src->defined;
}

#define BANK(addr) (((addr)>>16)&0xffff)
#define WORD(addr) ((addr)&0xffff)
void write_def(WaveFile *w, FILE *f)
{
	//if(w->freq >= 88200)
	//	printf("[WARN] C-5 sample freq may be too high...\n",i);
	
	double p= (65536.0/88200.0) * w->freq;
	p = log(p/128)/log(pow(2,1.0/12));
	p = (w->transpose+p-64)*256;
	
	fprintf(f,"\t.word\t$%04x ; freq = %d Hz\n",(uint16_t)(p+0.5),w->freq);

	uint16_t flags = 0|(w->nofilter<<2)|(w->mulaw<<3)|(w->noise<<4)|
		(w->phaser<<7)|(w->phasel_f<<8)|(w->phasel_r<<9);

	int start = w->start+w->offset;
	int end = (w->looptype >= IS_LOOPING) ? w->loopend : w->end;
	int loop = (w->looptype >= IS_LOOPING) ? w->loop : 0;
	
	if(start>end)
		end = start;
	if(w->looptype >= IS_LOOPING && start>loop)
		loop = start;

	int length = end-start;
	
	if(w->looptype&1 && length > 0xffff)
	{
		WARN("bidirectional or reverse loops cannot be longer than 65535 bytes\n");
		w->looptype = 0;
	}
	
	int offset = 0;
	int loop_type = 0;

	int le, lo;
	
	if(w->looptype == IS_LOOPING && loop-start<0x2000)
	{
		loop_type = 4;
	}
	else if(w->looptype == IS_LOOPING)
	{
		length=loop-start;
		++loop_type;
	}
	
	while(end-start-offset > 0xffff)
	{
		le=(length < 0x11fff) ? 0xdeff : 0xfeff;
		if(le > length)
		{
			le = length;
			if(loop_type == 1)
				++loop_type;
		}
		
		DEBUG("L> St=%06x, Lnk=%06x\n",start+offset,start+offset+le);
		
		fprintf(f,"\t.word\t$%04x, $%04x, $%04x, $%04x\n",
			BANK(start+offset),flags|0x22,WORD(start+offset),WORD(start+offset+le));
		
		flags |= 0x8000;
		
		offset += le+1;
		
		if(loop_type == 0 || loop_type > 1)
			length = end-start-offset;
		
		if(loop_type == 4 || (loop_type == 2 && end-start-offset > 0xffff))
		{
			lo=offset;
			fprintf(f,"@loop:\n");
			++loop_type;
		}
	}	

	if(loop_type == 5) // create another link entry and loop back
	{
		DEBUG("L> St=%06x, End=%06x, Loop=%06x > %06x\n",start+offset,end,loop,lo);
		
		fprintf(f,"\t.word\t$%04x, $%04x, $%04x, $%04x\n",
			BANK(start+offset),flags|0x22,WORD(start+offset),WORD(end));
			
		fprintf(f,"\t.word\t$%04x, $%04x, $%04x, $%04x\n",
			BANK(loop),flags|0x22,WORD(loop),WORD(start+lo-1));
			
		fprintf(f,"\t.word\t$%04x\n\t.addr\t@loop\n",0x8000|BANK(start+lo));
	}
	else if(loop_type == 3) // jump back to loop link position
	{
		DEBUG("L> St=%06x, End=%06x, Loop=%06x\n",start+offset,end,loop);
		
		fprintf(f,"\t.word\t$%04x, $%04x, $%04x, $%04x\n",
			BANK(start+offset),flags|0x22,WORD(start+offset),WORD(end));
			
		fprintf(f,"\t.word\t$%04x\n\t.addr\t@loop\n",0x8000|BANK(loop));
	}
	else if(w->looptype == IS_REVERSE) // reversed sample
	{
		DEBUG("R> St=%06x, End=%06x, Loop=%06x\n",start+offset,end,loop);
		
		fprintf(f,"\t.word\t$%04x, $%04x, $%04x, $%04x\n",
			BANK(end),flags|w->looptype,WORD(end),WORD(start+offset));
	}
	else // loop within the same bank / no link
	{
		DEBUG("   St=%06x, End=%06x, Loop=%06x\n",start+offset,end,loop);
		
		fprintf(f,"\t.word\t$%04x, $%04x, $%04x, $%04x",
			BANK(start+offset),flags|w->looptype,WORD(start+offset),WORD(end));
		if(w->looptype & 2)
			fprintf(f,", $%04x",WORD(loop));
		fprintf(f,"\n");
	}
	
}

#define OPTION_PARSER(name,string,defineflag) if(!strcmp(key,string)) { f->name = val; f->defined |= defineflag; return; }
#define OPTION_PARSER2(name,setval,string,defineflag) if(!strcmp(key,string)) { f->name = val ? setval : 0; f->defined |= defineflag; return; }
void parse_option(WaveFile* f, char* key, char* value)
{
	if(!strcmp(key,"filename"))
	{
		sprintf(f->filename,"%s/%s",incdir,value);
		f->defined |= FILENAME_DEFINED|NOT_READY;
		return;
	}

	long val = strtol(value,NULL,0);
	
	OPTION_PARSER(copy_f,"file",COPY_F_DEFINED|NOT_READY)
	OPTION_PARSER(copy_w,"wave",COPY_W_DEFINED|NOT_READY)
	OPTION_PARSER(freq,"freq",FREQ_DEFINED)
	OPTION_PARSER(transpose,"transpose",TRANSPOSE_DEFINED)
	OPTION_PARSER(noise,"noise",NOISE_DEFINED)
	OPTION_PARSER(mulaw,"mulaw",MULAW_DEFINED)
	OPTION_PARSER(nofilter,"nofilter",NOFILTER_DEFINED)
	OPTION_PARSER(phasel_f,"phasel_f",PHASELR_DEFINED)
	OPTION_PARSER(phasel_r,"phasel_r",PHASELF_DEFINED)
	OPTION_PARSER(phaser,"phaser",PHASER_DEFINED)
	OPTION_PARSER(offset,"offset",OFFSET_DEFINED)
	OPTION_PARSER2(looptype,IS_REVERSE,"reverse",LOOPTYPE_DEFINED)
	OPTION_PARSER2(looptype,IS_BIDI,"bidi",LOOPTYPE_DEFINED)
}

int main(int argc, char *argv[])
{
	char *infile = NULL, *outfile = NULL, *romfile = NULL;
	incdir = default_incdir;
	
	int banksel = 0;
	
	char msgstring[2048];
	msgstring[0] = 0;
	
	rom = (WaveRom*)malloc(sizeof(WaveRom));
	
	WaveRom *r = rom;
	r->maxsize =0x1000000;
	r->counter  =0;
	r->gapcount =0;
	
	memset(&defs,0,sizeof(defs));
	memset(&files,0,sizeof(files));
	
	int id, max_id_f=-1, max_id_w=-1;
	
	if(!r)
		return -1;

	int i, standard_args=0;

	for(i=1;i<argc;i++)
	{
		if((!strcmp(argv[i],"-d") || !strcmp(argv[i],"--include-dir")) && i<argc)
		{
			i++;
			incdir = argv[i];
		}
		else if((!strcmp(argv[i],"-r") || !strcmp(argv[i],"--rom-out")) && i<argc)
		{
			i++;
			romfile = argv[i];
		}
		else if((!strcmp(argv[i],"-s") || !strcmp(argv[i],"--asm-out")) && i<argc)
		{
			i++;
			outfile = argv[i];
		}
		else if((!strcmp(argv[i],"-i") || !strcmp(argv[i],"--in")) && i<argc)
		{
			i++;
			infile = argv[i];
		}
		else
		{
			if(standard_args == 0)
				infile = argv[i];
			else if(standard_args == 1)
				outfile = argv[i];
			else if(standard_args == 2)
				romfile = argv[i];
			else
				break;
			standard_args++;
		}
	}
	
	if(!infile || !outfile || !romfile)
	{
		printf("usage: %s [options] myfile.ini out.s out.bin\n",argv[0]);
		printf("options:\n\t-i \"./blah/\" / --includefile \"./blah/\"\n"); 
		exit(EXIT_FAILURE);
	}
	
	printf("incdir = %s\ninfile = %s\noutfile = %s\nromfile = %s\n",incdir,infile,outfile,romfile);
	
    inifile_t ini;
    if(!ini_open(infile,&ini))
    {
        while(!ini_readnext(&ini))
        {
			if(!strcmp(ini.section,"config"))
			{
				if(!strcmp(ini.key,"romsize"))
					r->maxsize=(int)strtol(ini.value,NULL,0);
				else if(!strcmp(ini.key,"bank"))
					banksel=(int)strtol(ini.value,NULL,0);
				
				if(r->maxsize > 0x1000000)
					r->maxsize = 0x1000000;
			}
			if(sscanf(ini.section,"wave.%i",&id)==1 && id < 2048)
			{
				if(id>max_id_w)
					max_id_w=id;
				parse_option(&defs[id],ini.key,ini.value);	
			}
			else if(sscanf(ini.section,"file.%i",&id)==1 && id < 2048)
			{
				if(id>max_id_f)
					max_id_f=id;
				parse_option(&files[id],ini.key,ini.value);	
			}
		}
	}

	if(ini.status)
	{
		if(ini.status == INI_FILE_LOAD_ERROR)
			strcat(msgstring,my_strerror(infile));
		else
			strcat(msgstring,ini_error[ini.status]);

		printf("Could not read ini: %s\n",msgstring);
		ini_close(&ini);
		exit(EXIT_FAILURE);
	}
	
	ini_close(&ini);
	
	printf("max ID f=%d, w=%d\n",max_id_f,max_id_w);
	int notready_cnt = 1, pass=0;
	while(notready_cnt)
	{
		printf("Pass %d...\n",++pass);
		
		notready_cnt = 0;
		for(id=0;id<=max_id_f;id++)
		{
			i=0;
			if(files[id].defined & FILENAME_DEFINED)
			{
				readwav(&files[id],r);
				files[id].defined &= ~FILENAME_DEFINED;
			}
			if(!i)
				files[id].defined &= ~NOT_READY;
			else
				notready_cnt++;
		}
		for(id=0;id<=max_id_w;id++)
		{
			i=0;
			if(defs[id].defined & FILENAME_DEFINED)
			{
				printf("wave %d reading file...\n",id);
				readwav(&defs[id],r);
				defs[id].defined &= ~FILENAME_DEFINED;
			}
			if(defs[id].defined & COPY_F_DEFINED)
			{
				if(files[defs[id].copy_f & 0x7ff].defined & NOT_READY)
					++i;
				else
				{
					copy_def(&defs[id],&files[defs[id].copy_f & 0x7ff]);
					defs[id].defined &= ~COPY_F_DEFINED;	
				}
			}
			if(defs[id].defined & COPY_W_DEFINED)
			{
				if(defs[defs[id].copy_w & 0x7ff].defined & NOT_READY)
					++i;
				else
				{
					copy_def(&defs[id],&defs[defs[id].copy_w & 0x7ff]);
					defs[id].defined &= ~COPY_W_DEFINED;	
				}
			}
			if(!i)
				defs[id].defined &= ~NOT_READY;
			else
				notready_cnt++;
		}
	}
	
	FILE* destfile;
	
    destfile = fopen(outfile,"w");
    if(!destfile)
    {
        printf("Could not write to %s\n",outfile);
        exit(EXIT_FAILURE);
    }
	
	fprintf(destfile,"\t.export tab_wave\n\t.segment \"BANK%d\"\ntab_wave:",banksel);
	for(id=0;id<=max_id_w;id++)
	{
		fprintf(destfile,"%swave_%d",((id%8)==0) ? "\n\t.addr\t" : ", ", id);
	}
	
	for(id=0;id<=max_id_w;id++)
	{
		fprintf(destfile,"\nwave_%d:\n",id);
		write_def(&defs[id],destfile);
	}
	fclose(destfile);

    destfile = fopen(romfile,"wb");
    if(!destfile)
    {
        printf("Could not write to %s\n",romfile);
        exit(EXIT_FAILURE);
    }
	
	int gaptotal = 0,largest = 0;
	for(i=0;i<r->gapcount;i++)
	{
		if(r->gaps[i].length > 0)
		{
			gaptotal+=r->gaps[i].length;
			if(r->gaps[i].length > largest)
				largest = r->gaps[i].length;
		}
	}
	
	printf("Wave ROM: size %d bytes, left %d bytes\n",r->maxsize,r->maxsize-r->counter);
	printf("Gaps: %d, total %d bytes, largest %d bytes\n",r->gapcount,gaptotal,largest);
	
	for(i=0;i<r->maxsize;i++)
	{
		fputc(r->data[i],destfile);
	}
	fclose(destfile);
	return 0;

}