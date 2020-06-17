CC      := $(CROSS_COMPILE)cc -xc
CXX     := $(CROSS_COMPILE)cc -xc++
AS      := $(CROSS_COMPILE)cc
AR      := $(CROSS_COMPILE)ar
LD      := $(CROSS_COMPILE)g++
NM      := $(CROSS_COMPILE)nm
STRIP   := $(CROSS_COMPILE)strip
RM      := rm -f
CP      := cp -f
OBJDUMP := $(CROSS_COMPILE)objdump
OBJCOPY := $(CROSS_COMPILE)objcopy

MKDIR 	:= mkdir -p
ECHO	:= /bin/echo

LFLAGS :=-lelf
CFLAGS :=-O2 -march=native

export CROSS_COMPILE

all:
	$(AS) main.c -o elf-reader $(CFLAGS) $(LFLAGS)

test:
	@$(MAKE) --no-print-directory all && ./elf-reader elf-reader

clean:
	rm -f elf-reader
