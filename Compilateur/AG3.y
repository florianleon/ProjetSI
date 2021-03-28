%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol_table.h"
int yyerror(char*s) ;
int yylex();


%}
%union {
    char *variable;
    int nombre;
}

%token tMAIN 
%token tAO 
%token tAF 
%token tINT 
%token tCONST  
%token tPO 
%token tPF 
%token tESPACE
%token tV 
%token tPV 
%token tPRINT 
%token<nombre> tNB 
%token tEXP 
%token<variable> tVAR 
%token tMUL


%right tEQ 
%left tADD 
%left tSUB 
%left tDIV

%type<variable> Variable    /* inutile pour le moment */


%%

Main : tINT tMAIN tAO Programme tAF 
            {printf("Fin Main\n");
            afficher();}
     ;

Programme : Programme Declaration tPV 
          | Programme Instruction tPV
          | Programme tPRINT tPO tVAR tPF tPV 
                {printf("Print !\n");}
          |
          ;


Declaration : tCONST tINT Variable tEQ Expression
                {printf("declaration assignation constante\n");
                printf("%s\n", $3);
                ajouter(1, 1);
                }
            | tCONST tINT Variable
                {printf("declaration constante\n");
                ajouter(1, 0);
                }
            | tINT Variable tEQ Expression
                {printf("declaration assignation\n");
                ajouter(0, 1);
                afficher();}
            | tINT Variable
                {printf("declaration \n");
                ajouter(0, 0);
                afficher();}
            ;

Variable : tVAR tV Variable
            {ajouterListe($1);
            printf("declaration Var+\n");}
         | tVAR 
            {ajouterListe($1);
            printf("declaration Var\n");}
         ;


Expression : Expression tADD Expression 
                {printf("Addition\n");}
           | Expression tSUB Expression 
                {printf("Soustraction\n");}
           | Expression tMUL Expression 
                {printf("Multiplication\n");}
           | Expression tDIV Expression 
                {printf("Division\n");}
           | tPO Expression tPF 
                {printf("(Expr)\n");}
           | tNB 
                {printf("Nombre !\n");}
           | tVAR 
                {printf("Variable !\n");}
           ;

Instruction : tVAR tEQ Expression 
                {printf("assignation Var already declared\n");
                setInit($1);}
            ;


%%
int yyerror(char*s) {
    printf("Erreur : %s\n", s);
}
int main() {
    yyparse();
    return 1;
}


