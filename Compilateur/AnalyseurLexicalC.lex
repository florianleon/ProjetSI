%{
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
%}

%%

"main()" return tMAIN;

"int" return tINT;
"const" return tCONST;
"void" return tVOID;
"return" return tRET;

"printf" return tPRINT;
"if" return tIF;
"else" return tELSE;
"while" return tWHILE;

\{ return tAO;
\} return tAF;
"," return tV;
";" return tPV;

"+" return tADD;
"-" return tSUB;
"*" return tMUL;
"/" return tDIV;
"=" return tEQ;
"(" return tPO;
")" return tPF;

"==" return tET;
"!=" return tNE;
">=" return tSE;
"<=" return tIE;
">" return tST;
"<" return tIT;

"&" return tESP;

[0-9]+ {yylval.nombre = atoi(yytext); return tNB;}
([0-9]*[.])?[0-9]+([eE][-+]?\d+)? return tEXP;
[a-zA-Z][a-zA-Z0-9_]* {yylval.variable = strdup(yytext); return tVAR;}

[ \t\n]+ ;

%%

int yywrap() {
    return 1;
}

