
%{   
   #include "y.tab.h"
   int currLine = 1, currPos = 1;
   char* currText = "";
%}

DIGIT [0-9]
LETTER [a-z]|[A-Z]

FUNCTION "function"
BEGIN_PARAMS "beginparams"
END_PARAMS "endparams"
BEGIN_LOCALS "beginlocals"
END_LOCALS "endlocals"
BEGIN_BODY "beginbody"
END_BODY "endbody"
INTEGER "integer"
ARRAY "array"
OF "of"
IF "if"
THEN "then"
ENDIF "endif"
ELSE "else"
WHILE "while"
DO "do"
BEGINLOOP "beginloop"
ENDLOOP "endloop"
CONTINUE "continue"
READ "read"
WRITE "write"
AND "and"
OR "or"
NOT "not"
TRUE "true"
FALSE "false"
RETURN "return"

SUB -
ADD "+"
MULT "*"
DIV "/"
MOD "%"

EQUAL =
EQ "=="
NEQ "<>"
LT <
GT >
LTE "<="
GTE ">="

IDENT {LETTER}({LETTER}|{DIGIT}|_)*({LETTER}|{DIGIT})|{LETTER}
NUMBER {DIGIT}+


SEMICOLON ;
COLON :
COMMA ,
L_PAREN "("
R_PAREN ")"
L_SQUARE_BRACKET "["
R_SQUARE_BRACKET "]"
ASSIGN ":="
DOT "."

SPACE " "
NEWLINE "\n"
TABS "\t"


COMMENT ##.*


ERROR2 {IDENT}_+
ERROR3 {DIGIT}+{IDENT}|_+{IDENT}|_+{IDENT}_+
OTHER .



%%
{NUMBER}        	{currPos += yyleng;	return NUMBER;}
{ADD}			{currPos += yyleng;	return ADD;}
{SUB}			{currPos += yyleng;	return SUB;}
{MULT}			{currPos += yyleng;	return MULT;}
{DIV}			{currPos += yyleng;	return DIV;}
{MOD}			{currPos += yyleng;	return MOD;}
{L_PAREN}		{currPos += yyleng;	return L_PAREN;}
{R_PAREN}		{currPos += yyleng;	return R_PAREN;}
{L_SQUARE_BRACKET} 	{currPos += yyleng;	return L_SQUAREBRACKET;}
{R_SQUARE_BRACKET} 	{currPos += yyleng;	return R_SQUAREBRACKET;}
{EQUAL}			{currPos += yyleng;	return EQUAL;}
{EQ}			{currPos += yyleng;	return EQ;}
{LT}			{currPos += yyleng;	return LT;}
{GT} 			{currPos += yyleng;	return GT;}
{LTE}			{currPos += yyleng;	return LTE;}
{GTE}			{currPos += yyleng;	return GTE;}
{AND} 			{currPos += yyleng;	return AND;}
{OR} 			{currPos += yyleng;	return OR;}
{NOT} 			{currPos += yyleng;	return NOT;}
{ASSIGN}		{currPos += yyleng;	return ASSIGN;}
{SEMICOLON}		{currPos += yyleng;	return SEMICOLON;}
{COLON}			{currPos += yyleng;	return COLON;}
{COMMA} 		{currPos += yyleng;	return COMMA;}
{DOT}			{currPos += yyleng;	return DOT;}

{NEWLINE}		{currPos += yyleng; currPos = 1; currLine += 1;}
{TABS}			{currPos += yyleng;}
{SPACE}			{currPos += yyleng;}
{FUNCTION}		{currPos += yyleng;	return FUNCTION;}
{BEGINLOOP} 		{currPos += yyleng;	return BEGINLOOP;}
{ENDLOOP} 		{currPos += yyleng;	return ENDLOOP;}
{BEGIN_PARAMS}		{currPos += yyleng;	return BEGIN_PARAMS;}
{END_PARAMS}		{currPos += yyleng;	return END_PARAMS;}
{BEGIN_LOCALS}		{currPos += yyleng;	return BEGIN_LOCALS;}
{END_LOCALS}		{currPos += yyleng;	return END_LOCALS;}
{INTEGER}		{currPos += yyleng;	return INTEGER;}
{BEGIN_BODY}		{currPos += yyleng;	return BEGIN_BODY;}
{END_BODY}		{currPos += yyleng;	return END_BODY;}
{ARRAY} 		{currPos += yyleng;	return ARRAY;}

{OF} 			{currPos += yyleng;	return OF;}
{IF}			{currPos += yyleng;	return IF;}
{THEN}			{currPos += yyleng;	return THEN;}
{ELSE} 			{currPos += yyleng;	return ELSE;}
{ENDIF}			{currPos += yyleng;	return ENDIF;}
{DO} 			{currPos += yyleng;	return DO;}
{WHILE} 		{currPos += yyleng;	return WHILE;}
{CONTINUE} 		{currPos += yyleng;	return CONTINUE;}
{RETURN}		{currPos += yyleng;	return RETURN;}


{TRUE} 			{currPos += yyleng;	return TRUE;}
{FALSE} 		{currPos += yyleng;	return FALSE;}

{READ}			{currPos += yyleng;	return READ;}
{WRITE}			{currPos += yyleng;	return WRITE;}

{IDENT}			{currPos += yyleng; currText = yytext;	return IDENT;}

{COMMENT} 		{}


{ERROR2}		{printf("Error at line %d, column %d: identifier cannot end with an underscore \"%s\"\n", currLine, currPos, yytext); exit(0);}
{ERROR3}		{printf("Error at line %d, column %d: identifier must start with a letter \"%s\"\n", currLine, currPos, yytext); exit(0);}
{OTHER}			{printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}
%%


