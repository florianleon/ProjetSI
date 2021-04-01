%%
"main()" printf("tMAIN\n");
\{ printf("tAO\n");
\} printf("tAF\n");
"int" printf("tINT\n");
"const" printf("tCONST\n");
"+" printf("tADD\n");
"-" printf("tSUB\n");
"*" printf("tMUL\n");
"/" printf("tDIV\n");
"=" printf("tEQ\n");
"(" printf("tPO\n");
")" printf("tPF\n");
[ ] printf("tESP\n");
[\t] printf("tTAB\n");
"," printf("tV\n");
"\n" printf("tEOL\n");
";" printf("tPV\n");
"printf" printf("tPRINT\n");
[0-9]+ printf("tNB : %d \n", atoi(yytext));
([0-9]*[.])?[0-9]+([eE][-+]?\d+)? printf("tEXP\n");
[a-zA-Z][a-zA-Z0-9_]* printf("tVAR : %s \n", yytext);

%%

int yywrap() {
    return 1;
}

int main() {
    yylex();
    return 0;
}
