
%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
    extern int yylineno;
%}

%token ASSIGNMENTOP
%token GRIFFILE
%token CONSOLE
%token GRIFFOUT
%token ELEMENT
%token IS_EMPTY
%token FUNCTION_CALL
%token COMMENT
%token STRING
%token STRING_IDENTIFIER
%token COMMA
%token COLON
%token IF
%token SET
%token GRIFFIN
%token INT
%token FLOAT
%token CHAR
%token TRUE
%token FALSE
%token SC
%token PLUS
%token MINUS
%token MULT
%token DIVIDE
%token MOD
%token FOR
%token FUNC
%token EQUALS
%token OR_RELATION
%token AND_RELATION
%token GTE
%token LTE
%token LT
%token GT
%token NOT_EQUAL
%token INPUT_STREAM
%token OUTPUT_STREAM
%token ASSIGN_OP
%token ADD_ELEMENT
%token DELETE_ELEMENT
%token GET_ELEMENT
%token GET_CARDINALITY
%token WHILE
%token LP
%token RP
%token RB
%token LB
%token UNIOON 
%token DIFF 
%token INTER
%token IS_DISJOINT
%token IS_SUBSET
%token IS_SUPERSET
%token IS_EQUVAILENT
%token IS_OVERLAPPING
%token IS_EQUAL
%token IDENTIFIER
%token ELSE
%token INT_TYPE 
%token STRING_TYPE
%token FLOAT_TYPE
%token CHAR_TYPE
%token BOOLEAN 
%token DELETE
%token RETURN
%token NL

%start program

%%

//Start Rule

//Program
program:
	stmts

stmts:
    stmt stmt SC
  | stmt SC
  | stmt SC NL

stmt: dec_stmt | if_stmt | loop_stmt | func_stmt
    | assign_stmt | return_stmt | stream_stmt
    | set_dec_stmt | delete_stmt



 
%%



void yyerror(char *s) {
	fprintf(stdout, "line %d: %s\n", yylineno,s);
}
int main(void){
 yyparse();
if(yynerrs < 1){
		printf("Parsing is successful\n");
	}
 return 0;
}
