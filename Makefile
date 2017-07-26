CC = gcc
PARSER = bison
LEXER = flex
CFLAGS = -g
OUTFILE = ya
LIBS = -lm


BINARY: ya

all: parser lexer
	$(CC) $(CFLAGS) *.c -o $(OUTFILE) $(LIBS)

parser: ya.y
	$(PARSER) -y -d ya.y -o parser.c

lexer: ya.lex
	$(LEXER) -o lexer.c ya.lex

clean: 
	rm -rf parser.c lexer.c parser.h
	rm -f *~
	rm -f *.o
	rm -f ya
