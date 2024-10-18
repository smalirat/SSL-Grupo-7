%{
#include <stdio.h>
#include <string.h>

// Definición de los tokens
typedef enum {
    PALABRA_RESERVADA,
    OPERADOR,
    IDENTIFICADOR,
    CARACTER_PUNTUACION,
    CONSTANTE,
    LITERAL_CADENA,
    ERROR
} TokenType;

// Prototipo de función para imprimir tokens
void print_token(TokenType type, const char* lexeme);
%}

%option noyywrap

// Definición de patrones léxicos

// Palabras reservadas
RESERVADAS   (funcion|raices|evaluar|mostrar|caso|doble|triple)

// Operadores
OPERADORES   (\+|\-|\*|\/|\^|<|>|==|!=)

// Caracteres de puntuación
PUNCTUACION  [\(\)\{\},;=]

// Identificadores
IDENTIFIER   [a-zA-Z_][a-zA-Z0-9_]*

// Constantes numéricas (enteros y decimales)
NUMBER       [0-9]+(\.[0-9]+)?

// Literal de cadena
STRING       \"([^\"\n]|(\\.))*\"

%%

{RESERVADAS}          { print_token(PALABRA_RESERVADA, yytext); }

{OPERADORES}          { print_token(OPERADOR, yytext); }

{PUNCTUACION}         { print_token(CARACTER_PUNTUACION, yytext); }

{IDENTIFIER}          { print_token(IDENTIFICADOR, yytext); }

{NUMBER}              { print_token(CONSTANTE, yytext); }

{STRING}              { print_token(LITERAL_CADENA, yytext); }

[ \t\n\r]+            ; // Ignorar espacios en blanco

.                     { print_token(ERROR, yytext); }

%%

void print_token(TokenType type, const char* lexeme) {
    switch(type) {
        case PALABRA_RESERVADA:
            printf("PALABRA_RESERVADA: %s\n", lexeme);
            break;
        case OPERADOR:
            printf("OPERADOR: %s\n", lexeme);
            break;
        case IDENTIFICADOR:
            printf("IDENTIFICADOR: %s\n", lexeme);
            break;
        case CARACTER_PUNTUACION:
            printf("CARACTER_PUNTUACION: %s\n", lexeme);
            break;
        case CONSTANTE:
            printf("CONSTANTE: %s\n", lexeme);
            break;
        case LITERAL_CADENA:
            printf("LITERAL_CADENA: %s\n", lexeme);
            break;
        case ERROR:
            printf("ERROR: %s\n", lexeme);
            break;
    }
}

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror(argv[1]);
            return 1;
        }
        yyin = file;
    }

    yylex();
    return 0;
}
