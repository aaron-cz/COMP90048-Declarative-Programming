-- Implement your own version of the ’reverse’ function
myReverse :: [t] -> [t]
myReverse (x:xs) = (myReverse xs) ++ [x]
myReverse [] = []