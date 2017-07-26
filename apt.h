#ifndef APT_H
#define APT_H

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define SIZE 100

typedef struct ya_prog *ya_prog;
typedef struct ya_variable *ya_variable;
typedef struct ya_exp *ya_exp;
typedef struct ya_decl *ya_decl;
typedef struct ya_func_args *ya_func_args;
typedef struct ya_tipo *ya_tipo;
typedef struct ya_comp *ya_comp;
typedef struct ya_cond *ya_cond;
typedef struct ya_func_int *ya_func_int;
typedef struct ya_func *ya_func;
typedef struct ya_literal *ya_literal;

typedef enum ya_tipo_{
	INT_,BOOL_,FLOAT_,STRING_,VOID_
}_ya_tipo_;

typedef enum _ya_comp_{
	EQUAL_,DIFFERENT_,LESS_,GREAT_,LESSEQUAL_,GREATEQUAL_,AND_,OR_,NOT_	
}_ya_comp_;

typedef enum _ya_func_int_{
	RETURN_,INPUT,PRINT_,NULL_
}_ya_func_int_;

typedef enum _ya_literal_{
	L_INT_,L_FLOAT_,L_BOOL_,L_STRING_
}_ya_literal_;

//---------------------------------------------------
struct ya_prog{
	union{
		struct {
			ya_func arg1;
		}prog1;
		struct{
			ya_func arg1;
			ya_prog arg2;
		}prog2;
		struct {
			ya_decl arg3;
			ya_prog arg2;
		}prog3;
	}u;
};

struct ya_variable{
	union{
		struct {
			char* arg1;
		}variable1;
		struct {
			char* arg1;
			ya_variable arg2;
		}variable2;
	}u;
};

struct ya_exp {
	union{
		struct {
			char* arg3;
		}exp_1;
		struct {
			ya_exp arg1;
			ya_exp arg2;
		}exp_2;
		struct{
			ya_literal arg4;
		}exp_3;
		struct{
			char* arg3;
			ya_exp arg1;
		}exp_4;
	}u;
};

struct ya_decl{
	union{
		struct{
			ya_variable arg1;
			ya_tipo arg2;
		}decl1;
		struct{
			ya_variable arg1;
			ya_tipo arg2;
			ya_exp arg3;
		}decl2;
		struct{
			ya_variable arg1;
			ya_tipo arg2;
			ya_literal arg4;
		}decl3;
	}u;
};

struct ya_func{
	char* arg1;
	ya_func_args arg2;
	ya_tipo arg3;
	ya_func_int arg4;
};

struct ya_func_int{
	union{
		struct {
			ya_cond arg1;
			ya_func_int arg2;
			_ya_func_int_ arg7;
		}fint1;
		struct {
			ya_func_int arg2;
			ya_decl arg3;
			_ya_func_int_ arg7;
		}fint2;
		struct {
			ya_exp arg4;
			_ya_func_int_ arg7;
		}fint3;
		struct {
			ya_func_int arg2;
			char* arg5;
		}fint4;
		struct {
			ya_func_int arg2;
			_ya_func_int_ arg7;
			char* arg5;
			ya_func_args arg6;
		}fint5;
	}u;
};

struct ya_cond{
	union{
		struct {
			ya_exp arg1;
			ya_prog arg2;
		}cond1;
		struct {
			ya_prog arg2;
			ya_comp arg3;
		}cond2;
		struct {
			ya_prog arg2;
			ya_comp arg3;
			ya_prog arg4;
		}cond3;
	}u;	
};

struct ya_func_args{
	union{
		struct{
			char* arg1;
			ya_tipo arg2;
		}func_args1;
		struct{
			char* arg1;
			ya_tipo arg2;
			ya_func_args arg3;
		}func_args2;
	}u;
};

struct ya_literal{
	_ya_literal_ arg1;
};

struct ya_tipo{
	_ya_tipo_ arg1;
};

struct ya_comp{
	union{
		struct{
			ya_exp arg1;
			ya_exp arg2;
			_ya_comp_ arg3;
		}comp1;
		struct{
			ya_exp arg1;
			_ya_comp_ arg3;
		}comp2;
	}u;
};

ya_prog new_prog(ya_func arg1, ya_prog arg2, ya_decl arg3);
ya_variable new_variable(char* arg1, ya_variable arg2);
ya_exp new_exp(ya_exp arg1, ya_exp arg2, char* arg3, ya_literal arg4);
ya_decl new_decl(ya_variable arg1, ya_tipo arg2, ya_exp arg3, ya_literal arg4);
ya_func new_func(char* arg1,ya_func_args arg2,ya_tipo arg3,ya_func_int arg4);
ya_func_int new_func_int(ya_cond arg1, ya_func_int arg2,ya_decl arg3,
	ya_exp arg4,char* arg5,ya_func_args arg6,_ya_func_int_ arg7);
ya_cond new_cond(ya_exp arg1,ya_prog arg2,ya_comp arg3,ya_prog arg4);
ya_func_args new_func_args(char* arg1,ya_tipo arg2, ya_func_args arg3);
ya_literal new_literal(_ya_literal_ arg1);
ya_tipo new_tipo(_ya_tipo_ arg1);
ya_comp new_comp(ya_exp arg1, ya_exp arg2, _ya_comp_ arg3);

#endif
