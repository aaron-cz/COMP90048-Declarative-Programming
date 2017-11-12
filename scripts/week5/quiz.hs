myFilter :: (a -> Bool) -> [a] -> [a]

myFilter _ [] = []
myFilter f (x:xs) =
    if f x
        then x:fxs
        else fxs
    where fxs = myFilter f xs


myMap :: (a -> b) -> [a] -> [b]
myMap _ [] = []
myMap f (x:xs) = (f x):(myMap f xs)


myFoldl :: (v -> e -> v) -> v -> [e] -> v
myFoldl _ base [] = base
myFoldl f base (x:xs) =
    let newbase = f base x in
    myFoldl f newbase xs



myBalanced_fold :: (e -> e -> e) -> e -> [e] -> e
myBalanced_fold _ b [] = b
myBalanced_fold _ _ (x:[]) = x
myBalanced_fold f b l@(_:_:_) =
     let
        len = length l
        (half1, half2) = splitAt (div len 2) l
        value1 = myBalanced_fold f b half1
        value2 = myBalanced_fold f b half2
     in
         f value1 value2

{-
Here is a definition of hypotenuse:
square x = x ^ 2
hypotenuse sides = sqrt (sum (map square sides)) 
Rewrite the hypotenuse function in point-free style.
-}
square x = x ^ 2

hypotenuse = sqrt . sum . (map square)

-- List comprehension

qs2 [] = []
qs2 (x:xs) = qs2 littles ++ [x] ++ qs2 bigs
    where
        littles = [l | l <- xs, l < x]
        bigs = [b | b <- xs, b >= x]


chess_squares = [[c, r] | c <- columns, r <- rows]
    where
        columns = "abcdefgh"
        rows = "12345678"

-- What is the type of the map function?
-- map :: (a -> b) -> [a] -> [b]

-- What is the type of the (+1) function?
-- Num a => a -> a

-- What is the type of the map (+1) function?
-- Num a => [a] -> [a]