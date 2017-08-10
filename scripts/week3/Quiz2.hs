-- delete the negative number

filter_neg :: (Ord t, Num t) => [t] -> [t]

filter_neg [] = []
filter_neg (x:xs)
    | x < 0 = filter_neg xs
    | x >= 0 = [x] ++ (filter_neg xs)