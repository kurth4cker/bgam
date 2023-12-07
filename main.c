/* bgam-xlib -- get and set blue gamma for X11
 * Copyright 2023 Kurth4cker
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <X11/Xlib.h>
#include <X11/extensions/xf86vmode.h>

static void usage(void);

int
main(int argc, char **argv)
{
	const char *display_name = NULL;
	Display *dpy;
	XF86VidModeGamma gamma = { 0 };
	int screen = -1;
	int opt;

	while ((opt = getopt(argc, argv, "d:s:")) != -1) {
		switch (opt) {
		case 'd':
			display_name = optarg;
			break;
		case 's':
			screen = (int)strtol(optarg, NULL, 10);
			break;
		}
	}

	argc -= optind;
	argv += optind;

	if (argc > 2) {
		usage();
		return 1;
	}

	dpy = XOpenDisplay(display_name);
	if (!dpy) {
		fprintf(stderr, "cannot open display '%s'\n", display_name);
		return 1;
	}

	if (screen < 0) {
		screen = XDefaultScreen(dpy);
	}

	XF86VidModeGetGamma(dpy, screen, &gamma);
	printf("%.3f\n", gamma.blue);

	XCloseDisplay(dpy);
}

static void
usage(void)
{
	fprintf(stderr,
"usage: bgam-xlib [-d display] [-s screen_number]\n");
}
