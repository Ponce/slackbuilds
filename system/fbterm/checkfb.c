/*
# qtopia core testing framebuffer (1)
# Originally written by Trolltech (2)(3)
#
# (1) http://cep.xray.aps.anl.gov/software/qt4-x11-4.2.2/qtopiacore-testingframebuffer.html
# (2) http://cep.xray.aps.anl.gov/software/qt4-x11-4.2.2/opensourceedition.html
# (3) http://doc.qt.digia.com/4.2/gpl.html
#
# Modified by Sébastien Ballet <slacker6896@gmail.com>
*/

#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>
#include <sys/ioctl.h>

int main(int argc, char *argv[])
{
	int fbfd = 0;
	struct fb_var_screeninfo vinfo;
	struct fb_fix_screeninfo finfo;
	long int screensize = 0;
	char *fbp = 0;
	
	char* fbName="/dev/fb0";

	if ( argc > 2) {
		printf("usage: checkfb [framebuffer device] \n");
		exit(1);
	}

	if ( argc == 2) {
		fbName=argv[1];
	} 

	fbfd = open(fbName, O_RDWR);

	if (fbfd == -1) {
		perror("Error: cannot open framebuffer device");
		exit(1);
	}

	printf("The framebuffer device (%s) was opened successfully.\n",fbName);

		// Get fixed screen information
	if (ioctl(fbfd, FBIOGET_FSCREENINFO, &finfo) == -1) {
		perror("Error reading fixed information");
		exit(2);
	}

		// Get variable screen information
	if (ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo) == -1) {
		perror("Error reading variable information");
		exit(3);
	}

	printf("%dx%d, %dbpp\n", vinfo.xres, vinfo.yres, vinfo.bits_per_pixel);

		// Figure out the size of the screen in bytes
	screensize = vinfo.xres * vinfo.yres * vinfo.bits_per_pixel / 8;

	// Map the device to memory
	fbp = (char *)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED,fbfd, 0);

	if ( fbp == MAP_FAILED ) {
		perror("Error: failed to map framebuffer device to memory");
		exit(4);
	}
	printf("The framebuffer device was mapped to memory successfully.\n");

	munmap(fbp, screensize);
	close(fbfd);
	return 0;
}
