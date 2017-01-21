%{
#include <iostream>
#include "scanner.tab.h"
using namespace std;
#define YY_DECL extern "C" int yylex()
int line_num = 1;

%}
%option yylineno
%%
[ \t]         	;
\n             { ++line_num;}
[\/\/].*[\n]        	;
\/\*((\*[^/])|[^*])*\*\/    	; 


class 	       { return CLASS;}
extends	       { return EXTENDS;}
return         { return RETURN; }
def            { return DEF;}
if             { return IF;}
elif           { return ELIF;}
else           { return ELSE;}
while          { return WHILE;}
\(             { return LPARENTHESES;}
\)	       { return RPARENTHESES;}
\{	       { return LBRACES;}
\}             { return RBRACES;}
\:             { return COLON;}
\;             { return SEMICOLON;}

\>\=           { return ATLEAST;}
\<\=           { return ATMOST;}
\.             { return DOT;}
\<             { return LESS;}
\>             { return MORE;}

\=\=           { return EQUALS;}
\=             { return GETS;}
and            { return AND;}
or             { return OR;}
not            { return NOT;}
\+             { return PLUS;}
\-             { return MINUS;}
\*             { return TIMES;}
\%             { return DIVIDE;}

\,		{ return COMMA;}
       
[0-9]+\.[0-9]+ 	{  return FLOAT; }
[0-9]+         	{ return INT_LIT; }
[a-zA-Z_]+ 	{ return Ident;}
["][^"\n]*[\n]                            {return MISS;}
["].*\\[^0btnrf"\\].*["]		{return ILLEGAL;}

["](([\\][0btnrf"\\])|[^"\\\n])*["]  	{ return STRING_LIT;}



<<EOF>>         { return EOF;}

           
%%
