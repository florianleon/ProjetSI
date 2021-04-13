code : AnalyseurGrammaticalC.y AnalyseurLexicalC.lex symbol_table_c.c code.c
	yacc -d -v AnalyseurGrammaticalC.y
	lex AnalyseurLexicalC.lex
	gcc y.tab.c lex.yy.c symbol_table_c.c -o ag
	./ag < code.c

free : AnalyseurGrammaticalC.y AnalyseurLexicalC.lex symbol_table_c.c
	yacc -d -v AnalyseurGrammaticalC.y
	lex AnalyseurLexicalC.lex
	gcc y.tab.c lex.yy.c symbol_table_c.c -o ag
	./ag


cleanPartiel:
	rm -f lex.yy.c y.tab.h y.tab.c y.output

clean:
	make cleanPartiel
	rm -f ag code.s codeasm.s
