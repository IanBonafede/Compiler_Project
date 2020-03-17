%{
#include <stdio.h>
#include <stdlib.h>
	
void yyerror(const char *msg);
extern int currLine;
extern int currPos;
extern char* currText;
FILE * yyin;
%}

%union{
	double dval;
	int ival;
}

%error-verbose
%start Program
%token 	DIGIT LETTER FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
	INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR 
	NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQUAL EQ NEQ LT GT LTE GTE IDENT NUMBER SEMICOLON 
	COLON COMMA L_PAREN R_PAREN L_SQUAREBRACKET R_SQUAREBRACKET ASSIGN DOT SPACE NEWLINE TABS 
	COMMENT ERROR2 ERROR3 OTHER

%%
Program:		{printf("Program -> epsilon\n");}
			| Functions {printf("Program -> Functions\n");}
			;

Functions:		Function {printf("Functions -> Function\n");}
			| Function Functions {printf("Functions -> Function Functions\n");}
			;

Function:		FUNCTION Ident SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY {printf("Function -> FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY\n");}
			;

Declarations:		{printf("Declarations -> epsilon\n");}
			| Declaration SEMICOLON Declarations {printf("Declarations -> Declaration SEMICOLON Declarations\n");}
			;

Statements:		Statement SEMICOLON {printf("Statements -> Statement SEMICOLON");}
			| Statement SEMICOLON Statements {printf("Statements -> Statement SEMICOLON Statements\n");}
			;

Declaration:		Identifiers COLON ArrayIndex INTEGER {printf("Declaration -> Identifiers COLON ArrayIndex INTEGER\n");}
			| Identifiers COLON INTEGER {printf("Declaration -> Identifiers COLON INTEGER\n");}
			;

Identifiers:		Ident {printf("Identifiers -> Ident\n");}
			| Ident COMMA Identifiers {printf("Identifiers -> Ident COMMA Identifiers\n");}
			;

ArrayIndex:		ARRAY L_SQUAREBRACKET NUMBER R_SQUAREBRACKET OF {printf("ArrayIndex -> ARRAY L_SQUAREBRACKET NUMBER R_SQUAREBRACKET OF\n");}
			;

Statement:		Var ASSIGN Expression {printf("Statement -> Var ASSIGN Expression\n");}
			| IF BoolExp THEN Statements ENDIF {printf("Statement -> IF BoolExp THEN Statements ENDIF\n");}
			| IF BoolExp THEN Statements ELSE Statements ENDIF {printf("Statement -> IF BoolExp THEN Statements ELSE Statements ENDIF\n");}
			| WHILE BoolExp BEGINLOOP Statements ENDLOOP {printf("Statement -> WHILE BoolExp BEGINLOOP Statements ENDLOOP\n");}
			| DO BEGINLOOP Statements ENDLOOP WHILE BoolExp {printf("Statement -> DO BEGINLOOP Statements ENDLOOP WHILE BoolExp\n");}
			| READ Vars {printf("Statement -> READ Vars\n");}
			| WRITE Vars {printf("Statement -> WRITE Vars\n");}
			| CONTINUE {printf("Statement -> CONTINUE\n");}
			| RETURN Expression {printf("Statement -> RETURN Expression\n");}
			;

Vars:			Var {printf("Vars -> Var\n");}
			| Var COMMA Vars {printf("Vars -> Var COMMA Vars\n");}
			;

Var:			Ident {printf("Var -> Ident\n");}
			| Ident L_SQUAREBRACKET Expression R_SQUAREBRACKET {printf("Var -> Ident L_SQUAREBRACKET Expression R_SQUAREBRACKET\n");}
			;

BoolExp:		RelationAndExp BoolExps {printf("BoolExp -> RelationAndExp BoolExps\n");}
			;

BoolExps:		{printf("BoolExps -> epsilon\n");}
			| OR BoolExp {printf("BoolExps -> OR BoolExp\n");}
			;

RelationAndExp:		RelationExp RelationAndExps {printf("RelationAndExp -> RelationExp RelationAndExps\n");}
			;

RelationAndExps:	{printf("RelationAndExps -> epsilon\n");}
			| AND RelationAndExp {printf("RelationAndExps -> AND RelationAndExp\n");}
			;

RelationExp:		NotExist RelationExps {printf("RelationExp -> NotExist RelationExps\n");}
			;

NotExist:		{printf("NotExist -> epsilon\n");}
			| NOT {printf("NotExist -> NOT\n");}
			; 

RelationExps:		Expression Comp Expression {printf("RelationExps -> Expression Comp Expression\n");}
			| TRUE {printf("RelationExps -> TRUE\n");}
			| FALSE {printf("RelationExps -> FALSE\n");}
			| L_PAREN BoolExp R_PAREN {printf("RelationExps -> L_PAREN BoolExp R_PAREN\n");}
			;

Comp:			EQ {printf("Comp -> EQ\n");}
			| NEQ {printf("Comp -> NEQ\n");}
			| LT {printf("Comp -> LT\n");}
			| GT {printf("Comp -> GT\n");}
			| LTE {printf("Comp -> LTE\n");}
			| GTE {printf("Comp -> GTE\n");}
			;



Expression: 		MultiplicativeExp Expressions {printf("Expression -> MultiplicativeExp Expressions\n");}
			;

Expressions:		{printf("Expressions -> epsilon\n");}
			| ADD Expression {printf("Expressions -> ADD Expression\n");}
			| SUB Expression {printf("Expressions -> SUB Expression\n");}
			;

MultiplicativeExp:	Term MultiplicativeExps{printf("MultiplicativeExp -> Term MultiplicativeExps\n");}
			;

MultiplicativeExps:	{printf("MultiplicativeExps -> epsilon\n");}
			| MULT MultiplicativeExp {printf("MultiplicativeExps -> MULT MultiplicativeExs\n");}
			| DIV MultiplicativeExp {printf("MultiplicativeExps -> DIV MultiplicativeExp\n");}
			| MOD MultiplicativeExp {printf("MultiplicativeExps -> MOD MultiplicativeExp\n");}
			;

Term:			SubExist Ident {printf("Term -> SubExist IDENT\n");}
			| SubExist Ident L_SQUAREBRACKET Expression R_SQUAREBRACKET {printf("Term -> SubExist IDENT L_SQUAREBRACKET Expression R_SQUAREBRACKET\n");}
			| SubExist NUMBER {printf("Term -> SubExist NUMBER\n");}
			| SubExist L_PAREN Expression R_PAREN {printf("Term -> SubExist L_PAREN Expression R_PAREN\n");}
			| IDENT {printf("Term -> IDENT\n");}
			| IDENT L_PAREN ExpressionsComma R_PAREN {printf("Term -> IDENT L_PAREN Expressions R_PAREN\n");}
			;

ExpressionsComma:	{printf("ExpressionsComma -> epsilon\n");}
			| Expression {printf("ExpressionsComma -> Expression\n");}
			| Expression COMMA Expressions {printf("ExpressionsComma -> Expression COMMA ExpressionsComma\n");}
			;

SubExist:		{printf("SubExist -> epsilon\n");}
			| SUB {printf("SubExist -> SUB\n");}
			;

Ident:			IDENT {printf("Ident -> IDENT %s\n", currText);}

%%

int main(int argc, char **argv) {
   if (argc > 1) {
      yyin = fopen(argv[1], "r");
      if (yyin == NULL){
         printf("syntax: %s filename\n", argv[0]);
      }//end if
   }//end if
   yyparse(); // Calls yylex() for tokens.
   return 0;
}

void yyerror(const char *msg) {
   printf("** Line %d, position %d: %s\n", currLine, currPos, msg);
}
