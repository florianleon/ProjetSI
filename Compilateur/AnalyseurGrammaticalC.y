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

%token tINT 
%token tCONST
%token tVOID
%token tRET

%token tPRINT 
%token tIF
%token tELSE
%token tWHILE

%token tAO 
%token tAF
%token tV 
%token tPV

%token tMUL
%left tADD 
%left tSUB 
%left tDIV
%right tEQ 
%token tPO 
%token tPF 

%token tET
%token tNE
%token tSE
%token tIE
%token tST
%token tIT

%token tESP
     /* %token tAST pareil que tMUL */


%token<nombre> tNB 
%token<nombre> tEXP 
%token<variable> tVAR 



%type<nombre> Expression Condition


%%

S : S DecFonction 
  | S Main
  | 
  ;

DecFonction : tINT tVAR tPO DecArguments tPF 
                    {ajouterFct(fdClair, fdCode, $2, 1);}
              tAO Programme tAF
                    {printf("Fin Fct\n");
                    maxVariableMAJ();
                    jumpMaxVariable();}
            | tVOID tVAR tPO DecArguments tPF 
                    {ajouterFct(fdClair, fdCode, $2, 0);}
              tAO Programme tAF
                    {maxVariableMAJ();
                    jumpMaxVariable();}
            ;

DecArguments : tINT tVAR tV DecArguments
                    {ajouterListeArg($2);}
             | tINT tVAR
                    {ajouterListeArg($2);}
             |
             ;

Main : tINT tMAIN tAO Programme tAF                             /* MAIN */
            {printf("Fin Main\n");
            afficher();
            maxVariableMAJ();
            jumpMaxVariable();}
     ;

Programme : Programme Declaration tPV                           /* ASSIGNATION */
          | Programme Assignation tPV                           /* DECLARATION */
          | Programme tPRINT tPO tVAR tPF tPV 
                {printf("Print !\n");
                printASM(fdClair, fdCode, $4);}
          | Programme tIF tPO Condition tPF                     /* IF */
                {ifASM(fdClair, fdCode, $4);
                 ajouterIndent();}
            tAO Programme tAF 
                {enleverIndent();
                 bifASM(fdClair, fdCode);}
            IFsuite
          | Programme tWHILE                                    /* WHILE */
                {dwhileASM(fdClair, fdCode);}
            tPO Condition tPF 
                {ajouterIndent();
                whileASM(fdClair, fdCode);}
            tAO Programme tAF 
                {enleverIndent();
                fwhileASM(fdClair, fdCode, $5);
                printf("WHILE\n");}
          | Programme AppFonction tPV                           /* APPELLE FONCTION */
          | tRET Variable tPV                                   /* RETURN */
          |
          ;

AppFonction : tVAR tPO AppArguments {printf("ici\n");} tPF
                  {jumpFct(fdClair, fdCode, $1);}
            ;

AppArguments : Expression tV AppArguments
             | Expression
             | 
             ;


IFsuite : tELSE                                                 /* IF-ELSE */
                {ajouterIndent();
                elseASM(fdClair, fdCode);}
          tAO Programme tAF
                {enleverIndent();
                fifASM(fdClair, fdCode);
                printf("IF ELSE\n");}
        |                                                       /* IF */
                {elseASM(fdClair, fdCode);
                fifASM(fdClair, fdCode);
                printf("FIN IF\n");}
        ;

Declaration : tCONST tINT Variable tEQ Expression               /* CONST INT = */
                {printf("declaration assignation constante\n");
                ajouter(1, 1, fdClair, fdCode, $5);
                }
            | tCONST tINT Variable                              /* CONT INT */
                {printf("declaration constante\n");
                ajouter(1, 0, fdClair, fdCode, 0);
                }
            | tINT Variable tEQ Expression                      /* INT = */
                {printf("declaration assignation\n");
                ajouter(0, 1, fdClair, fdCode, $4);
                afficher();}
            | tINT Variable                                     /* INT */
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


Expression : Expression tADD Expression                         /* ADD */
                {printf("Addition\n");
                ecrireOperationASM(fdClair, fdCode, 1, $1, $3);}
            | Expression tMUL Expression                        /* MUL */
                {printf("Multiplication\n");
                ecrireOperationASM(fdClair, fdCode, 2, $1, $3);}
           | Expression tSUB Expression                         /* SUB */
                {printf("Soustraction\n");
                ecrireOperationASM(fdClair, fdCode, 3, $1, $3);}
           | Expression tDIV Expression                         /* DIV */
                {printf("Division\n");
                ecrireOperationASM(fdClair, fdCode, 4, $1, $3);}
           | tPO Expression tPF                                 /* ( ) */
                {printf("(Expr)\n");
                $$ = derniereTmp();}
           | tNB                                                /* NB */
                {printf("Nombre !\n");
                nbASM(fdClair, fdCode, $1);
                $$ = derniereTmp();}
           | tVAR                                               /* VAR */
                {printf("Variable !\n");
                varASM(fdClair, fdCode, $1);
                $$ = derniereTmp();}
           ;

Assignation : tVAR tEQ Expression                               /* VAR = EXPR */
                {printf("assignation Var already declared\n");
                setInit($1);
                assignerASM(fdClair, fdCode, $1);}
            | tVAR tEQ AppFonction                              /* VAR = FCT */
                {printf("assignation by fct\n");
                setInit($1);
                assignerASM(fdClair, fdCode, $1);}
            ;

Condition : Expression tIT Expression                           /* < */
                {$$ = 0;}
          | Expression tST Expression                           /* > */
                {$$ = 1;}
          | Expression tET Expression                           /* == */
                {$$ = 2;}
          | Expression tNE Expression                           /* != */
                {$$ = 3;}
          | Expression tIE Expression                           /* <= */
                {$$ = 4;}
          | Expression tSE Expression                           /* >= */
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