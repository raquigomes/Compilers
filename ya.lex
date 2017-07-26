%{
#include <stdlib.h>
#include "parser.h"

%}

INT  [0-9]+
STRING \"[^\"]*\"
FLOAT [0-9]*\.[0-9]+([eE][\-\+]?[0-9]+)?
BOOLEAN [true | false]
ID [A-Za-z]+[0-9A-Za-z]*


%%

"define" { return DEFINE; }
"if" { return IF; }
"then" { return THEN; }
"else" { return ELSE; }
"while" { return WHILE; }
"do" { return DO; }
"return" { return RETURN; }
"break" { return BREAK; }
"next" { return NEXT; }


"int" { return TYPE_INT; }
"float" { return TYPE_FLOAT; }
"string" { return TYPE_STRING; }
"boolean" {return TYPE_BOOL; }
"true" {yylval.val = 1; return BOOL; }
"false" {yylval.val = 0; return BOOL; }
"void" { return TYPE_VOID; }




"+"	{ return ADD; }
"-"	{ return SUB; }
"/"	{ return DIV; }
"*"	{ return MUL; }
"^" { return POT; }
"mod" { return MOD; }
"==" { return EQUAL; }
"!=" { return DIFFERENT;
"<" { return LESS; }
">" { return GREAT; }
"<=" { return LESSEQUAL; }
">=" { return GREATEQUAL; }
"and" { return AND; }
"or" { return OR; }
"not" { return NOT; }
":" { return DOISPONTOS; }
";" { return PONTVIRG; }
"," { return VIRG; }
"=" { return ASSIGN; }
"("	{ return LPAR; }
")"	{ return RPAR; }
"{" { return LCHAV; }
"}" { return RCHAV; }
"[" { return LPARRET; }
"]" { return RPARRET; }

"print" { return PRINT; }


{INT}   {yylval.val = atoi(yytext); return NUM; }
{STRING}   {yylval.str = strdup(yytext); return STRING; }
{FLOAT} {yylval.valfloat = atof(yytext); return FLOAT; }
{ID}   {yylval.var = strdup(yytext); return ID; }


#.*\n
[ \t]+
\n

%%

int yywrap()  {
    return 1;
}
