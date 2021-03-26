%{
#include <stdlib.h>
#include <stdio.h>
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

%type<nombre> Expression

%%

Main : tINT tMAIN tAO Programme tAF 
            {printf("Fin Main\n");}
     ;

Programme : Declaration tPV Programme
          | Instruction tPV Programme
          | tPRINT tPO tVAR tPF tPV Programme
                {printf("Print !\n");}
          |
          ;


Declaration : tCONST tINT Variable tEQ Expression
                {printf("declaration assignation constante\n");}
            | tCONST tINT Variable
                {printf("declaration constante\n");}
            | tINT Variable tEQ Expression
                {printf("declaration assignation\n");}
            | tINT Variable
                {printf("declaration \n");}
            ;

Variable : tVAR tV Variable 
            {printf("declaration Var+\n");}
         | tVAR 
            {printf("declaration Var\n");}
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
                {printf("assignation Var,\n");}
            ;


%%
int yyerror(char*s) {
    printf("Erreur : %s\n", s);
}
int main() {
    yyparse();
    return 1;
}


