%{
#include <stdio.h>
#include <stdlib.h>
%}

/* Definición de tokens */
%token IDENTIFICADOR
%token CONSTANTE
%token LITERAL_CADENA
%token VAR
%token SI
%token SINO
%token IMPRIMIR
%token RAICES
%token EVALUAR
%token DOBLE
%token TRIPLE
%token FUNCION
%token MOSTRAR
%token CASO

%token OP_SUMA OP_RESTA OP_MULT OP_DIV OP_POTENCIA OP_MENOR OP_MAYOR OP_IGUAL OP_DISTINTO

%token PUNTO_COMA COMA ASIGNACION
%token PAR_ABRE PAR_CIERRA LLAVE_ABRE LLAVE_CIERRA

%start Programa

%%

/* Reglas de la gramática */
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

/* Código en C para funciones de manejo de errores y main */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    return yyparse();
}
