%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"  // Incluye el archivo generado por Bison para usar sus tokens y yylval


%}

%option noyywrap

/* Definición de patrones léxicos */

/* Palabras reservadas */

PALABRA_RESERVADA (funcion|raices|evaluar|mostrar|caso|doble|triple)

/* Operadores */
OP_SUMA \+
OP_RESTA \-
OP_MULT \*
OP_DIV \/
OP_POTENCIA \^
OP_MENOR <
OP_MAYOR >
OP_IGUAL ==
OP_DISTINTO !=

/* Caracteres de puntuación */
PUNTO_COMA ;
COMA ,
ASIGNACION =
PAR_ABRE \(
PAR_CIERRA \)
LLAVE_ABRE \{
LLAVE_CIERRA \}

/* Identificadores*/
IDENTIFICADOR [a-zA-Z_][a-zA-Z0-9_]*

/* Constantes numéricas (enteros y decimales) */
NUMBER [0-9]+(\.[0-9]+)?

/* Literal de cadena */
STRING \"([^\"\n]|(\\.))*\"

%%

{PALABRA_RESERVADA}    { return PALABRA_RESERVADA; }
{OP_SUMA}       { return OP_SUMA; }
{OP_RESTA}      { return OP_RESTA; }
{OP_MULT}       { return OP_MULT; }
{OP_DIV}        { return OP_DIV; }
{OP_POTENCIA}   { return OP_POTENCIA; }
{OP_MENOR}      { return OP_MENOR; }
{OP_MAYOR}      { return OP_MAYOR; }
{OP_IGUAL}      { return OP_IGUAL; }
{OP_DISTINTO}   { return OP_DISTINTO; }

{PUNTO_COMA}    { return PUNTO_COMA; }
{COMA}          { return COMA; }
{ASIGNACION}    { return ASIGNACION; }
{PAR_ABRE}      { return PAR_ABRE; }
{PAR_CIERRA}    { return PAR_CIERRA; }
{LLAVE_ABRE}    { return LLAVE_ABRE; }
{LLAVE_CIERRA}  { return LLAVE_CIERRA; }

{IDENTIFICADOR} { yylval.str = strdup(yytext); return IDENTIFICADOR; }
{NUMBER}        { yylval.dblval = atof(yytext); return CONSTANTE; }
{STRING}        { yylval.str = strdup(yytext); return LITERAL_CADENA; }

[ \t\n\r]+   ;  // Ignorar espacios en blanco y saltos de línea


%%
