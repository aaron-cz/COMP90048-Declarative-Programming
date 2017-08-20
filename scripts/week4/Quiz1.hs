{-
Write a type declaration for a Haskell function to insert 
an element into a sorted list of Ints
-}

listInsert :: Int -> [Int] -> [Int]

listInsert x [] = [x]
listInsert x (y:ys)
    | x > y = y:listInsert x ys
    | otherwise = x:y:ys