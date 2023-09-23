%token <int> INT
%token PLUS
%token MINUS
%token TIMES
%token DIV
%token MOD
%token LPAREN
%token RPAREN
%token EOF

%left PLUS MINUS
%left TIMES DIV MOD

%start <Ast.expr> prog

%%

prog:
  | e = expr; EOF { e }
  ;

expr:
  | i = INT { Int i }
  | e1 = expr; TIMES; e2 = expr { BinOp (Mul, e1, e2) }
  | e1 = expr; DIV; e2 = expr { BinOp(Div, e1, e2) }
  | e1 = expr; MOD; e2 = expr { BinOp(Mod, e1, e2) }
  | e1 = expr; PLUS; e2 = expr { BinOp (Add, e1, e2) }
  | e1 = expr; MINUS; e2 = expr { BinOp(Sub, e1, e2) }
  | PLUS; e = expr { UnaryOp(Pos, e) }
  | MINUS; e = expr { UnaryOp(Neg, e) }
  | LPAREN; e = expr; RPAREN { e }
  ;