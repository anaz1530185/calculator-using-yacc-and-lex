%{
    #include <stdio.h>
    #include <stdlib.h>
    int yylex(void);
    void yyerror(char *);
%}
%token INTEGER
%token exit_cmd
%%
program : program line				{ printf("result=%d\n", $2); } 
	| line	 		                { printf("result=%d\n", $1); }
	| exit_cmd				{ exit(EXIT_SUCCESS); }
	;

line    : expr '\n'				{ $$ = $1; }
        | exit_cmd                              { exit(EXIT_SUCCESS); }
        ;
	
expr    : term                                  { $$ = $1; }
        | expr '+' factor                       { $$ = $1 + $3; }
        | expr '-' factor                       { $$ = $1 - $3; }
        | factor				{ $$ = $1; }
        ;

factor  : term		       	                { $$ = $1; }
        | factor '*' term                       { $$ = $1 * $3; }
        | factor '/' term                       { $$ = $1 / $3; }
        | factor '%' term	                { $$ = $1 % $3; }
        ;

term    : INTEGER			                { $$ = $1; }
        | '('expr')'		                { $$ = $2; }
        | '('factor')'                          { $$ = $2; }
        ;
%%
void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}
int main(void) {
    yyparse();
    return 0;
}
