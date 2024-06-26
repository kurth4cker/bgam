/* Copyright 2023,2024 kurth4cker
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

#include "gamma.h"
#include "help.h"

int
main(int argc, char **argv)
{
	const char *display_name = NULL;
	Display *dpy;
	float blue_gamma = -1;
	int screen = -1;
	int opt;

	while ((opt = getopt(argc, argv, "hvd:s:")) != -1) {
		switch (opt) {
		case 'd':
			display_name = optarg;
			break;
		case 's':
			screen = (int)strtol(optarg, NULL, 10);
			break;
		case 'v':
			version();
			/* FALLTHROUGH */
		case 'h':
			usage(EXIT_SUCCESS);
			/* FALLTHROUGH */
		}
	}

	argc -= optind;
	argv += optind;

	if (argc > 2)
		usage(EXIT_FAILURE);

	if (argc == 1) {
		blue_gamma = strtof(argv[0], NULL);
		if (blue_gamma <= 0.1 || blue_gamma > 10.0) {
			fprintf(stderr,
				"gamma value must between 0.1 and 10.0");
			return 1;
		}
	}

	dpy = XOpenDisplay(display_name);
	if (!dpy) {
		fprintf(stderr, "cannot open display '%s'", display_name);
		return 1;
	}

	if (screen < 0)
		screen = XDefaultScreen(dpy);

	if (blue_gamma < 0)
		printf("%.3f\n", get_blue_gamma(dpy, screen));
	else
		set_blue_gamma(dpy, screen, blue_gamma);

	XCloseDisplay(dpy);
}
