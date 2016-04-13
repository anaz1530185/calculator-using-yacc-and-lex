# calculator-using-yacc-and-lex
run in terminal using following commands:
calc.l --> lex code..all the regex are defined here
calc.y --> yacc code..all the tokens are defined here along with CFG
lex.yy.c --> generated when we compile our lex file(calc.l) ..after command -(lex calc.l)
y.tab.h  and y.tab.c -->generated when we compile our yacc file (calc.y)... after command - (yacc -d calc.y)
----------------------------------------
once you have saved the files
run the following commands in terminal:
-> yacc -d calc.y
-> lex calc.l
-> gcc lex.yy.c y.tab.c -o calc -lfl
-> ./calc
then enter your expression: eg- 1-1*(2+3)*4/1
after that press 'Enter' 
output eg:result=(-19)
if you want to exit: enter the command -> ' exit_cmd ' or 'exit'
