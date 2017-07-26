#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "analise_semantica.h"

void analise_semantica(programa p){
	if(p==NULL){
		printf("NULL\n");
	}
	else {
		switch (p->kind) {
			case P_DECLS:
				analise_decl(p->u.d);
				break;
			default:
				printf("Não foi possível ler o programa");
				break;
		}
	}
}


void analise_tipo(tipo t){
	if(t==NULL)
		printf("NULL TIPO\n");
	else {
		switch (t->kind) {
			case SINGLE_T:
				printf("TIPO: %s\n", t->u.t);
				break;
			default:
				printf("Não foi possível ler o programa");
				break;
		}
	}
}



void analise_func_args(func_args a){
	if(a == NULL)
		printf("NULL ARG_FUNC\n");
	else {
		switch (a->kind) {
			case ID_A:
				break; /////
			case ID_AF:
				analise_argf(a->u.id_af.af); /////
				break;
			case ID_T_AF:
				analise_tipo(a->u.id_t_af.t);  ///
				analise_argf(a->u.id_t_af.af);
				break;
			case ID_T:
				analise_tipo(a->u.id_t.t);///
				break;
			default:
				printf("Não foi possível ler o programa");
				break;
		}
	}
}




void analise_decl( decl d){
	switch(d->kind){
		case IF:
			analise_calcb(d->u.i.b);
			analise_stms(d->u.i.s);
			break;
		case IF_ELSE:
			analise_calcb(d->u.i_else.b);
			analise_stms(d->u.i_else.s1);
			analise_stms(d->u.i_else.s2);
			break;
		case WHILE:
			analise_calcb(d->u.dhl.b);
			analise_stms(d->u.dhl.s);
			break;
		default:
			printf("Não foi possível ler o programa");
			break;
	}
}




void analise_calc_exp(calc_exp e){
	int count = 0;
	switch(e->kind){
		case CALC_NUM:
			break;
		case EXP_FLOAT:
			break;
		case CALC_ID:
			break;
		case CALC_STRING:
			break;
		case EXP_BINOP:
			analise_calc_exp(e->u.binop.arg1);
			analise_calc_exp(e->u.binop.arg2);
			break;
		case CALC_ASSIGN:
			analise_calc_exp(e->u.assign.arg);
			break;
		default:
			printf("Não foi possível ler o programa");
			break;

	}
}

