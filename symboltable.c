#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symboltable.h"



int hashtable(char word[], int size)
{
  unsigned h = 0;
  int i = 0;

  while (word[i] != '\0')
    {
      h += word[i];
      h += (h << 10);
      h ^= (h >> 6);
      i++;
    }

  h += (h << 3);
  h ^= (h >> 11);
  h += (h << 15);

  return h % size;
}



void insert(SymbolTable ht, SymbolType st)
{
  int i = hash(st.word, HASHSIZE);

  if (ht[i].word[0] == 0)
    strcpy(ht[i].word, st.word);

  while (ht[i].word[0] != 0)
  {
    i++;
    i %= HASHSIZE;
  }

  strcpy(st[i].word, st.word);
}



int find(SymbolTable ht, SymbolType st)
{
  int i = hash(st.word, HASHSIZE);

  if (ht[i].word[0] == 0)
    return 0;

  while (ht[i].word[0] != 0)
  {
    if (strcmp(ht[i].word, st.word) == 0)
      return 1;

    i++;
    i %= HASHSIZE;
  }

  return 0;
}


