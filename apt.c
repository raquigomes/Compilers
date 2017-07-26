#include "apt.h"

ya_prog new_prog(ya_func arg1, ya_prog arg2, ya_decl arg3){
	ya_prog no = (ya_prog) malloc(sizeof(*no));
	if(arg2==NULL && arg3==NULL){
		no->u.prog1.arg1=arg1;
	}else if(arg2!=NULL && arg3==NULL){
		no->u.prog2.arg1=arg1;
		no->u.prog2.arg2=arg2;
	}else{
		no->u.prog3.arg2=arg2;
		no->u.prog3.arg3=arg3;
	}
}

ya_variable new_variable(char* arg1, ya_variable arg2){
	ya_variable no = (ya_variable) malloc(sizeof(*no));
	if(arg2 == NULL){
		no->u.variable1.arg1=strdup(arg1);
	}else{
		no->u.variable2.arg1=arg1;
		no->u.variable2.arg2=arg2;
	}
}

ya_exp new_exp(ya_exp arg1, ya_exp arg2, char* arg3, ya_literal arg4){
	ya_exp no = (ya_exp) malloc(sizeof(*no));
	if(arg1==NULL && arg2==NULL && arg4==NULL){
		no->u.exp_1.arg3=strdup(arg3);
	}else if(arg3==NULL && arg4==NULL){
		no->u.exp_2.arg1=arg1;
		no->u.exp_2.arg2=arg2;
	}else if(arg1==NULL && arg2==NULL && arg3==NULL){
		no->u.exp_3.arg4=arg4;
	}else{
		no->u.exp_4.arg1=arg1;
		no->u.exp_4.arg3=strdup(arg3);
	}
}

ya_decl new_decl(ya_variable arg1, ya_tipo arg2, ya_exp arg3, ya_literal arg4){
	ya_decl no = (ya_decl) malloc(sizeof(*no));
	if(arg3==NULL && arg4==NULL){
		no->u.decl1.arg1=arg1;
		no->u.decl1.arg2=arg2;
	}else if(arg4==NULL && arg3!=NULL){
		no->u.decl2.arg1=arg1;
		no->u.decl2.arg2=arg2;
		no->u.decl2.arg3=arg3;
	}else{
		no->u.decl3.arg1=arg1;
		no->u.decl3.arg2=arg2;
		no->u.decl3.arg4=arg4;
	}
}

ya_func new_func(char* arg1,ya_func_args arg2,ya_tipo arg3,ya_func_int arg4){
	ya_func no = (ya_func) malloc(sizeof(*no));
	no->arg1=strdup(arg1);
	no->arg2=arg2;
	no->arg3=arg3;
	no->arg4=arg4;
}

ya_func_int new_func_int(ya_cond arg1, ya_func_int arg2,ya_decl arg3,ya_exp arg4,char* arg5,ya_func_args arg6,_ya_func_int_ arg7){
	ya_func_int no = (ya_func_int) malloc(sizeof(*no));
	if(arg3==NULL && arg4==NULL && arg5==NULL && arg6==NULL){
		no->u.fint1.arg1=arg1;
		no->u.fint1.arg2=arg2;
		no->u.fint1.arg7=arg7;
	}
	else if(arg1==NULL && arg4==NULL && arg5==NULL && arg6==NULL){
		no->u.fint2.arg2=arg2;
		no->u.fint2.arg3=arg3;
		no->u.fint2.arg7=arg7;
	}
	else if(arg1==NULL && arg2==NULL && arg3==NULL && arg6==NULL){
		no->u.fint3.arg4=arg4;
		no->u.fint3.arg7=arg7;
	}
	else if(arg1==NULL && arg3==NULL && arg4==NULL){
		no->u.fint4.arg2=arg2;
		no->u.fint4.arg5=arg5;
	}
	else{
		no->u.fint5.arg2=arg2;
		no->u.fint5.arg5=strdup(arg5);
		no->u.fint5.arg6=arg6;
		no->u.fint5.arg7=arg7;
	}
}

ya_cond new_cond(ya_exp arg1,ya_prog arg2,ya_comp arg3,ya_prog arg4){
	ya_cond no = (ya_cond) malloc(sizeof(*no));
	if(arg3==NULL && arg4==NULL){
		no->u.cond1.arg1=arg1;
		no->u.cond1.arg2=arg2;
	}
	else if(arg1==NULL && arg4==NULL){
		no->u.cond2.arg2=arg2;
		no->u.cond2.arg3=arg3;
	}
	else{
		no->u.cond3.arg2=arg2;
		no->u.cond3.arg3=arg3;
		no->u.cond3.arg4=arg4;
	}
}

ya_func_args new_func_args(char* arg1,ya_tipo arg2, ya_func_args arg3){
	ya_func_args no = (ya_func_args) malloc(sizeof(*no));
	if(arg3==NULL){
		no->u.func_args1.arg1=strdup(arg1);
		no->u.func_args1.arg2=arg2;
	}else{
		no->u.func_args2.arg1=strdup(arg1);
		no->u.func_args2.arg2=arg2;
		no->u.func_args2.arg3=arg3;
	}
}

ya_literal new_literal(_ya_literal_ arg1){
	ya_literal no = (ya_literal) malloc(sizeof(*no));
	no->arg1=arg1;
}

ya_tipo new_tipo(_ya_tipo_ arg1){
	ya_tipo no = (ya_tipo) malloc(sizeof(*no));
	no->arg1=arg1;
}

ya_comp new_comp(ya_exp arg1, ya_exp arg2, _ya_comp_ arg3){
	ya_comp no = (ya_comp) malloc(sizeof(*no));
	if(arg2!=NULL){
		no->u.comp1.arg1=arg1;
		no->u.comp1.arg2=arg2;
		no->u.comp1.arg3=arg3;
	}else{
		no->u.comp2.arg1=arg1;
		no->u.comp2.arg3=arg3;
	}

}