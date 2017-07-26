#ifndef hash_h
#define hash_h

#define HASHSIZE 2999

typedef struct function {
    char *nome;
    char *tipo;
    char *args[];
} Function;

typedef struct variable
{
    char *nome;
    char *tipo;
} Variable;

typedef struct symbol {
    union Type {
        Function f;
        Variable v;
    } SymbolType;
} Symbol;

typedef Symbol SymbolTable[HASHSIZE];

int hashtable (char word[], int size);
void insert(SymbolTable ht, SymbolType st);
int find(SymbolTable ht, SymbolType st);

#endif
