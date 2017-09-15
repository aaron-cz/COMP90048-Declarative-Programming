{- unroll takes a list and an integer 
and constructs a list of the specified 
length made up by “unrolling” the input 
list as many times as needed to construct 
a list of that length. That is, the output 
consists of the input list repeated as many 
times as necessary to have the specified 
length.
-}

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