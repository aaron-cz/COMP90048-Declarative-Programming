module Lab1 (subst, interleave, unroll) where

subst :: Eq t => t -> t -> [t] -> [t]

subst a b (x:xs) = 
    if(a == x)
        then [b] ++ subst a b (xs)
    else
        [x] ++ subst a b (xs)

subst a b [] = []




interleave :: [t] -> [t] -> [t]

interleave (x:xs) (y:ys) = [x] ++ [y] ++ interleave xs ys
interleave [] y = y
interleave x [] = x




unroll :: Int -> [a] -> [a]

unroll n (x:xs) = 
    if n >= length (x:xs)
        then unroll n ((x:xs) ++ (x:xs))
    else
        if n >= 1
            then [x] ++ unroll (n-1) xs
        else
            []

unroll n [] = []