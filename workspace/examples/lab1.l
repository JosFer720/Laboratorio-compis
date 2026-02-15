%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int codeLine = 1;
int position = 1;

void print_token(const char* type, const char* value) {
    printf("Token(%s, '%s', line=%d, pos=%d)\n",
           type, value, codeLine, position);
}
%}

DIGIT [0-9]
LETTER [a-zA-Z_]
ID {LETTER}({LETTER}|{DIGIT})*
INT {DIGIT}+
FLOAT {DIGIT}+"."{DIGIT}+
SCI {DIGIT}+(\.{DIGIT}+)?[eE][+-]?{DIGIT}+
HEX 0[xX][0-9a-fA-F]+

WS [ \t\r]+

%%

"if" { print_token("IF", yytext); position += yyleng; }
"else" { print_token("ELSE", yytext); position += yyleng; }
"return" { print_token("RETURN", yytext); position += yyleng; }
"function" { print_token("FUNCTION", yytext); position += yyleng; }

{HEX} { print_token("HEX", yytext); position += yyleng; }
{SCI} { print_token("SCIENTIFIC", yytext); position += yyleng; }
{FLOAT} { print_token("FLOAT", yytext); position += yyleng; }
{INT} { print_token("INTEGER", yytext); position += yyleng; }

"=="|"!="|"<="|">="|"<"|">" { print_token("RELATIONAL_OP", yytext); position += yyleng; }
"&&"|"||"|"!" { print_token("LOGICAL_OP", yytext); position += yyleng; }
"+"|"-"|"*"|"/" { print_token("ARITHMETIC_OP", yytext); position += yyleng; }

"(" { print_token("LPAREN", yytext); position += yyleng; }
")" { print_token("RPAREN", yytext); position += yyleng; }
"{" { print_token("LBRACE", yytext); position += yyleng; }
"}" { print_token("RBRACE", yytext); position += yyleng; }
";" { print_token("SEMICOLON", yytext); position += yyleng; }
"," { print_token("COMMA", yytext); position += yyleng; }
":" { print_token("COLON", yytext); position += yyleng; }

"//".* { position += yyleng; }
"/*"([^*]|\n)*"*/" { position += yyleng; }

\"([^\\\"\n]|\\[nt\"\\])*\" { print_token("STRING", yytext); position += yyleng; }

{ID} { print_token("IDENTIFIER", yytext); position += yyleng; }

{WS} { position += yyleng; }

\n { codeLine++; position = 1; }

. { printf("ERROR: '%s' at line=%d pos=%d\n", yytext, codeLine, position); position++; }

%%

int yywrap() { return 1; }

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Cannot open file: %s\n", argv[1]);
            return 1;
        }
    }

    yylex();

    if (argc > 1) fclose(yyin);

    return 0;
}