yacc -d -v AG2.y
lex AL2.lex
gcc y.tab.c lex.yy.c -o ag
