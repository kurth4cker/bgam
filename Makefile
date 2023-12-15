PACKAGE = bgam-xlib
VERSION = 0.0.0-git

PREFIX = /usr/local
BINDIR = $(PREFIX)/bin

CC = cc

LDFLAGS = -lX11 -lXxf86vm

BIN = $(PACKAGE)
OBJ = main.o get_blue_gamma.o set_blue_gamma.o

SRC = $(OBJ:.o=.c)
INC = gamma.h
DISTFILES = COPYING README.md Makefile $(SRC) $(INC)

all: $(BIN)
$(OBJ): gamma.h
$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f $(BIN) *.o

dist:
	mkdir $(PACKAGE)-$(VERSION)
	cp -f $(DISTFILES) $(PACKAGE)-$(VERSION)
	tar -cf $(PACKAGE)-$(VERSION).tar $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

install:
	mkdir -p $(DESTDIR)$(BINDIR)
	cp -f $(BIN) $(DESTDIR)$(BINDIR)

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(BIN)

.SUFFIXES: .c .o
.c.o:
	$(CC) -DVERSION=\"$(VERSION)\" $(CFLAGS) -c $<
