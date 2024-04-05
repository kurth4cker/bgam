.POSIX:
include config.mk

BGAM_CFLAGS = \
	-DVERSION='"'"$(VERSION)"'"' \
	$(CFLAGS)
BGAM_LDFLAGS = $(LDFLAGS) $(LIBS)

BIN = bgam
MAN1 = $(BIN).1
OBJ = \
	gamma.o \
	help.o \
	main.o

HEADERS = \
	gamma.h \
	help.h

all: $(BIN)

gamma.o: gamma.h
help.o: help.h
main.o: $(HEADERS)

$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(BGAM_LDFLAGS)

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
	$(CC) $(BGAM_CFLAGS) -c $<
