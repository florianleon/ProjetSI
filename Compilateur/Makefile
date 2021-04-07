analyseur : AnalyseurGrammaticalC.y AnalyseurLexicalC.lex symbol_table_c.c
	yacc -d -v AnalyseurGrammaticalC.y
	lex AnalyseurLexicalC.lex
	gcc y.tab.c lex.yy.c symbol_table_c.c -o ag
	./ag

interpreteur : AnalyseurGrammaticalASM.y AnalyseurLexicalASM.lex code.s symbol_table_asm.c
	yacc -d -v AnalyseurGrammaticalASM.y
	lex AnalyseurLexicalASM.lex
	gcc y.tab.c lex.yy.c symbol_table_asm.c -o interp
	./interp < code.s

final : AnalyseurGrammaticalC.y AnalyseurLexicalC.lex symbol_table_c.c code.c AnalyseurGrammaticalASM.y AnalyseurLexicalASM.lex symbol_table_asm.c
	yacc -d -v AnalyseurGrammaticalC.y
	lex AnalyseurLexicalC.lex
	gcc y.tab.c lex.yy.c symbol_table_c.c -o ag
	./ag < code.c
	yacc -d -v AnalyseurGrammaticalASM.y
	lex AnalyseurLexicalASM.lex
	gcc y.tab.c lex.yy.c symbol_table_asm.c -o interp
	./interp < code.s

