%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%

"main()" return tMAIN;
\{ return tAO;
\} return tAF;
"int" return tINT;
"const" return tCONST;
"+" return tADD;
"-" return tSUB;
"*" return tMUL;
"/" return tDIV;
"=" return tEQ;
"(" return tPO;
")" return tPF;
[ \t\n]+ ;
"," return tV;
";" return tPV;
"&" return tESP;

"==" return tET;
"!=" return tNE;
">=" return tSE;
"<=" return tIE;
">" return tST;
"<" return tIT;
"printf" return tPRINT;
"if" return tIF;
"else" return tELSE;
"while" return tWHILE;
[0-9]+ {yylval.nombre = atoi(yytext); return tNB;}
([0-9]*[.])?[0-9]+([eE][-+]?\d+)? return tEXP;
[a-zA-Z][a-zA-Z0-9_]* {yylval.variable = strdup(yytext); return tVAR;}

%%

int yywrap() {
    return 1;
}

