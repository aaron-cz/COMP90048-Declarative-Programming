-- Implement a function to perform the logical XOR
xor :: Bool -> Bool -> Bool
{-
xor x y =
    if x /= y
    then
        True
    else
        False
-}
xor x y 
    |  x /= y = True
    |  otherwise = False