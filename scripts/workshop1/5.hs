{- Implement a function ’getNthElem’ which takes
an integer ’n’ and a list, and
returns the nth element of the list. -}
getNthElem :: Int -> [t] -> t

getNthElem nth (x:xs) = 
    if nth <= 1
        then x
    -- if out of boundary, return the first element
    else if nth > length (x:xs)
        then x
    else
        getNthElem (nth - 1) xs