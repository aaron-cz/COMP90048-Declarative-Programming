-- k and v are type variables
data Tree k v = Leaf | Node k v (Tree k v) (Tree k v)

{-
Write a type declaration for a polymorphic version
(that inserts into a sorted list of anything).
-}

listInsert :: ord t => t -> [t] -> [t]

listInsert x [] = [x]
listInsert x (y:ys)
    | x > y = y:listInsert x ys
    | otherwise = x:y:ys

{-
Write functions to evaluate a BoolExpr and a IntExpr
-}

data BoolExpr
    = BoolConst Bool
    | BoolOp BoolOp BoolExpr BoolExpr
    | CompOp CompOp IntExpr IntExpr

data IntExpr
    = IntConst Int
    | IntOp IntOp IntExpr IntExpr
    | IntIfThenElse BoolExpr IntExpr IntExpr

data BoolOp = And
data CompOp = LessThan
data IntOp = Plus | Times



boolExprValue :: BoolExpr -> Bool
boolExprValue (BoolConst b) = b
boolExprValue (BoolOp And e1 e2)
    = boolExprValue e1 && boolExprValue e2
boolExprValue (CompOp LessThan i1 i2)
    = intExprValue i1 < intExprValue i2


intExprValue :: IntExpr -> Int
intExprValue (IntConst i) = i
intExprValue (IntOp Plus i1 i2)
    = intExprValue i1 + intExprValue i2
intExprValue (IntOp Times i1 i2)
    = intExprValue i1 * intExprValue i2
intExprValue (IntIfThenElse b i1 i2) =
    if boolExprValue b
    then intExprValue i1
    else intExprValue i2