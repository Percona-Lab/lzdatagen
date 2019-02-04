##
## lzdgen - LZ data generator example
##
## GCC Makefile
##

.SUFFIXES:

.PHONY: clean all

CFLAGS = -std=c99 -Wall -Wextra -march=native -Ofast -flto
CPPFLAGS = -DNDEBUG
LDLIBS = -lm

ifeq ($(OS),Windows_NT)
  LDFLAGS += -static -s
  ifeq ($(CC),cc)
    CC = gcc
  endif
endif

objs = lzdgen.o lzdatagen.o parg.o pcg_basic.o

target = lzdgen
target_so = liblzdgen.so

all: $(target) $(target_so)

%.o : %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

$(target): $(objs)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(target_so):	$(objs)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@ -fPIC -shared -lc

clean:
	$(RM) $(objs) $(target) $(target_so)

lzdgen.o: lzdatagen.h parg.h pcg_basic.h
lzdatagen.o: lzdatagen.h
parg.o: parg.h
pcg_basic.o: pcg_basic.h
