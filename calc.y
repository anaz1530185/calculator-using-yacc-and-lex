%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
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

line    : E '\n'				         { $$ = $1; }
        | exit_cmd                          	     	 { exit(EXIT_SUCCESS); }
        ;
	
E	: T	                      		     	 { $$ = $1; }
    	| E '+' T	                             	 { $$ = $1 + $3; }
    	| E '-' T             		             	 { $$ = $1 - $3; }
    	;

T	: G		       	             	      	 { $$ = $1; }
	| T '*' G	                       	      	 { $$ = $1 * $3; }
 	| T '/' G        	                      	 { $$ = $1 / $3; }
 	| T '%' G		                      	 { $$ = $1 % $3; }
    	;

G	: term
   	| G '^' term			                { $$ = pow($1, $3); }
    	| '|' term  '|'					{ $$ = abs($2); }
	| '|' term1 '|'				        { $$ = abs($2); }
        ;

term    : INTEGER			                { $$ = $1; }
        | '('E')'			                { $$ = $2; }
        | '('T')'               	                { $$ = $2; }
        | '('G')'               	                { $$ = $2; }
        ;

term1	: INTEGER					{ $$ = $1; }
	| E						{ $$ = $1; }
	| T						{ $$ = $1; }
	| G						{ $$ = $1; }
%%


void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}
int main(void) {
    yyparse();
    return 0;
}
