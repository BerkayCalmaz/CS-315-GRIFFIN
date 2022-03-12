
%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
    extern int yylineno;
%}

%token GRIFFILE
%token CONSOLE
%token GRIFFOUT
%token ELEMENT
%token IS_EMPTY
%token FUNCTION_CALL
%token COMMENT
%token STRING
%token COMMA
%token COLON
%token IF
%token SET_IDENTIFIER
%token GRIFFIN
%token INT
%token FLOAT
%token CHAR
%token TRUE
%token FALSE
%token SC
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token MOD
%token FOR
%token FUNC_IDENTIFIER
%token EQUALS_RELATION
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
%token CROSS 
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
%token BOOLEAN_TYPE
%token DELETE_TYPE
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

dec_stmt: IDENTIFIER COLON primitive_type ASSIGN_OP expression
        | IDENTIFIER COLON primitive_type

set_dec_stmt: IDENTIFIER COLON SET_IDENTIFIER
            | IDENTIFIER COLON SET_IDENTIFIER ASSIGN_OP set_expr
            | IDENTIFIER COLON SET_IDENTIFIER ASSIGN_OP func_call 

return_stmt:  RETURN IDENTIFIER
            | RETURN
            | RETURN expression
            | RETURN cond_expr
            | RETURN constant
            | RETURN set_constant
            | RETURN set_expr

loop_stmt: for_stmt
        | while_stmt

for_stmt: FOR LP dec_stmt SC cond_expr SC arith_stmt RP LB stmts RB

while_stmt : WHILE LP cond_expr RP LB stmts RB
 
delete_stmt: DELETE_TYPE IDENTIFIER

comment: COMMENT NL

primitive_type: STRING_TYPE
                | INT_TYPE 
                | FLOAT_TYPE 
                | CHAR_TYPE 
                | BOOLEAN_TYPE

string: STRING
int: INT
float: FLOAT
char: CHAR

boolean : TRUE | FALSE


stream_stmt: input_stmt | output_stmt

input_stmt: GRIFFIN LP input_from RP INPUT_STREAM IDENTIFIER

input_from: IDENTIFIER | CONSOLE | file_constant

output_stmt: GRIFFOUT LP output_to RP OUTPUT_STREAM output_from

output_to: CONSOLE | IDENTIFIER | file_constant

output_from: IDENTIFIER | set_constant | constant

file_constant: GRIFFILE LP string RP

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
