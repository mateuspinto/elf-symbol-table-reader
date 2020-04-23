CC      := $(CROSS_COMPILE)gcc -xc
CXX     := $(CROSS_COMPILE)gcc -xc++
AS      := $(CROSS_COMPILE)gcc
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
	$(AS) main.c -o elf-reader.elf $(CFLAGS) $(LFLAGS)

test:
	@$(MAKE) --no-print-directory all && ./elf-reader.elf elf-reader.elf

clean:
	rm -f elf-reader.elf