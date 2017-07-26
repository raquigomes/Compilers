CC = gcc
CFLAGS = -g
OUTFILE = ya!
LIBS = -lm


BINARY: ya

all: parser.c lexer.c
	$(CC) $(CFLAGS) parser.c lexer.c -o $(OUTFILE) $(LIBS)

parser.c: ya
	bison -y -d ya.y -o parser.c

lexer.c: ya.lex
	flex -o lexer.c ya.lex

clean: 
	rm -rf parser.c lexer.c parser.h
	rm -f *~
	rm -f *.o
	rm -f ya!
