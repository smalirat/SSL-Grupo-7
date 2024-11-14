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

{PALABRA_RESERVADA}    { printf("TOKEN: PALABRA_RESERVADA (%s)\n", yytext); return PALABRA_RESERVADA; }


{OP_SUMA}              { printf("TOKEN: OP_SUMA\n"); return OP_SUMA; }
{OP_RESTA}             { printf("TOKEN: OP_RESTA\n"); return OP_RESTA; }
{OP_MULT}              { printf("TOKEN: OP_MULT\n"); return OP_MULT; }
{OP_DIV}               { printf("TOKEN: OP_DIV\n"); return OP_DIV; }
{OP_POTENCIA}          { printf("TOKEN: OP_POTENCIA\n"); return OP_POTENCIA; }
{OP_MENOR}             { printf("TOKEN: OP_MENOR\n"); return OP_MENOR; }
{OP_MAYOR}             { printf("TOKEN: OP_MAYOR\n"); return OP_MAYOR; }
{OP_IGUAL}             { printf("TOKEN: OP_IGUAL\n"); return OP_IGUAL; }
{OP_DISTINTO}          { printf("TOKEN: OP_DISTINTO\n"); return OP_DISTINTO; }

{PUNTO_COMA}           { printf("TOKEN: PUNTO_COMA\n"); return PUNTO_COMA; }
{COMA}                 { printf("TOKEN: COMA\n"); return COMA; }
{ASIGNACION}           { printf("TOKEN: ASIGNACION\n"); return ASIGNACION; }
{PAR_ABRE}             { printf("TOKEN: PAR_ABRE\n"); return PAR_ABRE; }
{PAR_CIERRA}           { printf("TOKEN: PAR_CIERRA\n"); return PAR_CIERRA; }
{LLAVE_ABRE}           { printf("TOKEN: LLAVE_ABRE\n"); return LLAVE_ABRE; }
{LLAVE_CIERRA}         { printf("TOKEN: LLAVE_CIERRA\n"); return LLAVE_CIERRA; }

{IDENTIFICADOR}        { printf("TOKEN: IDENTIFICADOR (%s)\n", yytext); yylval.str = strdup(yytext); return IDENTIFICADOR; }
{NUMBER}               { printf("TOKEN: CONSTANTE (%s)\n", yytext); yylval.dblval = atof(yytext); return CONSTANTE; }
{STRING}               { printf("TOKEN: LITERAL_CADENA (%s)\n", yytext); yylval.str = strdup(yytext); return LITERAL_CADENA; }

[ \t\n\r]+             ;  // Ignorar espacios en blanco y saltos de línea

%%


