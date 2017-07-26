%{
#include <stdio.h>
#include <string.h>
#include "apt.c"
int yylex (void);
void yyerror (char const *);

void set_value(char *id, double value);
double get_value(char *id);

%}

%union{
	int val;
	float valfloat;
	char *id;
	char *var;
	//int literal;

	ya_variable *variable;
	ya_exp *exp;
	ya_decl *decl;
	ya_func_args *func_args;
	ya_tipo *tipo;
	ya_comp *comp;
	ya_cond *cond;
	ya_func_int *func_int;
	ya_func *func;
	ya_literal *literal;
	//ya_tipo *tipo;
	
}

/* Bison declarations */
%token <valfloat>	FLOAT
%token <var>		VAR
%token <str>		STRING
%token <id>			ID
%token <int>		INT
%token <literal>    LITERAL

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
prog: func   		{$$ = new_prog($1,NULL,NULL);}
	| func prog     {$$ = new_prog($1,$2,NULL)}  
	| decl prog     {$$ = new_prog(NULL,$2,$1);}
;

//                                         (ID,variable) 
variable: ID                     {$$ = new_var($1,NULL);}
		| ID VIRG variable       {$$ = new_var($1,$3);}
;

//                                        (exp,exp,ID,literal)
exp: ID                         {$$ = new_exp(NULL,NULL,$1,NULL);}
	|exp ADD exp 			    {$$ = new_exp($1, $3,NULL,NULL);}
	|exp SUB exp			    {$$ = new_exp($1, $3,NULL,NULL);}
	|exp MUL exp 			    {$$ = new_exp($1, $3,NULL,NULL);}
	|exp DIV exp 			    {$$ = new_exp($1, $3,NULL,NULL);}
	|exp POT exp			    {$$ = new_exp($1, $3,NULL,NULL);}
	|exp MOOD exp			    {$$ = new_exp($1, $3,NULL,NULL);}
	|literal                    {$$ = new_exp(NULL,NULL,NULL,$1);}
	|ID ASSIGN exp			    {$$ = new_exp($3, NULL,$1,NULL); }
	|ID ASSIGN LPAR exp RPAR	{$$ = new_exp($4, NULL,$1,NULL); }
;

//                                                                         (variable,tipo,exp,literal)                 
decl: variable DOISPONTOS tipo PONTVIRG                                {$$ = decl($1,$3,NULL,NULL);}
	| variable DOISPONTOS tipo ASSIGN exp PONTVIRG                     {$$ = decl($1,$3,$5,NULL);}
 	| variable DOISPONTOS tipo ASSIGN literal PONTVIRG                 {$$ = decl($1,$3,NULL,$5);}
;

//                                                                              (ID,func_args,tipo,func_int)
func: ID LPAR func_args RPAR DOISPONTOS tipo LCHAV func_int RCHAV PONTVIRG {$$ = func($1,$3,$6,$8);}

//                                                        (cond,func_int,decl,exp,ID,func_args,RETURN/PRINT/INPUT)
func_int: cond func_int	                            {$$ = new_func_int($1,$2,NULL,NULL,NULL,NULL,NULL_);}
        | decl func_int                             {$$ = new_func_int(NULL,$2,$1,NULL,NULL,NULL,NULL_);}
        | RETURN exp                                {$$ = new_func_int(NULL,NULL,NULL,$2,NULL,NULL,RETURN_);}
        | PRINT LPAR ID RPAR PONTVIRG func_int      {$$ = new_func_int(NULL,$6,NULL,NULL,$3,NULL,PRINT_);}
        | INPUT exp                                 {$$ = new_func_int(NULL,NULL,NULL,$2,NULL,NULL,INPUT_);}
        | ID LPAR func_args RPAR func_int           {$$ = new_func_int(NULL,$5,NULL,NULL,$1,$3,NULL_);}
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

func_args: ID DOISPONTOS tipo                   {$$ = new_func_args($1,$3,NULL);}
		 | ID DOISPONTOS tipo VIRG func_args    {$$ = new_func_args($1,$3,$5);}
		 | /*vazio*/                            {$$ = NULL;}
;

literal : INT      {$$=new_literal(L_INT_)}
		| BOOL     {$$=new_literal(L_BOOL_)}
		| FLOAT    {$$=new_literal(L_FLOAT_)}
		| STRING   {$$=new_literal(L_STRING_)}

;

tipo:
	  TYPE_INT			{ $$ = new_tipo(INT_); }
	| TYPE_FLOAT		{ $$ = new_tipo(FLOAT_); }
	| TYPE_BOOL			{ $$ = new_tipo(BOOL_); }
	| TYPE_STRING		{ $$ = new_tipo(STRING_); }
	| TYPE_VOID			{ $$ = new_tipo(VOID_); }
;


comp:
	 exp EQUAL exp		{ $$ = new_comp($1, $3,EQUAL_);}
	|exp DIFFERENT exp	{ $$ = new_comp($1, $3,DIFFERENT_);}
	|exp LESS exp		{ $$ = new_comp($1, $3,LESS_);}
	|exp GREAT exp		{ $$ = new_comp($1, $3,GREAT_);}
	|exp LESSEQUAL exp	{ $$ = new_comp($1, $3,LESSEQUAL_);}
	|exp GREATEQUAL exp	{ $$ = new_comp($1, $3,GREATEQUAL_);}
	|exp AND exp		{ $$ = new_comp($1, $3,AND_);}
	|exp OR exp			{ $$ = new_comp($1, $3,OR_);}
	|NOT exp			{ $$ = new_comp($2, NULL,NOT_); }
;


%%

void yyerror (char const *s){
	fprintf (stderr, "%s\n", s);
}

int main (void){
	return yyparse();
}






