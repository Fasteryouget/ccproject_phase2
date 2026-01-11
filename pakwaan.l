%{
#include "y.tab.h"
/* Define the variable here so it exists for the linker [cite: 1] */
int line_no = 1; 
%}

%option noyywrap

%%

\n              { line_no++; }
[ \t\r]+        { /* ignore whitespace */ }

"PakaaiShuru"   { return PakaaiShuru; }
"PuraHissa"     { return PuraHissa; }
"ChotaHissa"    { return ChotaHissa; }
"Nishaan"       { return Nishaan; }
"Tay"           { return Tay; }
"SahiHai"       { return SahiHai; }
"GhalatHai"     { return GhalatHai; }
"AgarHalat"     { return AgarHalat; }
"Warna"         { return Warna; }
"JabTakGhoom"   { return JabTakGhoom; }
"DawatPesh"     { return DawatPesh; }
"lohissalao"    { return lohissalao; }
"WapasiDe"      { return WapasiDe; }

"="             { return OP_ASSIGN; }
"+"             { return OP_PLUS; }
"-"             { return OP_MINUS; }
">"             { return OP_GT; }
"<"             { return OP_LT; }

"{"             { return LBRACE; }
"}"             { return RBRACE; }
";"             { return SEMICOLON; }
"("             { return LPAREN; }
")"             { return RPAREN; }

[0-9]+"."[0-9]+ { return NUMBER_FLOAT; }
[0-9]+          { return NUMBER_INT; }
\"[^\"]*\"      { return STRING; }
[A-Za-z_][A-Za-z0-9_]* { return IDENTIFIER; }

.               { printf("Line %d: Lexical Error -> %s\n", line_no, yytext); }

%%
