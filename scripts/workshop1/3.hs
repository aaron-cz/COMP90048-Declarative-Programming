-- Implement a function to append two lists
append :: [t] -> [t] -> [t]

append x (y:ys) = append (x++[y]) ys
append x [] = x