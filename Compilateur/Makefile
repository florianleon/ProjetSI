analyseur : AnalyseurGrammatical.y AnalyseurLexical.lex symbol_table.c
	yacc -d -v AnalyseurGrammatical.y
	lex AnalyseurLexical.lex
	gcc y.tab.c lex.yy.c symbol_table.c -o ag
	./ag
