%{
#include <stdio.h>
#include <string.h>
#include "symboltable.h"
int yylex (void);
void yyerror (char const *);

void set_value(char *id, double value);
double get_value(char *id);

%}

%union{
	int val;
	float valfloat;
	char *id;
	char *variavel;

	struct calc_exp *calc_exp
	
}

/* Bison declarations */
%token <val>		NUM BOOLEAN
%token <valfloat>	FLOAT
%token <var>		VAR
%token <str>		STRING
%token <id>			ID

%token DEFINE IF THEN ELSE WHILE DO RETURN BREAK NEXT
%token TYPE_INT TYPE_FLOAT TYPE_BOOL TYPE_STRING TYPE_VOID
%token BOOL

%left SUB
%left ADD
%left MUL
%left DIV
%left MOOD
%left NEG

%right POT
%right ASSIGN 

%token EQUAL DIFFERENT LESS GREAT LESSEQUAL GREATEQUAL
%token AND OR NOT
%token DOISPONTOS PONTVIRG VIRG
%token LPAR RPAR LPARRET RPARRET LCHAV RCHAV
%token PRINT
%token NL 
%token INPUT

%type <prog> prog
%type <variable> variable
%type <exp> exp
%type <decl> decl
%type <func_args> func_args
%type <tipo> tipo
%type <comp> comp
%type <cond> cond
%type <func_int> func_int
%type <func> func
%type <literal> literal

%%
//                            (func,prog,decl)
prog: func   		{$$ = prog($1,NULL,NULL);}
	| func prog     {$$ = prog($1,$2,NULL)}  
	| decl prog     {$$ = prog(NULL,$2,$1);}
;

//                                         (ID,variable) 
variable: ID                     {$$ = var($1,NULL);}
		| ID VIRG variable       {$$ = var($1,$3);}
;

//                                        (exp,exp,ID,literal)
exp: ID                         {$$ = exp(NULL,NULL,$1,NULL);}
	|exp ADD exp 			    {$$ = exp($1, $3,NULL,NULL);}
	|exp SUB exp			    {$$ = exp($1, $3,NULL,NULL);}
	|exp MUL exp 			    {$$ = exp($1, $3,NULL,NULL);}
	|exp DIV exp 			    {$$ = exp($1, $3,NULL,NULL);}
	|exp POT exp			    {$$ = exp($1, $3,NULL,NULL);}
	|exp MOOD exp			    {$$ = exp($1, $3,NULL,NULL);}
	|literal                    {$$ = exp(NULL,NULL,NULL,$1);}
	|ID ASSIGN exp			    {$$ = exp($3, NULL,$1,NULL); }
	|ID ASSIGN LPAR exp RPAR	{$$ = exp($4, NULL,$1,NULL); }
;

//                                                                         (variable,tipo,exp,literal)                 
decl: variable DOISPONTOS tipo PONTVIRG                                {$$ = decl($1,$3,NULL,NULL);}
	| variable DOISPONTOS tipo ASSIGN exp PONTVIRG                     {$$ = decl($1,$3,$5,NULL);}
 	| variable DOISPONTOS tipo ASSIGN literal PONTVIRG                 {$$ = decl($1,$3,NULL,$5);}
;

//                                                                              (ID,func_args,tipo,func_int)
func: ID LPAR func_args RPAR DOISPONTOS tipo LCHAV func_int RCHAV PONTVIRG {$$ = func($1,$3,$6,$8);}

//                                                                (cond,func_int,decl,exp,ID,func_args,RETURN/PRINT/INPUT)
func_int: cond func_int	                            {$$ = func_int($1,$2,NULL,NULL,NULL,NULL,NULL_);}
        | decl func_int                             {$$ = func_int(NULL,$2,$1,NULL,NULL,NULL,NULL_);}
        | RETURN exp                                {$$ = func_int(NULL,NULL,NULL,$2,NULL,NULL,RETURN_);}
        | PRINT LPAR ID RPAR PONTVIRG func_int      {$$ = func_int(NULL,$6,NULL,NULL,$3,NULL,PRINT_);}
        | INPUT exp                                 {$$ = func_int(NULL,NULL,NULL,$2,NULL,NULL,INPUT_);}
        | ID LPAR func_args RPAR func_int           {$$ = func_int(NULL,$5,NULL,NULL,$1,$3,NULL_);}
;

//                                                                                    (exp,prog,comp,prog2)                               
cond:
	  WHILE LPAR exp RPAR DO LCHAV prog RCHAV PONTVIRG 	                      { $$ = cond($3, $7,NULL,NULL); }			
	| WHILE LPAR comp RPAR DO LCHAV prog RCHAV PONTVIRG                       { $$ = cond(NULL, $7,$3,NULL);}
	| IF LPAR exp RPAR THEN LCHAV prog RCHAV PONTVIRG                         { $$ = cond($3, $7,NULL,NULL); }
	| IF LPAR exp RPAR THEN LCHAV prog RCHAV ELSE LCHAV prog RCHAV PONTVIRG	  { $$ = cond($3, $7,NULL, $11); }	
	| IF LPAR comp RPAR THEN LCHAV prog RCHAV PONTVIRG                        { $$ = cond(NULL,$7,$3,NULL); }
	| IF LPAR comp RPAR THEN LCHAV prog RCHAV ELSE LCHAV prog RCHAV PONTVIRG  { $$ = cond(NULL,$7, $3, $11); }
;

func_args: ID DOISPONTOS tipo                   {$$ = func_args($1,$3,NULL);}
		 | ID DOISPONTOS tipo VIRG func_args    {$$ = func_args($1,$3,$5);}
		 | /*vazio*/                            {$$ = NULL;}
;

literal : INT      {$$=literal(L_INT)}
		| BOOL     {$$=literal(L_BOOL)}
		| FLOAT    {$$=literal(L_FLOAT)}
		| STRING   {$$=literal(L_STRING)}
tipo:
	  TYPE_INT			{ $$ = tipo(INT_); }
	| TYPE_FLOAT		{ $$ = tipo(FLOAT_); }
	| TYPE_BOOL			{ $$ = tipo(BOOL_); }
	| TYPE_STRING		{ $$ = tipo(STRING_); }
	| TYPE_VOID			{ $$ = tipo(VOID_); }
;


comp:
	 exp EQUAL exp		{ $$ = comp($1, $3,EQUAL_);}
	|exp DIFFERENT exp	{ $$ = comp($1, $3,DIFFERENT_);}
	|exp LESS exp		{ $$ = comp($1, $3,LESS_);}
	|exp GREAT exp		{ $$ = comp($1, $3,GREAT_);}
	|exp LESSEQUAL exp	{ $$ = comp($1, $3,LESSEQUAL_);}
	|exp GREATEQUAL exp	{ $$ = comp($1, $3,GREATEQUAL_);}
	|exp AND exp		{ $$ = comp($1, $3,AND_);}
	|exp OR exp			{ $$ = comp($1, $3,OR_);}
	|NOT exp			{ $$ = comp($2, NULL,NOT_); }
;


%%

void yyerror (char const *s){
	fprintf (stderr, "%s\n", s);
}

int main (void){
	return yypase();
}
