BIN=elf-reader
SOURCE=main.c

CC=clang
LFLAGS:=-lelf -flto
CFLAGS:=-O3 -march=native

all:
	$(CC) $(SOURCE) -o $(BIN) $(CFLAGS) $(LFLAGS)

run:
	./$(BIN)

clean:
	rm $(BIN)
