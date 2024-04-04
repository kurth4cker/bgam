# bgam
Simple command line tool for blue gamma handling. [WIP]

## Dependencies
**bgam** currently depends on some libraries. Install them before building or
using **bgam**:

* libx11 (also called as xlib)
* libxxf86vm

## Building
Just run `make`.

	make
	make install # root may require

For customizing build, you can setup some standard variables.

	# build with optimization
	make CFLAGS="-O2"
	# build with clang
	make CC=clang
	# install to $HOME
	make install PREFIX=$HOME
	# or $HOME/.local
	make install PREFIX=$HOME/.local

See Makefile for all variables

## Usage
See bgam(1) manpage.

## Copying
Licensed under GPLv3+. See file COPYING for details.
