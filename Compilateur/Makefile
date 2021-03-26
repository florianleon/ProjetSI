final: AL2.lex AG2.y y.tab.c lex.yy.c
    yacc -d -v AG2.y
    lex AL2.lex
    gcc y.tab.c lex.yy.c -o ag

yacc: AG2.y
    yacc -d -v AG2.y
    