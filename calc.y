%{
#include <stdio.h>
%}

%token NUMBER PLUS EOL

%%
calclist:
    | calclist expr EOL { printf("计算结果: %d\n", $2); }
    ;

expr:
    NUMBER { $$ = $1; }
    | expr PLUS NUMBER { $$ = $1 + $3; }
    ;
%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "错误: %s\n", s);
    return 0;
}
