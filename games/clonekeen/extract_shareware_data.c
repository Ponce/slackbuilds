/* utility to extract the .SHR installer data files of early ID software
   shareware games
   
    Copyright (C) 2007 Hans de Goede  <j.w.r.degoede@hhs.nl>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or   
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of 
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the  
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <libdynamite.h>

struct cookie_s {
  char *in_buffer;
  int in_buffer_remaining;
  int in_buffer_index;
  int in_buffer_size;
  FILE* out_file;
};   

size_t reader(void* buffer, size_t size, void* cookie)
{
  struct cookie_s *c = cookie;
  if (size > c->in_buffer_remaining)
    size = c->in_buffer_remaining;
    
  memcpy (buffer, c->in_buffer + c->in_buffer_index, size);
  
  c->in_buffer_index += size;
  c->in_buffer_remaining -= size;
  
  return size;
}

size_t writer(void* buffer, size_t size, void* cookie)
{
  struct cookie_s *c = cookie;
  return fwrite(buffer, 1, size, c->out_file);
}

int main(int argc, char *argv[])
{
  struct cookie_s cookie;
  FILE *in_file;
  char filename[16];
  unsigned char buf[4];
  int i, compressed_size;
    
  if (argc != 2) {
    fprintf(stderr, "%s: Usage: %s <filename.CHR> %d\n", argv[0], argv[0], argc);
    return 1;
  }
  
  in_file = fopen(argv[1], "r");
  if (!in_file) {
    fprintf(stderr, "error opening: %s", argv[1]);
    perror(NULL);
    return 1;
  } 

  /* skip first 0x3A bytes header */
  if (fseek(in_file, 0x3A, SEEK_CUR)) {
    perror("error skipping initial file header");
    return 1;
  }
  
  cookie.in_buffer = malloc(65536);
  if (!cookie.in_buffer) {
    fprintf(stderr, "Error: out of memory\n");
    return 1;
  }
  cookie.in_buffer_size = 65536;
  
  while (1)
  {
    /* get the name of the file */
    if (fread(filename, 1, sizeof(filename), in_file) != sizeof(filename)) {
      if (feof(in_file)) {
        free(cookie.in_buffer);
        fclose(in_file);
        return 0; /* done */
      }
      perror("error getting output filename from file");
      return 1;
    }

    /* verify the filename and convert to lower case */
    for (i = 0 ; i < sizeof(filename); i++) {
      if (filename[i] == 0)
        break; /* done */
      if (!isprint(filename[i])) {
        fprintf(stderr, "error invalid output filename\n");
        return 1;
      }
      filename[i] = tolower(filename[i]);
    }
    if (i == sizeof(filename)) {
      fprintf(stderr, "error too long output filename\n");
      return 1;
    }
    
    /* seek to compressed size */
    if (fseek(in_file, 0x88 - sizeof(filename), SEEK_CUR)) {
      perror("error skipping file header before file size");
      return 1;
    }

    if (fread(buf, 1, 4, in_file) != 4) {
      perror("error reading file size");
      return 1;
    }
    compressed_size = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
    if (compressed_size > cookie.in_buffer_size) {
      cookie.in_buffer = realloc(cookie.in_buffer, compressed_size);
      if (!cookie.in_buffer) {
        fprintf(stderr, "Error: out of memory\n");
        return 1;
      }
      cookie.in_buffer_size = compressed_size;
    }

    /* seek to begin of compressed data */
    if (fseek(in_file, 0x1C, SEEK_CUR)) {
      perror("error skipping file header before file size");
      return 1;
    }
    
    /* read compressed data */
    if (fread(cookie.in_buffer, 1, compressed_size, in_file) !=
          compressed_size) {
      perror("error reading compressed data");
      return 1;
    }
    
    cookie.in_buffer_index = 0;
    cookie.in_buffer_remaining = compressed_size;
    
    cookie.out_file = fopen(filename, "w");
    if (!cookie.out_file) {
      fprintf(stderr, "Error creating: %s for writing", filename);
      perror(NULL);
      return 1;
    }

    printf("decompressing: %s, compressed size: %d\n", filename,
            compressed_size);
    
    if ((i = dynamite_explode(reader, writer, &cookie))) {
      fprintf(stderr, "Error: %d while decompressing\n", i);
      return i;
    }
    
    fclose(cookie.out_file);
  }
  
  /* never reached */
  return 0;
}
