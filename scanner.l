%{
#include <stdlib.h>
#include <stdio.h>
#include "parser.tab.h"
extern YYSTYPE yylval;
void yyerror(char*);
%}

OP_SUMA \+
OP_RESTA \-
OP_MULT \*
OP_IGUAL =
OP_POTENCIA \^
OP_DIV \/



PAR_ABRE \(
PAR_CIERRA \)

IDENTIFICADOR [a-zA-Z]([a-zA-Z]|[0-9])*


%%
{OP_SUMA} {
    printf("OP_SUMA  ");
	return OP_SUMA;
}
{OP_RESTA} {
    printf("OP_RESTA  ");
	return OP_RESTA;
}
{OP_MULT} {
    printf("OP_MULT  ");
	return OP_MULT;
}
{OP_DIV} {
    printf("OP_DIV  ");
	return OP_DIV;
}
{OP_POTENCIA} {
    printf("OP_POTENCIA  ");
	return OP_POTENCIA;
}
{OP_IGUAL} {
    printf("OP_IGUAL  ");
	return OP_IGUAL;
}
{PAR_ABRE} {
    printf("PAR_ABRE  ");
	return PAR_ABRE;
}
{PAR_CIERRA} {
    printf("PAR_CIERRA  ");
	return PAR_CIERRA;
}
"raiz" {
    printf("PALABRA_RESERVADA  ");
	return RAIZ;
}
"doble" {
    printf("PALABRA_RESERVADA  ");
	return DOBLE;
}
"triple" {
    printf("PALABRA_RESERVADA  ");
	return TRIPLE;
}



[0-9]+ {
    printf("NUMBER_INT  ");
	sscanf(yytext, "%lf", &yylval);
	return NUMBER_INT;
}

[0-9]+(\.?[0-9]*e?-?[0-9]*)?  {
	sscanf(yytext, "%lf", &yylval);
	printf("NUMBER_FLOAT  ");
	return NUMBER_FLOAT;
}

"quit"|"exit" {return CMD_EXT;}

{IDENTIFICADOR} {
printf("IDENTIFICADOR  ");

return IDENTIFICADOR;
}
\n {
	printf("\n <<EOL>> \n");
	return EOL;
}

[ \t]+ {}


. {yyerror("ERROR: Unrecognized input!");}

%%

int yywrap()
{
	return 1;
}