%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%

[ ] ;
[\n]+ {return tNL;}
[0-9]+ {yylval.adresse = atoi(yytext); return tNB;}
[ABC] {yylval.codeVar = strdup(yytext); return tCV;}

[^ ] {printf("ERROR LEX : CARACTERE INCONNUE\n");}

%%

int yywrap() {
    return 1;
}

