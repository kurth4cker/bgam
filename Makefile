CC = cc

LDFLAGS = -lX11 -lXxf86vm

BIN = bgam-xlib
OBJ = main.o get_blue_gamma.o set_blue_gamma.o

all: $(BIN)
$(OBJ): gamma.h
$(BIN): $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f $(BIN) *.o

.SUFFIXES: .c .o
.c.o:
	$(CC) $(CFLAGS) -c $<
