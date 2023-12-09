#include <X11/Xlib.h>
#include <X11/extensions/xf86vmode.h>

#include "gamma.h"

float
get_blue_gamma(Display *dpy, int screen)
{
	XF86VidModeGamma gamma = { 0 };

	XF86VidModeGetGamma(dpy, screen, &gamma);

	return gamma.blue;
}
