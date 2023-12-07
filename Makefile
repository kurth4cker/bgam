CC = cc

LDFLAGS = -lX11 -lXxf86vm

BIN = bgam-xlib
OBJ = main.o

all: $(BIN)
$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f $(BIN) *.o

.SUFFIXES: .c .o
.c.o:
	$(CC) $(CFLAGS) -c $<
