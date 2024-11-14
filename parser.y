%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void yyerror(const char *s);
int yylex(void);
%}

%union {
    char* str;
    double dblval;
}

%token <str> PALABRA_RESERVADA
%token <str> IDENTIFICADOR
%token <dblval> CONSTANTE
%token <str> LITERAL_CADENA
%token OP_SUMA OP_RESTA OP_MULT OP_DIV OP_POTENCIA
%token OP_MENOR OP_MAYOR OP_IGUAL OP_DISTINTO
%token PUNTO_COMA COMA ASIGNACION
%token PAR_ABRE PAR_CIERRA LLAVE_ABRE LLAVE_CIERRA

%type <dblval> expresion

// Declaración de precedencias
%left OP_SUMA OP_RESTA
%left OP_MULT OP_DIV
%right OP_POTENCIA

%%

// Definición de la gramática

program:
    | program statement
    ;

statement:
    PALABRA_RESERVADA IDENTIFICADOR PAR_ABRE PAR_CIERRA PUNTO_COMA
    | IDENTIFICADOR ASIGNACION expresion PUNTO_COMA
    | IDENTIFICADOR PUNTO_COMA
    ;

expresion:
    CONSTANTE { $$ = $1; } // Asignar el valor de la constante
    | IDENTIFICADOR { $$ = 1.0; } // Asignar un valor fijo a IDENTIFICADOR
    | expresion OP_SUMA expresion { $$ = $1 + $3; }
    | expresion OP_RESTA expresion { $$ = $1 - $3; }
    | expresion OP_MULT expresion { $$ = $1 * $3; }
    | expresion OP_DIV expresion {
        if ($3 != 0)
            $$ = $1 / $3;
        else
            yyerror("Error: División por cero");
    }
    | PAR_ABRE expresion PAR_CIERRA { $$ = $2; } // Evaluar la expresión entre paréntesis
    ;

%%

// Manejo de errores
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}