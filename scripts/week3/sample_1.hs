data Expr
    = Number Int
    | Variable String
    | Binop Binop Expr Expr
    | Unop Unop Expr

data Binop = Plus | Minus | Times | Divide
data Unop = Negate