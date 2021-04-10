%{
#include <stdlib.h>
#include <stdio.h>
#include "symbol_table_c.h"

int yyerror(char*s) ;
int yylex();

FILE *fdCode;
FILE *fdClair;

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

%token tESP
 /* %token tAST pareil que tMUL */


%token tET
%token tNE
%token tSE
%token tIE
%token tST
%token tIT
%token tIF
%token tELSE
%token tWHILE

%token tMUL


%right tEQ 
%left tADD 
%left tSUB 
%left tDIV


%type<nombre> Expression Condition


%%

Main : tINT tMAIN tAO Programme tAF
            {printf("Fin Main\n");
            afficher();}
     ;

Programme : Programme Declaration tPV
          | Programme Assignation tPV
          | Programme tPRINT tPO tVAR tPF tPV 
                {printf("Print !\n");
                printASM(fdClair, fdCode, $4);}
          | Programme tIF tPO Condition tPF 
                {ifASM(fdClair, fdCode, $4);
                 ajouterIndent();}
            tAO Programme tAF 
                {enleverIndent();
                 bifASM(fdClair, fdCode);}
            IFsuite
          | Programme tWHILE 
                {dwhileASM(fdClair, fdCode);}
            tPO Condition tPF 
                {ajouterIndent();
                whileASM(fdClair, fdCode);}
            tAO Programme tAF 
                {enleverIndent();
                fwhileASM(fdClair, fdCode, $5);
                printf("WHILE\n");}
          |
          ;

IFsuite : tELSE 
                {ajouterIndent();
                elseASM(fdClair, fdCode);}
          tAO Programme tAF
                {enleverIndent();
                fifASM(fdClair, fdCode);
                printf("IF ELSE\n");}
        |
                {elseASM(fdClair, fdCode);
                fifASM(fdClair, fdCode);
                printf("FIN IF\n");}
        ;

Declaration : tCONST tINT Variable tEQ Expression
                {printf("declaration assignation constante\n");
                ajouter(1, 1, fdClair, fdCode, $5);
                }
            | tCONST tINT Variable
                {printf("declaration constante\n");
                ajouter(1, 0, fdClair, fdCode, 0);
                }
            | tINT Variable tEQ Expression
                {printf("declaration assignation\n");
                ajouter(0, 1, fdClair, fdCode, $4);
                afficher();}
            | tINT Variable
                {printf("declaration \n");
                ajouter(0, 0, fdClair, fdCode, 0);
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
                ecrireOperationASM(fdClair, fdCode, 1, $1, $3);}
            | Expression tMUL Expression 
                {printf("Multiplication\n");
                ecrireOperationASM(fdClair, fdCode, 2, $1, $3);}
           | Expression tSUB Expression 
                {printf("Soustraction\n");
                ecrireOperationASM(fdClair, fdCode, 3, $1, $3);}
           | Expression tDIV Expression 
                {printf("Division\n");
                ecrireOperationASM(fdClair, fdCode, 4, $1, $3);}
           | tPO Expression tPF 
                {printf("(Expr)\n");
                $$ = derniereTmp();}
           | tNB 
                {printf("Nombre !\n");
                nbASM(fdClair, fdCode, $1);
                $$ = derniereTmp();}
           | tVAR 
                {printf("Variable !\n");
                varASM(fdClair, fdCode, $1);
                $$ = derniereTmp();}
           ;

Assignation : tVAR tEQ Expression 
                {printf("assignation Var already declared\n");
                setInit($1);
                assignerASM(fdClair, fdCode, $1);}
            ;

Condition : Expression tIT Expression
                {$$ = 0;}
          | Expression tST Expression
                {$$ = 1;}
          | Expression tET Expression
                {$$ = 2;}
          | Expression tNE Expression
                {$$ = 3;}
          | Expression tIE Expression
                {$$ = 4;}
          | Expression tSE Expression
                {$$ = 5;}
          ;


%%


int yyerror(char*s) {
    printf("Erreur : %s\n", s);
}

int main() {
    fdClair = fopen("codeasm.s", "wr");
    fdCode = fopen("code.s", "wr");

    yyparse();

    reecriture(fdClair);

    fclose(fdCode); // rajouter une ligne vide à la fin ?
    fclose(fdClair);

    return 1;
}