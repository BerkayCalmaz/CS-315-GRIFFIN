%{
#include <stdio.h>
#include "y.tab.h"
void yyerror(char *);
%}


DIGIT   [0-9]
LETTER  [a-zA-Z]
IDENTIFIER {AT}{LETTER}({DIGIT}|{LETTER})*
INT {DIGIT}+
FLOAT {DIGIT}+\.{DIGIT}+
BOOLEAN true | false
CHAR_IDENTIFIER    '
STRING_IDENTIFIER  \"
STRING {STRING_IDENTIFIER}[^\"]*{STRING_IDENTIFIER}
CHAR {CHAR_IDENTIFIER}[^']{CHAR_IDENTIFIER}
IF      if
FOR     for
RETURN  return
INPUT_STREAM    \$\>
OUTPUT_STREAM   \<\$
NOT_EQUAL  !=
AND_RELATION  &&
OR_RELATION  \|\|
EQUALS ==
LT <
GT >
LTE <=
GTE >= 
FUNC griffunc
SC ;
GRIFFIN griffin
GRIFFOUT griffout
CONSOLE console
SET set
VOID void
NL \n
ASSIGN_OP =
ADD_ELEMENT addElement
DELETE_ELEMENT deleteElement
GET_ELEMENT getElement
GET_CARDINALiTY getCardinality
CONTAINS contains
WHILE while
LP \(
RP \)
LB \{
RB \}
UNION union
INTER inter
DIFF  diff
CROSS cross
PLUS  \+
MINUS -
DIVIDE \\
MULT \*
MOD %
IS_SUPERSET isSuperSet
IS_SUBSET isSubSet
IS_EQUAL isEqual
IS_EQUVAILENT isEquvailent
IS_OVERLAPPING isOverlapping
IS_DISJOINT isDisjoint
IS_EMPTY isEmpty
AT @
COMMA ,
COLON :
COMMENT $$[^(\n)]*\n
NEWLINE \n
FUNCTION_CALL call
DOT \.
ELEMENT element
GRIFFILE griffile
UNDERSCORE \_

%option yylineno
%%
{NEWLINE} return NL;
{DOT} return DOT;
{GRIFFILE} return GRIFFILE;
{CONSOLE} return CONSOLE;
{GRIFFOUT} return GRIFFOUT;
{IS_EMPTY} return IS_EMPTY;
{FUNCTION_CALL} return FUNCTION_CALL_IDENTIFIER;
{COMMENT} return COMMENT;
{STRING} return STRING;
{STRING_IDENTIFIER} return STRING_IDENTIFIER;
{COMMA} return COMMA;
{COLON} return COLON;
{IF}    return IF;
{SET}   return SET_IDENTIFIER;
{ELEMENT} return ELEMENT_IDENTIFIER
{VOID} return VOID_IDENTIFIER
{GRIFFIN} return GRIFFIN ;
{INT} return INT ;
{FLOAT} return FLOAT;
{CHAR} return CHAR;
{SC} return SC;
{PLUS} return PLUS;
{MINUS} return MINUS;
{MULT} return MULTIPLY;
{DIVIDE} return DIVIDE;
{MOD} return MOD;
{FOR} return FOR;
{FUNC} return FUNC_IDENTIFIER;
{EQUALS} return EQUALS_RELATION;
{OR_RELATION} return OR_RELATION;
{AND_RELATION} return AND_RELATION;
\>\= return GTE;
{LTE} return LTE;
{LT} return LT;
\> return GT;
{NOT_EQUAL} return NOT_EQUAL;
{INPUT_STREAM} return INPUT_STREAM;
{OUTPUT_STREAM} return OUTPUT_STREAM;
{ASSIGN_OP} return ASSIGN_OP;
{ADD_ELEMENT} return ADD_ELEMENT;
{DELETE_ELEMENT} return DELETE_ELEMENT;
{GET_ELEMENT} return GET_ELEMENT;
{GET_CARDINALiTY} return GET_CARDINALiTY;
{WHILE} return WHILE;
{LP} return LP;
{RP} return RP;
{RB} return RB;
{LB} return LB;
{AT} return AT;
{UNION} return UNION;
{DIFF} return DIFF;
{CROSS} return CROSS;
{INTER} return INTER;
{IS_DISJOINT} return IS_DISJOINT;
{IS_SUBSET} return IS_SUBSET;
{IS_SUPERSET} return IS_SUPERSET;
{IS_EQUVAILENT} return IS_EQUVAILENT;
{IS_OVERLAPPING} return IS_OVERLAPPING;
{IS_EQUAL} return IS_EQUAL;
{IDENTIFIER} return IDENTIFIER;
else return ELSE;
int return INT_TYPE;
string return STRING_TYPE;
float return FLOAT_TYPE;
char return CHAR_TYPE;
boolean return BOOLEAN_TYPE;
delete return DELETE_TYPE;
{RETURN} return RETURN;
true return TRUE;
false return FALSE;
%%

int yywrap(void){
	return 1;
}