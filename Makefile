VERSION = 0.0.0dev

PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man
BINDIR = $(PREFIX)/bin

CC = cc

LDFLAGS = -lX11 -lXxf86vm

BIN = bgam
MAN1 = $(BIN).1
OBJ = die.o gamma.o help.o main.o

HEADERS = die.h gamma.h help.h

all: $(BIN)

die.o: die.h
gamma.o: gamma.h
help.o: help.h
main.o: $(HEADERS)

$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f $(BIN) *.o

install: $(BIN) $(MAN1)
	mkdir -p $(DESTDIR)$(BINDIR)
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f $(BIN) $(DESTDIR)$(BINDIR)
	cp -f $(MAN1) $(DESTDIR)$(MANPREFIX)/man1

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/$(BIN)
	rm -f $(DESTDIR)$(MANPREFIX)/man1/$(MAN1)

.SUFFIXES: .c .o
.c.o:
	$(CC) -DVERSION=\"$(VERSION)\" $(CFLAGS) -c $<
