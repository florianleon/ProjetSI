	AFC 255 7
	COP 0 255
	AFC 255 8
	COP 1 255
	COP 255 0
	COP 254 1
	EQU 255 254
	JMF else0
	AFC 255 5
	COP 2 255
	JMP fif1

else0
	AFC 255 7
	COP 2 255

fif1



dloop2
	COP 255 0
	AFC 254 10
	JMP cloop3

loop4

dloop5
	COP 253 0
	AFC 252 11
	JMP cloop6

loop7
	COP 251 1
	AFC 250 0
	SUP 251 250
	JMF else8
	AFC 251 6
	COP 2 251
	PRI 2
	PRI 1
	JMP fif9

else8

fif9


	JMP dloop5

cloop6
	INF 253 252
	JMF floop10
	JMP loop7

floop10


	JMP dloop2

cloop3
	INF 255 254
	JMF floop11
	JMP loop4

floop11


	AFC 255 3
	COP 2 255
