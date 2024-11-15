%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define YYSTYPE double
int yylex(void);
void yyerror(char*);
%}

%token NUMBER_FLOAT NUMBER_INT
%right OP_IGUAL
%token EOL
%token PAR_ABRE PAR_CIERRA
%token RAIZ DOBLE TRIPLE
%token CMD_EXT
%token IDENTIFICADOR
%left OP_SUMA OP_RESTA
%left OP_MULT OP_DIV
%left OP_POTENCIA

%%

strt: strt stmt EOL { printf("= %lf\n", $2); }
    | strt EOL { printf("\n"); }
    | strt CMD_EXT { printf(">> Adios :O !\n"); exit(0); }
    |
;

stmt: IDENTIFICADOR OP_IGUAL expr  { $$ = $3; $1 = $3; }
    | expr                         { $$ = $1; }
;

expr: expr OP_SUMA term          { $$ = $1 + $3; }
    | expr OP_RESTA term         { $$ = $1 - $3; }
    | term                       { $$ = $1; }
;

term: term OP_MULT unary         { $$ = $1 * $3; }
    | term OP_DIV unary          { $$ = $1 / $3; }
    | unary                      { $$ = $1; }
;

unary: OP_RESTA unary            { $$ = $2 * -1; }
    | pow                        { $$ = $1; }
;

pow: factor OP_POTENCIA pow      { $$ = pow($1, $3); }
    | factor                     { $$ = $1; }
;

factor: IDENTIFICADOR              { $$ = $1; }
      | NUMBER_INT                 { $$ = $1; }
      | NUMBER_FLOAT               { $$ = $1; }
      | PAR_ABRE expr PAR_CIERRA   { $$ = ($2); }
      | RAIZ PAR_ABRE expr PAR_CIERRA { $$ = sqrt($3); }
      | DOBLE PAR_ABRE expr PAR_CIERRA { $$ = $3 + $3; }
      | TRIPLE PAR_ABRE expr PAR_CIERRA { $$ = 3 * $3; }
;

%%

void yyerror(char *s)
{
    fprintf(stderr, ">> %s\n", s);
}

int main()
{
    yyparse();
    return 0;
}
