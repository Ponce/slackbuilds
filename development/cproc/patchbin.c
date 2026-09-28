#include <stdlib.h>
#include <stdio.h>

/* 3 args: path to binary, offset (decimal), string to write */
int main(int argc, char **argv) {
	FILE *f;
	int offset;

	if(argc < 4) exit(1);
	if( ! (f = fopen(argv[1], "r+b")) ) exit(2);
	if( ! (offset = atoi(argv[2])) ) exit(3);
	if(fseek(f, offset, SEEK_SET) < 0) exit(4);
   if(fputs(argv[3], f) < 0) exit(5);
	fputc(0, f);
	fclose(f);
	exit(0);
}
