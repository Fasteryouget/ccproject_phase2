%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

/* This tells the parser that line_no exists in the lexer file */
extern int line_no; 
extern char* yytext;

void yyerror(const char *s);
%}

%token PakaaiShuru PuraHissa ChotaHissa Nishaan Tay
%token SahiHai GhalatHai AgarHalat Warna JabTakGhoom DawatPesh
%token lohissalao WapasiDe
%token OP_ASSIGN OP_PLUS OP_MINUS OP_GT OP_LT
%token LBRACE RBRACE SEMICOLON LPAREN RPAREN
%token NUMBER_INT NUMBER_FLOAT STRING IDENTIFIER

/* Fix shift/reduce conflicts by defining operator precedence */
%left OP_PLUS OP_MINUS
%left OP_GT OP_LT

%start program

%%

program:
    PakaaiShuru LPAREN RPAREN LBRACE stmt_list RBRACE
    { printf("\nSyntax analysis successful\n"); }
    ;

stmt_list:
    stmt
    | stmt_list stmt
    ;

stmt:
    decl_stmt
    | assign_stmt
    | if_stmt
    | loop_stmt
    | output_stmt
    | input_stmt
    | return_stmt
    ;

decl_stmt:
    PuraHissa IDENTIFIER OP_ASSIGN expression SEMICOLON
    | ChotaHissa IDENTIFIER OP_ASSIGN expression SEMICOLON
    | Nishaan IDENTIFIER OP_ASSIGN STRING SEMICOLON
    | Tay IDENTIFIER OP_ASSIGN expression SEMICOLON
    ;

assign_stmt:
    IDENTIFIER OP_ASSIGN expression SEMICOLON
    ;

if_stmt:
    AgarHalat LPAREN expression RPAREN LBRACE stmt_list RBRACE
    | AgarHalat LPAREN expression RPAREN LBRACE stmt_list RBRACE Warna LBRACE stmt_list RBRACE
    ;

loop_stmt:
    JabTakGhoom LPAREN expression RPAREN LBRACE stmt_list RBRACE
    ;

output_stmt:
    DawatPesh LPAREN STRING RPAREN SEMICOLON
    | DawatPesh LPAREN IDENTIFIER RPAREN SEMICOLON
    ;

input_stmt:
    lohissalao OP_GT OP_GT IDENTIFIER SEMICOLON
    ;

return_stmt:
    WapasiDe expression SEMICOLON
    ;

expression:
    IDENTIFIER
    | NUMBER_INT
    | NUMBER_FLOAT
    | SahiHai
    | GhalatHai
    | expression OP_PLUS expression
    | expression OP_MINUS expression
    | expression OP_GT expression
    | expression OP_LT expression
    ;

%%

void yyerror(const char *s)
{
    /* Nature of error and line number requirement [cite: 216, 221] */
    fprintf(stderr, "Line %d: Syntax Error near '%s'\n", line_no, yytext);
}

int main(int argc, char *argv[])
{
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("File opening failed");
            return 1;
        }
    }
    yyparse();
    return 0;
}
