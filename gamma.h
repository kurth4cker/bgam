#ifndef GAMMA_H
#define GAMMA_H
#include <X11/Xlib.h>

float get_blue_gamma(Display *, int);
void set_blue_gamma(Display *, int, float);

#endif /* GAMMA_H */
