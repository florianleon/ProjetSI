%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol_table.h"
int yyerror(char*s) ;
int yylex();
FILE *fd;

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
%type<nombre> Expression


%%

Main : tINT tMAIN tAO Programme tAF 
            {printf("Fin Main\n");
            afficher();
            exit(0);}
     ;

Programme : Programme Declaration tPV 
          | Programme Assignation tPV
          | Programme tPRINT tPO tVAR tPF tPV 
                {printf("Print !\n");}
          |
          ;


Declaration : tCONST tINT Variable tEQ Expression
                {printf("declaration assignation constante\n");
                ajouter(1, 1, fd, $5);
                }
            | tCONST tINT Variable
                {printf("declaration constante\n");
                ajouter(1, 0, fd, 0);
                }
            | tINT Variable tEQ Expression
                {printf("declaration assignation\n");
                ajouter(0, 1, fd, $4);
                afficher();}
            | tINT Variable
                {printf("declaration \n");
                ajouter(0, 0, fd, 0); // assigner ? directement en c ?
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
                {printf("Addition\n");
                ecrireOperationASM(fd, "ADD", $1, $3);
                }
           | Expression tSUB Expression 
                {printf("Soustraction\n");}
           | Expression tMUL Expression 
                {printf("Multiplication\n");}
           | Expression tDIV Expression 
                {printf("Division\n");}
           | tPO Expression tPF 
                {printf("(Expr)\n");}
           | tNB 
                {printf("Nombre !\n");
                nbASM(fd, $1);
                // tmp TODO
                $$ = derniereTmp();}
           | tVAR 
                {printf("Variable !\n");
                varASM(fd, $1);
                $$ = derniereTmp(); // à modifier pour utiliser tmp TODO
                }
           ;

Assignation : tVAR tEQ Expression 
                {printf("assignation Var already declared\n");
                setInit($1);
                asignerASM(fd, $1); // TODO verifier que expression et bien dans tmp et à la bonne place
                }
            ;


%%
int yyerror(char*s) {
    printf("Erreur : %s\n", s);
}
int main() {
    fd = fopen("codeasm.s", "w");
    yyparse();
    fclose(fd);
    return 1;
}


