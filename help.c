#include <stdio.h>
#include <stdlib.h>

#include "help.h"

void
usage(int code)
{
	fprintf(stderr, "usage: bgam-xlib [-d display] "
			"[-s screen_number] [blue_gamma]\n");

	exit(code);
}

void
version(void)
{
	fprintf(stderr, VERSION);
	fprintf(stderr, "\n");
	exit(EXIT_SUCCESS);
}
