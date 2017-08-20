{-
Write a type declaration for a polymorphic version
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
    | BoolOp BoolOp BoolExpr BoolExpr | CompOp CompOp IntExpr IntExpr
data IntExpr
     = IntConst Int
    | IntOp IntOp IntExpr IntExpr
    | IntIfThenElse BoolExpr IntExpr IntExpr

data IntOp = Plus | Times | IntIfThenElse 
data BoolOp = And


boolVal :: BoolExpr -> Bool

boolVal (BoolConst b) = b
boolVal (BoolOp And x y) = boolVal x && boolVal y
boolVal (CompOp LessThan x y) = intVal x < intVal y


intVal :: IntExpr -> Int

intVal (IntConst i) = i
intVal (IntOp Plus x y) = intVal x + intVal y
intVal (IntOp Times x y) = intVal x * intVal y
intVal (IntIfThenElse b t e) = 
    if boolVal b
        then intVal t
    else intVal e






