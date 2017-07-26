#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define SIZE 100

typedef struct prog *prog;
typedef struct variable *variable;
typedef struct exp *exp;
typedef struct decl *decl;
typedef struct func_args *func
typedef struct tipo *tipo;
typedef struct comp *comp;
typedef struct cond *cond;
typedef struct func_int *func_int;
typedef struct func *func;

typedef enum tipo_{
	INT_,BOOL_,FLOAT_,STRING_,VOID_
}tipo_;

typedef enum comp_{
	EQUAL_,DIFFERENT_,LESS_,GREAT_,LESSEQUAL_,GREATEQUAL_,AND_,OR_,NOT_	
}comp_

typedef enum func_int_{
	RETURN_,INPUT,PRINT_,NULL_
}func_int_

typedef enum literal_{
	L_INT_,L_FLOAT_,L_BOOL_,L_STRING_
}literal_

//---------------------------------------------------
struct prog{
	union{
		struct {
			func arg1;
		}prog1;
		struct{
			func arg1;
			prog arg2;
		}prog2;
		struct {
			decl arg3;
			prog arg2;
		}prog3;
	}u;
};

struct variable{
	union{
		struct {
			char* arg1;
		}variable1;
		struct {
			char* arg1;
			variable arg2;
		}variable2;
	}u;
};

struct exp {
	union{
		struct {
			char* arg3;
		}exp_1;
		struct {
			exp arg1;
			exp arg3;
		}exp_2;
		struct {
			exp arg1;
			exp arg3;
		}exp_3;
		struct {
			exp arg1;
			exp arg3;
		}exp_4;
		struct {
			exp arg1;
			exp arg3;
		}exp_5;
		struct {
			exp arg1;
			exp arg3;
		}exp_6;
		struct {
			exp arg1;
			exp arg3;
		}exp_7;
		struct{
			literal arg4;
		}exp_8;
		struct{
			char* arg3;
			exp arg1;
		}exp_9;
		struct{
			char* arg3;
			exp arg1;
		}exp_10;
	}u;
};

struct decl{
	union{
		struct{
			var arg1;
			tipo arg2;
		}decl1;
		struct{
			var arg1;
			tipo arg2;
			exp arg3;
		}decl2;
		struct{
			var arg1;
			tipo arg2;
			literal arg4;
		}decl3;
	}u;
};

struct func{
	char* arg1;
	func_args arg2;
	tipo arg3;
	func_int arg4;
};

struct func_int{
	union{
		struct {
			cond arg1;
			func_int arg2;
			func_int_ arg7;
		}fint1;
		struct {
			func_int arg2;
			decl arg3;
			func_int_ arg7;
		}fint2;
		struct {
			exp arg4;
			func_int_arg7;
		}fint3;
		struct {
			func_int arg2;
			char* arg5;
		}fint4;
		struct {
			exp arg4;
			func_int_arg7;
		}fint5;
		struct {
			func_int arg2;
			func_int_ arg7;
			char* arg5;
			func_args arg6;
		}fint6;
	}u;
};

struct cond{
	union{
		struct {
			exp arg1;
			prog arg2;
		}cond1;
		struct {
			prog arg2;
		}cond2;
		struct {
			
		}cond3;
		struct {
			
		}cond4;
		struct {
			
		}cond5;
		struct {
			
		}cond6;
	}u;
	
};

