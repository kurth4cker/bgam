PACKAGE = bgam-xlib
VERSION = 0.0.0_git
DISTNAME = $(PACKAGE)-$(VERSION)

PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man
BINDIR = $(PREFIX)/bin

CC = cc

LDFLAGS = -lX11 -lXxf86vm

BIN = $(PACKAGE)
MAN1 = $(BIN).1
OBJ = main.o get_blue_gamma.o set_blue_gamma.o

SRC = $(OBJ:.o=.c)
INC = gamma.h
DISTFILES = COPYING README.md Makefile $(SRC) $(INC) $(MAN1)

all: $(BIN)
$(OBJ): gamma.h
$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f $(BIN) *.o $(DISTNAME).tar.gz

dist:
	mkdir $(DISTNAME)
	cp -f $(DISTFILES) $(DISTNAME)
	tar -c $(DISTNAME) | gzip -c > $(DISTNAME).tar.gz
	rm -rf $(DISTNAME)

install: $(BIN) $(MAN1)
	mkdir -p $(DESTDIR)$(BINDIR) $(DESTDIR)$(MANPREFIX)/man1
	cp -f $(BIN) $(DESTDIR)$(BINDIR)
	cp -f $(MAN1) $(DESTDIR)$(MANPREFIX)/man1

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(BIN)
	rm -f $(DESTDIR)$(MANPREFIX)/man1/$(MAN1)

.SUFFIXES: .c .o
.c.o:
	$(CC) -DVERSION=\"$(VERSION)\" $(CFLAGS) -c $<
