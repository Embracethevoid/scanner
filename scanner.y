%{
#include <cstdio>
#include <iostream>
using namespace std;

// stuff from flex that bison needs to know about:
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;
extern int line_num;
 
void yyerror(const char *s);
%}

// Bison fundamentally works by asking flex to get the next token, which it
// returns as an object of type "yystype".  But tokens could be of any
// arbitrary data type!  So we deal with that in Bison by defining a C union
// holding each of the types of tokens that Flex could return, and have Bison
// use that union instead of "int" for the definition of "yystype":
%union {
	int ival;
	float fval;
	char *sval;
	char *identval;
}

// define the constant-string tokens:
%token EXTENDS CLASS WHILE IF ELSE ELIF RETURN DEF ENDL 
%token COLON SEMICOLON LPARENTHESES RPARENTHESES LBRACES RBRACES DOT COMMA
%token PLUS MINUS TIMES DIVIDE MORE ATMOST LESS ATLEAST EQUALS NOT AND OR GETS
%token ILLEGAL MISS


// define the "terminal symbol" token types I'm going to use (in CAPS
// by convention), and associate each with a field of the union:
%token <ival> INT_LIT
%token <fval> FLOAT
%token <sval> STRING_LIT
%token <identval> Ident
%%
// the first rule defined is the highest-level rule, which in our
// case is just the concept of a whole "program file":
/*
Program:
	ENDLS Classes Statement Statements ENDLS
	;
Classes:
	ENDLS|Classes Class ENDLS
	;
Class:
	Class_Signature Class_Body ENDLS
	;
Class_Signature:
	Class_Ident Parentheses_Formail_Args Extends_Ident ENDLS|
	Class_Ident Parentheses_Formail_Args ENDLS
	;
Class_Ident:
	CLASS Ident ENDLS{cout<< "CLASS " << "\"class\""<<endl<<"IDENT \""<<$2<<"\""<<endl;}
	;
Parentheses_Formail_Args:
	LP Formal_Args RP ENDLS
	;
LP:
	LPARENTHESES ENDLS{cout<<"( \"(\""<<endl;}
	;
RP:
	RPARENTHESES ENDLS{cout<<") \")\""<<endl;}
	;

Formal_Args:
	ENDLS|Formal_Args_First Formal_Args_Idents ENDLS
	;
Formal_Args_First:
	Ident COLON Ident {cout<<"IDENT \""<<$1<<"\""<<endl<<": \":\""<<endl<<"IDENT \""<<$3<<"\""<<endl;}
	;

Formal_Args_Idents:
	ENDLS|Formal_Args_Idents Formal_Args_Ident  ENDLS
	;


Formal_Args_Ident:
	COMMA Ident COLON Ident ENDLS {cout<<", \",\""<< endl<<"IDENT \""<<$2<<"\""<<endl<<": \":\""<<endl<<"IDENT \""<<$4<<"\""<<endl;}
	;

Extends_Ident:
	EXTENDS Ident ENDLS{cout<< "EXTENDS "<< "\""<<"extends"<<"\""<<endl<<"IDENT \""<<$2<<"\""<<endl;}
	;

Class_Body:
	LB Class_Body_Content RB ENDLS
	;
LB:
	LBRACES{cout<<"{ \"{\""<<endl;}
	;

RB:
	RBRACES{cout<<"} \"}\""<<endl;}
	;

Class_Body_Content:
	Statements Methods ENDLS
	;

Statements:
	ENDLS |Statements Statement ENDLS
	;

Statement:
	IF R_Expr Statement_Block Elifs Else  |
	IF R_Expr Statement_Block Elifs   |
	WHILE R_Expr Statement_Block  |
	L_Expr COLON Ident GETS R_Expr SEMICOLON  |
	L_Expr GETS R_Expr  |
	R_Expr SEMICOLON  
	;
	
Elifs:
	|Elifs Elif
	;


Elif:
	ELIF R_Expr Statement_Block
	;
Else:
	ELSE Statement_Block
	;

Methods:
	|Methods Method 
	;


Method:
	Def Ident LP Formal_Args RP COLON Ident Statement_Block|
	Def Ident LP Formal_Args RP Statement_Block
	;

Def:
	DEF {cout<<"DEF \"def\""<<endl;}
	;
Idents:
	|COLON Ident 
	;

Statement_Block:
	LB Statements RB
	;

Statements:
	|Statements Statement
	;

L_Expr:
	Ident|
	R_Expr DOT Ident 
	;

R_Expr:
	STRING_LIT|
	INT_LIT|
	//L_Expr|
	R_Expr PLUS R_Expr|
	R_Expr MINUS R_Expr|
	R_Expr TIMES R_Expr|
	R_Expr DIVIDE R_Expr|
	LPARENTHESES R_Expr RPARENTHESES|
	R_Expr EQUALS R_Expr|
	R_Expr ATMOST R_Expr|
	R_Expr LESS R_Expr|
	R_Expr ATLEAST R_Expr|
	R_Expr MORE R_Expr|
	R_Expr AND R_Expr|
	R_Expr OR R_Expr|
	NOT R_Expr|
	R_Expr DOT Ident LPARENTHESES Actual_Args RPARENTHESES
	;

Actual_Args:
	|R_Expr R_Exprs
	;

R_Exprs:
	|R_Exprs  DOT R_Expr
	;
	
	
	
ENDLS:
	|ENDLS ENDL 
	;



	

*/

Empty:
;
%%

int main(int, char**) {
	// open a file handle to a particular file:
	FILE *myfile = fopen("input", "r");
	// make sure it's valid:
	if (!myfile) {
		cout << "I can't open the input file!" << endl;
		return -1;
	}
	// set lex to read from it instead of defaulting to STDIN:
	yyin = myfile;

	// parse through the input until there is no more:
	
	do {
		yyparse();
	} while (!feof(yyin));
	
}

void yyerror(const char *s) {
	cout << "EEK, parse error on line " << line_num << "!  Message: " << s << endl;
	// might as well halt now:
	exit(-1);
}
