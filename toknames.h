#ifndef _NAMES_H_
#define __NAMES_H

typedef struct{
char* name;
int num; 
}Token ;



Token token_name_table[] = {{"EXTENDS",258},{  "CLASS" ,259},{"WHILE" , 260},{   "WHILE" , 260},{"IF" , 261},{"ELSE",262},{"ELIF",263},{"RETURN" ,264},{"DEF",265},{"ENDL",266},{":",267},{";",268},{"(",269},{")",270},{"{",271},{"}",272},{".",273},{",",274},{"PLUS",275},{"MINUS",276},{"TIMES",277},{"DIVIDE",278},{"MORE",279},{"ALMOST",280},{"LESS",281},{"ATLEAST",282},{"EQUALS",283},{"NOT",284},{"AND",285},{"OR",286},{"GETS",287},{"ILLEGAL",288},{"MISS",289},{"INT_LIT",290},{"FLOAT",291},{"STRING_LIT",292},{"IDENT",293}};
const int num_named_tokens = 37;


#endif
