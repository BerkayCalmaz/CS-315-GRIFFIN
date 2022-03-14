
%{
#include <stdio.h>
%}

%token GRIFFILE
%token CONSOLE
%token GRIFFOUT
%token IS_EMPTY
%token FUNCTION_CALL_IDENTIFIER
%token COMMENT
%token STRING
%token COMMA
%token COLON
%token DOT
%token IF
%token SET_IDENTIFIER
%token GRIFFIN
%token INT
%token FLOAT
%token CHAR
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
%token UNION 
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

%token BOOLEAN
%token CONTAINS
%token VOID_IDENTIFIER
%token ELEMENT_IDENTIFIER


%start program

%%

//Start Rule

//Program
program:
	stmts {printf("\rProgram is valid.\n");}

stmts:
    stmt stmt SC
  | stmt SC
  | stmt SC NL

stmt: matched_stmt | unmatched_stmt

dec_stmt: IDENTIFIER COLON primitive_type ASSIGN_OP expression
        | IDENTIFIER COLON primitive_type

set_dec_stmt: IDENTIFIER COLON SET_IDENTIFIER
            | IDENTIFIER COLON SET_IDENTIFIER ASSIGN_OP set_expr

assign_stmt : IDENTIFIER ASSIGN_OP expression
/*6. IF STATEMENTS */

matched_stmt : IF LP cond_expr RP LB matched_stmt RB
		ELSE LB matched_stmt
		| if_block
    
unmatched_stmt : IF LP cond_expr RP stmt
    		| IF LP cond_expr RP LB matched_stmt RB ELSE LB unmatched_stmt RB
		| IF LP cond_expr RP LB stmts RB ELSE LB stmts RB
		| IF LP cond_expr RP LB stmts RB

if_block : dec_stmt | loop_stmt | func_stmt
                  | assign_stmt |   return_stmt | stream_stmt 
                  | set_dec_stmt   | delete_stmt | comment


return_stmt:  RETURN IDENTIFIER |
		RETURN constant_list

loop_stmt: for_stmt
        | while_stmt

for_stmt: FOR LP dec_stmt SC cond_expr SC arith_expr RP LB stmts RB

while_stmt : WHILE LP cond_expr RP LB stmts RB
 
/*8. EXPRESSIONS */

expression :arith_expr | set_constant

cond_expr : set_cond_expr | equality_expr	

equality_expr : equal_condition_elements
			      | equality_expr EQUALS_RELATION equal_condition_elements

equal_condition_elements : arith_relational_expr | logic_expr

arith_relational_expr: LP arith_relational_elements relational_op arith_relational_expr RP

arith_relational_elements: IDENTIFIER | INT | FLOAT

logic_expr: logic_expr_element | logic_expr_element logic_op logic_expr

logic_expr_element : IDENTIFIER | BOOLEAN 

set_expr : set_expr_identifiers
         | set_expr_identifiers set_op set_expr	

set_cond_expr : set_expr_identifiers DOT set_cond_op LP set_expr_identifiers RP

set_expr_identifiers : IDENTIFIER | set_constant | func_call

arith_expr : arith_expr_identifiers
	     | arith_expr_identifiers arith_op  arith_expr

arith_expr_identifiers : IDENTIFIER | INT | FLOAT | func_call

delete_stmt: DELETE_TYPE IDENTIFIER

//10 VARIABLES


set_constant : LB set_elements RB

set_elements : constant
			 | IDENTIFIER
			 | constant COMMA set_elements 
			 | IDENTIFIER COMMA set_elements


constant : STRING | INT | FLOAT | CHAR | BOOLEAN
//------------------------

comment: COMMENT NL

//12 OPERANDS AND BUILT IN FUNCTIONS
set_op : UNION | INTER | DIFF | CROSS

prim_set_func : GET_CARDINALITY | GET_ELEMENT | ADD_ELEMENT
     | DELETE_ELEMENT | CONTAINS | IS_EMPTY

arith_op : PLUS | MINUS | DIVIDE | MULTIPLY | MOD

logic_op : NOT_EQUAL | AND_RELATION | OR_RELATION 

relational_op : LT | GT | LTE | GTE | EQUALS_RELATION

set_cond_op : IS_SUPERSET | IS_SUBSET | IS_EQUAL | IS_EQUVAILENT | 
   | IS_OVERLAPPING | IS_DISJOINT


primitive_type: STRING_TYPE
                | INT_TYPE 
                | FLOAT_TYPE 
                | CHAR_TYPE 
                | BOOLEAN_TYPE

//14 Function Declarations and Calls
func_stmt : func_dec | func_call | prim_set_func_call


func_dec : FUNC_IDENTIFIER IDENTIFIER LP param_dec_list RP COLON func_dec_primitive LB stmts RB

func_dec_primitive : primitive_type | SET_IDENTIFIER | VOID_IDENTIFIER 

param_dec_type : primitive_type | SET_IDENTIFIER | ELEMENT_IDENTIFIER

param_dec_list : empty | IDENTIFIER COLON param_dec_type 
| IDENTIFIER COLON param_dec_type COMMA param_dec_type

constant_list : constant | set_constant

param_list : IDENTIFIER | empty
		       | constant_list
		       | IDENTIFIER COMMA param_list
	         | constant_list COMMA constant_list	

func_call : FUNCTION_CALL_IDENTIFIER IDENTIFIER LP param_list RP
    | FUNCTION_CALL_IDENTIFIER prim_set_func LP param_list RP

prim_set_func_call :   FUNCTION_CALL_IDENTIFIER IDENTIFIER DOT prim_set_func  LP param_list RP
                   | FUNCTION_CALL_IDENTIFIER set_constant DOT prim_set_func LP param_list RP
//----------

stream_stmt: input_stmt | output_stmt

input_stmt: GRIFFIN LP input_from RP INPUT_STREAM IDENTIFIER

input_from: IDENTIFIER | CONSOLE | file_constant

output_stmt: GRIFFOUT LP output_to RP OUTPUT_STREAM output_from

output_to: CONSOLE | IDENTIFIER | file_constant

output_from: IDENTIFIER | set_constant | constant

file_constant: GRIFFILE LP STRING RP
empty:
%%
#include "lex.yy.c"
int lineno;
main(){
    return yyparse();
}

yyerror( char *s ) { fprintf( stderr, "%s\n", s); };
