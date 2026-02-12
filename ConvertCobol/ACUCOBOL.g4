grammar ACUCOBOL;

// Lexer Rules (Tokens) - Corrected String Literals
STRING_LITERAL: '"' (~["\r\n])* '"'; // Correct:  " followed by anything but " followed by "
NUMBER: [0-9]+;
FILENAME: '"' [A-Za-z0-9_.-]+ '"';
VAR_NAME: [A-Za-z0-9-]+;
SECTION_NAME: [A-Z][A-Za-z0-9-]*;
PARAGRAPH_NAME: [A-Za-z0-9-]+;

PIC_TYPE: 'PIC';
IDENTIFICATION: 'IDENTIFICATION';
DIVISION: 'DIVISION';
PROGRAM_ID: 'PROGRAM-ID';
DATA: 'DATA';
WORKING_STORAGE: 'WORKING-STORAGE';
FILE: 'FILE';
REDEFINES: 'REDEFINES';
OCCURS: 'OCCURS';
TIMES_KEYWORD: 'TIMES'; // To avoid conflict with TIMES parser rule
PROCEDURE: 'PROCEDURE';
MOVE: 'MOVE';
TO: 'TO';
DISPLAY: 'DISPLAY';
COMPUTE: 'COMPUTE';
IF: 'IF';
THEN: 'THEN';
ELSE: 'ELSE';
END_IF: 'END-IF';
OPEN: 'OPEN';
CLOSE: 'CLOSE';
READ: 'READ';
WRITE: 'WRITE';
REWRITE: 'REWRITE';
START: 'START';
AT: 'AT';
END: 'END';
STOP: 'STOP';
RUN: 'RUN';
GOBACK: 'GOBACK';
COPY: 'COPY';
CALL: 'CALL';
USING: 'USING';
SQL: 'SQL';
EXEC: 'EXEC';
CONNECT: 'CONNECT';
AS: 'AS';
SELECT: 'SELECT';
INSERT: 'INSERT';
UPDATE: 'UPDATE';
DELETE: 'DELETE';
STRING: 'STRING';
FROM : 'FROM';
BY : 'BY';
DELIMITED: 'DELIMITED';
BY_KEYWORD: 'BY'; // to avoid conflict with BY parser rule
INTO: 'INTO';
WITH: 'WITH';
POINTER: 'POINTER';
ACCEPT: 'ACCEPT';
FROM_KEYWORD: 'FROM'; // to avoid conflict with FROM parser rule
VALUE: 'VALUE';
ZERO: 'ZERO';
ZEROS: 'ZEROS';
SPACE: 'SPACE';
SPACES: 'SPACES';
HIGH_VALUE: 'HIGH-VALUE';
HIGH_VALUES: 'HIGH-VALUES';
LOW_VALUE: 'LOW-VALUE';
LOW_VALUES: 'LOW-VALUES';
QUOTE: 'QUOTE';
QUOTES: 'QUOTES';
COMP: 'COMP';
COMP_1: 'COMP-1';
COMP_2: 'COMP-2';
COMP_3: 'COMP-3';
COMP_4: 'COMP-4';
COMP_5: 'COMP-5';
BINARY: 'BINARY';
//DISPLAY_KEYWORD: 'DISPLAY'; // Avoid conflict with the parser rule DISPLAY
USAGE: 'USAGE';
FD: 'FD';
LINKAGE: 'LINKAGE';
SECTION: 'SECTION';
VARYING: 'VARYING';

WS: [ \t\r\n]+ -> skip;

// Parser Rules (Grammar)
program: IDENTIFICATION DIVISION? PROGRAM_ID SECTION_NAME '.' dataDivision procedureDivision;

dataDivision: DATA DIVISION '.' workingStorageSection? fileSection? linkageSection?;
workingStorageSection: WORKING_STORAGE SECTION '.' variableDeclaration+;
fileSection: FILE SECTION '.' fileDescription+;
fileDescription: FD VAR_NAME '.' recordDeclaration+;
recordDeclaration: VAR_NAME PIC_TYPE PIC_FORMAT '.';
linkageSection: LINKAGE SECTION '.' variableDeclaration+;

variableDeclaration: VAR_NAME PIC_TYPE PIC_FORMAT (VALUE value)? (REDEFINES VAR_NAME)? (OCCURS NUMBER TIMES_KEYWORD)? '.';


PIC_FORMAT: '(' PIC_STRING ')' | PIC_STRING;
PIC_STRING: (PIC_CHAR | PIC_REPETITION)+;
PIC_CHAR: 'A' | 'X' | '9' | 'Z' | '$' | '.' | ',' | '/' | '*' | '+' | '-' | 'B' | 'P' | 'V' | 'S' | 
          COMP | COMP_1 | COMP_2 | COMP_3 | COMP_4 | COMP_5 | BINARY | // Use tokens for data types
          USAGE COMP | USAGE COMP_1 | USAGE COMP_2 | USAGE COMP_3 | USAGE COMP_4 | USAGE COMP_5 | USAGE BINARY;
PIC_REPETITION: PIC_CHAR '(' NUMBER ')';

procedureDivision: PROCEDURE DIVISION '.' paragraph+;
paragraph: paragraphName '.' sentence+;
paragraphName: PARAGRAPH_NAME;
sentence: statement+ '.';

statement: moveStatement | displayStatement |  callStatement | stopStatement | ifStatement | performStatement | fileStatement | gobackStatement | copyStatement | computeStatement | stringStatement | acceptStatement;

moveStatement: MOVE (value | VAR_NAME) TO VAR_NAME (',' VAR_NAME)* '.';
displayStatement: DISPLAY (value | VAR_NAME) (',' (value | VAR_NAME))* '.';
sqlConnect: CONNECT TO STRING_LITERAL AS VAR_NAME;
sqlQuery: (SELECT | INSERT | UPDATE | DELETE) .*?; // Basic SQL parsing (improve if needed)
callStatement: CALL (STRING_LITERAL | VAR_NAME) (USING VAR_NAME+)? '.';
stopStatement: STOP RUN '.';
gobackStatement: GOBACK '.';
ifStatement: IF condition THEN sentence+ (ELSE sentence+)? END_IF '.';
performStatement: PERFORM (paragraphName | VAR_NAME) (TIMES_KEYWORD NUMBER)? (VARYING startValue FROM_KEYWORD initialValue BY_KEYWORD incrementValue TO endValue)? '.'; // Use FROM_KEYWORD, BY_KEYWORD
startValue: VAR_NAME | NUMBER;
initialValue: VAR_NAME | NUMBER;
incrementValue: VAR_NAME | NUMBER;
endValue: VAR_NAME | NUMBER;
fileStatement: (OPEN | CLOSE | READ | WRITE | REWRITE | START) VAR_NAME (AT END sentence+)?;
copyStatement: COPY FILENAME ; // Add REPLACING clause if needed
computeStatement: COMPUTE VAR_NAME '=' expression '.';
stringStatement: STRING (value | VAR_NAME)+ DELIMITED BY (value | VAR_NAME) INTO VAR_NAME (WITH POINTER VAR_NAME)?;
acceptStatement: ACCEPT VAR_NAME (FROM VAR_NAME)?; // Add FROM clause if required

condition: (VAR_NAME | '(' condition ')') (('='|'<'|'>'|'<='|'>='|'NOT ='|'IS' 'NUMERIC'|'IS' 'ALPHABETIC'|'IS' 'ALPHANUMERIC'|'AND'|'OR') (value | VAR_NAME | '(' condition ')'))*;

expression: term (('+'|'-') term)*;
term: factor (('*'|'/') factor)*;
factor: (value | VAR_NAME | '(' expression ')');

value: STRING_LITERAL | NUMBER | constant;
constant: ZERO | ZEROS | SPACE | SPACES | HIGH_VALUE | HIGH_VALUES | LOW_VALUE | LOW_VALUES | QUOTE | QUOTES;
