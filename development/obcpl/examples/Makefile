# Makefile for obcpl/util

BC=obcpl
BFLAGS=-O

all: hello factorial

hello: hello.b
	$(BC) $(BFLAGS) hello.b

factorial: factorial.b
	$(BC) $(BFLAGS) factorial.b

install:

clean:
	rm -f hello factorial *.o
