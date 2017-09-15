--subst takes two values and a list, and replaces every occurrence of the first value with the second in the list.

subst :: Eq t => t -> t -> [t] -> [t]

subst a b (x:xs) = 
    if(a == x)
        then [b] ++ subst a b (xs)
    else
        [x] ++ subst a b (xs)

subst a b [] = []