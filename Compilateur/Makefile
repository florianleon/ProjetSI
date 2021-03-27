3 : AG3.y AL2.lex symbol_table.c
	yacc -d -v AG3.y
	lex AL2.lex
	gcc y.tab.c lex.yy.c symbol_table.c -o ag
	./ag

2 : AG2.y AL2.lex symbol_table.c
	yacc -d -v AG2.y
	lex AL2.lex
	gcc y.tab.c lex.yy.c symbol_table.c -o ag

1 : AG1.y AL1.lex
	yacc -d -v AG1.y
	lex AL1.lex
	gcc y.tab.c lex.yy.c -o ag