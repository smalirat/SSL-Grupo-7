%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror (char const *s) {}

%}

%token IDENTIFICADOR CONSTANTE LITERAL_CADENA VAR SI SINO IMPRIMIR RAICES EVALUAR DOBLE TRIPLE FUNCION MOSTRAR CASO
%token OP_SUMA OP_RESTA OP_MULT OP_DIV OP_POTENCIA OP_MENOR OP_MAYOR OP_IGUAL OP_DISTINTO
%token PUNTO_COMA COMA ASIGNACION PAR_ABRE PAR_CIERRA LLAVE_ABRE LLAVE_CIERRA

%start Programa

%left OP_SUMA OP_RESTA
%left OP_MULT OP_DIV
%right OP_POTENCIA

%%
Programa:
    ListaFunciones
;

ListaFunciones:
    Funcion
    | ListaFunciones Funcion
;

Funcion:
    FUNCION IDENTIFICADOR PAR_ABRE ListaParametros PAR_CIERRA LLAVE_ABRE ListaDeclaraciones ListaExpresiones LLAVE_CIERRA
;

ListaParametros:
    IDENTIFICADOR
    | ListaParametros COMA IDENTIFICADOR
;

ListaDeclaraciones:
    Declaracion
    | ListaDeclaraciones Declaracion
;

Declaracion:
    DeclaracionRaices
    | Asignacion
;

DeclaracionRaices:
    RAICES TipoRaiz LLAVE_ABRE Expresion LLAVE_CIERRA
;

TipoRaiz:
    DOBLE
    | TRIPLE
;

Asignacion:
    IDENTIFICADOR ASIGNACION Expresion PUNTO_COMA
;

ListaExpresiones:
    Expresion PUNTO_COMA
    | ListaExpresiones Expresion PUNTO_COMA
    | Mostrar
    | Caso
;

Expresion:
    Expresion OP_SUMA Expresion
    | Expresion OP_RESTA Expresion
    | Expresion OP_MULT Expresion
    | Expresion OP_DIV Expresion
    | Expresion OP_POTENCIA Expresion
    | PAR_ABRE Expresion PAR_CIERRA
    | CONSTANTE
    | IDENTIFICADOR
;

Mostrar:
    MOSTRAR PAR_ABRE LiteralCadena PAR_CIERRA PUNTO_COMA
;

Caso:
    CASO PAR_ABRE Expresion PAR_CIERRA LLAVE_ABRE ListaExpresiones LLAVE_CIERRA
;

LiteralCadena:
    LITERAL_CADENA
;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}
