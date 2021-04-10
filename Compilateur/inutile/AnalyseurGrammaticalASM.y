%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol_table_asm.h"

int yyerror(char*s) ;
int yylex();


%}

%union {
    int adresse;
    char* codeVar;
}

%token<codeVar> tCV
%token<adresse> tNB
%token tNL




%%

Code : tNB tNB tNB tNL 
        {
            tripleOrdre($1, $2, $3);
        }
       Code
     | tNB tNB tNB tNB tNL
        {
            quadrupleOrdre($1, $2, $3, $4);
        } 
       Code
     | tCV tNB tNL
        {
            doubleVar($1, $2);
        } 
       Code
     | 
        {printf("Fin Code\n");
        exit(0);}
     ;



%%


int yyerror(char*s) {
    printf("Erreur yyerror : %s\n", s);
}

int main() {
    printf("Debut Interpreteur :\n");
    yyparse();

    return 1;
}


