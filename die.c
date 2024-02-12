#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "die.h"

void
die(const char *fmt, ...)
{
	va_list ap;

	va_start(ap, fmt);
	vfprintf(stderr, fmt, ap);
	va_end(ap);

	if (fmt && fmt[strlen(fmt) - 1] == ':') {
		fprintf(stderr, " ");
		fprintf(stderr, "%s", strerror(errno));
	}
	fputc('\n', stderr);

	exit(EXIT_FAILURE);
}
