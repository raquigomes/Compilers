%option noyywrap
%{
#include <stdlib.h>
#include <string.h>
#include "parser.h"

int line = 0;
int column = 0;

#define INC_LINE line++;column=0;
#define INC_COL  column+=strlen(yytext)
%}

%option yylineno

INT [0-9]+
FLOAT [0-9]*\.[0-9]+([eE][\+\-]?[0-9]+)?
ID [A-Za-z]+[0-9A-Za-z]*
BOOLEAN [true | false]
STRING \"[^\"]*\"

%%

"."        { INC_COL; return(POT); }
":"        { INC_COL; return(DOISPONTOS); }
";"        { INC_COL; return(PONTVIRG); }
","        { INC_COL; return(VIRG); }
"+"       { INC_COL; return(ADD);}
"="       { INC_COL; return(ASSIGN);}
"-"       { INC_COL; return(SUB);}
"*"       { INC_COL; return(MUL);}
"/"       { INC_COL; return(DIV);}
"mod"     { INC_COL; return(MOOD);}
"^"       { INC_COL; return(EXP);}
"=="      { INC_COL; return(EQUAL);}
"!="      { INC_COL; return(DIFFERENT);}
"<"       { INC_COL; return(LESS);}
">"       { INC_COL; return(GREAT);}
"<="      { INC_COL; return(LESSEQUAL);}
">="      { INC_COL; return(GREATEQUAL);}
"and"     { INC_COL; return(AND);}
"or"      { INC_COL; return(OR);}
"if"      { INC_COL; return(IF);}
"then"    { INC_COL; return(THEN);}
"else"    { INC_COL; return(ELSE);}
"while"   { INC_COL; return(WHILE);}
"["       { INC_COL; return(LPARRET);}
"]"       { INC_COL; return(RPARRET);}
"("       { INC_COL; return(LPAR);}
")"       { INC_COL; return(RPAR);}
"{"       { INC_COL; return(LCHAV);}
"}"       { INC_COL; return(RCHAV);}
"not"     { INC_COL; return(NOT);}
"int"     { INC_COL; return(INT);}
"float"   { INC_COL; return(FLOAT);}
"string"  { INC_COL; return(STRING);}
"bool"    { INC_COL; return(BOOL);}
"void"    { INC_COL; return(VOID);}
"define"  { INC_COL; return(DEFINE);}
"do"      { INC_COL; return(DO);}
"break"   { INC_COL; return(BREAK);}
"next"    { INC_COL; return(NEXT);}
"return"  { INC_COL; return(RETURN);}
"print"   { INC_COL; return(PRINT);}
"input"   { INC_COL; return(INPUT);}


{ID}   {yylval.var = strdup(yytext); return ID; }
{FLOAT} {yylval.valfloat = atof(yytext); return FLOAT; }
{INT}   {yylval.val = atoi(yytext); return NUM; }
{STRING}   {yylval.str = strdup(yytext); return STRING; }


#.*     ; /*ignore comments */
[ \t\n]+  ; /* ignore space */
