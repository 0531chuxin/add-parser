%{
#include "calc.tab.h"
%}

%%
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
"+"     { return PLUS; }
\n      { return EOL; }
[ \t]   { /* 忽略空格和制表符 */ }
.       { printf("未知字符: %c\n", *yytext); }
%%

int yywrap() {
    return 1;
}
