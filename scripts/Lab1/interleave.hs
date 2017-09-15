{-interleave :: [t] -> [t] -> [t]
interleave takes two lists and returns the 
interleaving of the two arguments. That, 
the result is a list in which the first, 
third, fifth . . . elements come fromt the 
first argument and the second, fourth, 
sixth . . . come from second. If either 
argument is shorter than the other, 
the excess elements of the longer comprise 
the end of the resulting list.-}

interleave :: [t] -> [t] -> [t]

interleave (x:xs) (y:ys) = [x] ++ [y] ++ interleave xs ys
interleave [] y = y
interleave x [] = x