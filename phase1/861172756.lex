DIGIT [0-9]
LETTER [a-z]|[A-Z]
NUMBER (\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)
ADD "+"
SUB -
MULT "*"
DIV "/"
MOD "%"
L_PAREN "("
R_PAREN ")"
L_SQUARE_BRACKET "["
R_SQUARE_BRACKET "]"
EQUAL =
LT <
GT >
LTE "<="
GTE ">="
AND "and"
OR "or"
NOT "not"
ASSIGN ":="
SEMICOLON ;
COLON :
COMMA ,
DOT "."

SPACE " "
NEWLINE "\n"
TABS "\t"
FUNCTION "function"
BEGINLOOP "beginloop"
ENDLOOP "endloop"
BEGIN_PARAMS "beginparams"
END_PARAMS "endparams"
BEGIN_LOCALS "beginlocals"
END_LOCALS "endlocals"
INTEGER "integer"
BEGIN_BODY "beginbody"
END_BODY "endbody"
ARRAY "array"

OF "of"
IF "if"
THEN "then"
ELSE "else"
ENDIF "endif"
DO "do"
WHILE "while"
CONTINUE "continue"
RETURN "return"

TRUE "true"
FALSE "false"

READ "read"
WRITE "write"

IDENT {LETTER}({LETTER}|{DIGIT}|_)*({LETTER}|{DIGIT})|{LETTER}

COMMENT ##.*


ERROR2 {IDENT}_+
ERROR3 {DIGIT}+{IDENT}|_+{IDENT}|_+{IDENT}_+
OTHER .


%{
#include <unistd.h>

int currLine = 1;
int currPos = 1;

%}

%%
{NUMBER}        	{printf("NUMBER\t%s\n"		, yytext); currPos += yyleng;}
{ADD}			{printf("PLUS\n"			); currPos += yyleng;}
{SUB}			{printf("MINUS\n"			); currPos += yyleng;}
{MULT}			{printf("MULT\n"			); currPos += yyleng;}
{DIV}			{printf("DIV\n"				); currPos += yyleng;}
{MOD}			{printf("MOD\n"				); currPos += yyleng;}
{L_PAREN}		{printf("L_PAREN\n"			); currPos += yyleng;}
{R_PAREN}		{printf("R_PAREN"			); currPos += yyleng;}
{L_SQUARE_BRACKET} 	{printf("L_SQUARE_BRACKET\n"		); currPos += yyleng;}
{R_SQUARE_BRACKET} 	{printf("R_SQUARE_BRACKET\n"		); currPos += yyleng;}
{EQUAL}			{printf("EQUAL\n"			); currPos += yyleng;}
{LT}			{printf("LT\n"				); currPos += yyleng;}
{GT} 			{printf("GT\n"				); currPos += yyleng;}
{LTE}			{printf("LTE\n"				); currPos += yyleng;}
{GTE}			{printf("GTE\n"				); currPos += yyleng;}
{AND} 			{printf("AND\n"				); currPos += yyleng;}
{OR} 			{printf("OR\n"				); currPos += yyleng;}
{NOT} 			{printf("NOT\n"				); currPos += yyleng;}
{ASSIGN}		{printf("ASSIGN\n"			); currPos += yyleng;}
{SEMICOLON}		{printf("SEMICOLON\n"			); currPos += yyleng;}
{COLON}			{printf("COLON\n"			); currPos += yyleng;}
{COMMA} 		{printf("COMMA\n"			); currPos += yyleng;}
{DOT}			{printf("DOT\n"				); currPos += yyleng;}

{NEWLINE}		{currLine++; currPos = 1;}
{TABS}			{currPos += yyleng;}
{SPACE}			{currPos += yyleng;}
{FUNCTION}		{printf("FUNCTION\n"			); currPos += yyleng;}
{BEGINLOOP} 		{printf("BEGINLOOP\n"			); currPos += yyleng;}
{ENDLOOP} 		{printf("ENDLOOP\n"			); currPos += yyleng;}
{BEGIN_PARAMS}		{printf("BEGIN_PARAMS\n"		); currPos += yyleng;}
{END_PARAMS}		{printf("END_PARAMSt\n"			); currPos += yyleng;}
{BEGIN_LOCALS}		{printf("BEGIN_LOCALS\n"		); currPos += yyleng;}
{END_LOCALS}		{printf("END_LOCALS\n"			); currPos += yyleng;}
{INTEGER}		{printf("INTEGER\n"			); currPos += yyleng;}
{BEGIN_BODY}		{printf("BEGIN_BODY\n"			); currPos += yyleng;}
{END_BODY}		{printf("END_BODY\n"			); currPos += yyleng;}
{ARRAY} 		{printf("ARRAY\n"			); currPos += yyleng;}

{OF} 			{printf("OF\n"				); currPos += yyleng;}
{IF}			{printf("IF\n"				); currPos += yyleng;}
{THEN}			{printf("THEN\n"			); currPos += yyleng;}
{ELSE} 			{printf("ELSE\n"			); currPos += yyleng;}
{ENDIF}			{printf("END_IF\n"			); currPos += yyleng;}
{DO} 			{printf("DO\n"				); currPos += yyleng;}
{WHILE} 		{printf("WHILE\n"			); currPos += yyleng;}
{CONTINUE} 		{printf("CONTINUE\\n"			); currPos += yyleng;}
{RETURN}		{printf("RETURN\n"			); currPos += yyleng;}


{TRUE} 			{printf("TRUE\n"			); currPos += yyleng;}
{FALSE} 		{printf("FALSE\n"			); currPos += yyleng;}

{READ}			{printf("READ\n"			); currPos += yyleng;}
{WRITE}			{printf("WRITE\n"			); currPos += yyleng;}

{IDENT}			{printf("IDENT\t%s\n"		, yytext); currPos += yyleng;}

{COMMENT} 		{}


{ERROR2}		{printf("Error at line %d, column %d: identifier cannot end with an underscore \"%s\"\n", currLine, currPos, yytext); exit(0);}
{ERROR3}		{printf("Error at line %d, column %d: identifier must start with a letter \"%s\"\n", currLine, currPos, yytext); exit(0);}
{OTHER}			{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
%%

main(int args, char *argv[])
{
	if(args > 1) {
		yyin = fopen(argv[1], "r");
		if(yyin == NULL) {
			yyin = stdin;
		}
	}
	else {
		yyin = stdin;
	}
	
	yylex();
	
	
	
}

