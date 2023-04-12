/* interleave.c - B. Watson, April 2023, WTFPL licensed.

   Given two files of the same size, creates a 3rd file whose contents are:

   file 1, byte 1
   file 2, byte 1
   file 1, byte 2
   file 2, byte 2
   file 1, byte 3
   file 2, byte 3
   ...etc.

   If file1 contains "foo" and file2 contains "bar", the output will
   be "fboaor". The output is always twice the size of one of the
   input files (or, the same size as both input files combined).

   Output file is silently overwritten if it already exists.

   Exit status is 0 for success, non-zero for failure, with a hopefully
   useful error message.

   Compile me with:
     gcc -Wall -O2 -o interleave interleave.c

   This could be done more efficiently and without an artificial file
   size limit, but the current implementation reads everything into a
   statically sized buffer for simpliticy.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX_SIZE (1024 * 1024)

unsigned char blob1[MAX_SIZE + 1], blob2[MAX_SIZE + 1], output[MAX_SIZE * 2 + 1];

void die(const char *msg) {
	if(msg)
		fprintf(stderr, "interleave: %s\n", msg);
	else
		perror("interleave");
	exit(1);
}

int read_file(const char *fname, unsigned char *dest) {
	int bytes;
	FILE *f = fopen(fname, "rb");

	if(!f) die(NULL);
	if( (bytes = fread(dest, 1, MAX_SIZE + 1, f)) < 1 ) die(NULL);
	fclose(f);

	/* fprintf(stderr, "read %d bytes from %s\n", bytes, fname); */

	return bytes;
}

void write_output(const char *fname, int bytes) {
	int i;
	unsigned char *p = output;
	FILE *f = fopen(fname, "wb");

	if(!f) die(NULL);

	for(i = 0; i < bytes; i++) {
		*p++ = blob1[i];
		*p++ = blob2[i];
	}

	if( (fwrite(output, 1, bytes * 2, f)) < (bytes * 2) ) die(NULL);

	fclose(f);
}

int main(int argc, char **argv) {
	int size1, size2;

	if(argc != 4)
		die("usage:\n\tinterleave <input1> <input2> <output>");

	size1 = read_file(argv[1], blob1);
	size2 = read_file(argv[2], blob2);

	if(size1 > MAX_SIZE)
		die("input file too big (max 1MB each)");
	if(size1 != size2)
		die("input files are not the same size");

	write_output(argv[3], size1);

	return 0;
}
