-- Question 2
{-
Implement a function ftoc :: Double −> Double, which converts a temperature
in Fahrenheit to Celsius. Recall that C = (5/9) * (F − 32).
What is the inferred type of the function if you comment out the type
declaration? What does this tell you?
-}

-- ftoc :: Double -> Double

ftoc f = (5/9) * (f - 32)

-- the inferred type: 
-- ftoc :: Fractional a => a -> a

{-
QUESTION 3
Implement a function quadRoots :: Double −> Double −> Double −> [Double],
which computes the roots of the quadratic equation defined by
0 = a*x^2 + b*x + c, given a, b, and c.  See
http://en.wikipedia.org/wiki/Quadratic_formula for the formula.
What is the inferred type of the function if you comment out the type
declaration? What does this tell you?
-}

quadRoots :: Double -> Double -> Double -> [Double]

quadRoots 0 0 _ = error "Either a or b must be non-zero"
quadRoots 0 b c = [-c / b]
quadRoots a b c
    | disc < 0  = error "No real solutions"
    | disc == 0 = [tp]
    | disc > 0  = [tp + temp, tp - temp]
    where   disc = b*b - 4*a*c
            temp = sqrt(disc) / (2*a)
            tp   = -b / (2*a)

-- quadRoots :: (Floating a, Ord a) => a -> a -> a -> [a]
-- Floating include float and double


{-
QUESTION 4
Write a Haskell function to merge two sorted lists into a single 
sorted list
-}

merge :: Ord a => [a] -> [a] -> [a]

merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x <= y = x:(merge xs ys)
    | otherwise = y:(merge xs ys)


{-
QUESTION 5
Write a Haskell version of the classic quicksort algorithm for lists.
(Note that while quicksort is a good algorithm for sorting arrays, 
it is not actually that good an algorithm for sorting lists; variations
of merge sort generally perform better. However, that fact has no 
bearing on this exercise.)
-}

qsort1 :: (Ord a) => [a] -> [a]

qsort1 [] = []
qsort1 (pivot:xs) = qsort1 lesser ++ [pivot] ++ qsort1 greater
    where
        lesser = filter (<pivot) xs
        greater = filter (>= pivot) xs

{-
QUESTION 6
Given the following type definition for binary search trees 
from lectures,
>data Tree k v = Leaf | Node k v (Tree k v) (Tree k v)
>        deriving (Eq, Show)

define a function

>same_shape :: Tree a b -> Tree c d -> Bool

which returns True if the two trees have the same shape: same 
arrangement of nodes and leaves, but possibly different keys and 
values in the nodes.
-}
data Tree k v = Leaf | Node k v (Tree k v) (Tree k v)
        deriving (Eq, Show)

same_shape :: Tree a b -> Tree c d -> Bool

same_shape Leaf Leaf = True
same_shape Leaf (Node _ _ _ _) = False
same_shape (Node _ _ _ _) Leaf = False
same_shape (Node _ _ l1 r1) (Node _ _ l2 r2) =
    same_shape l1 l2 && same_shape r1 r2 


{-
QUESTION 7
Consider the following type definitions, which allow us to represent
expressions containing integers, variables "a" and "b", and operators
for addition, subtraction, multiplication and division.
-}

data Expression
       = Var Variable
       | Num Integer
       | Plus Expression Expression
       | Minus Expression Expression
       | Times Expression Expression
       | Div Expression Expression

data Variable = A | B

{-
For example, we can define exp1 to be a representation of 2*a + b
as follows:

>exp1 = Plus (Times (Num 2) (Var A)) (Var B)

Write a function eval :: Integer -> Integer -> Expression -> Integer
which takes the values of a and b and an expression, and returns the
value of the expression. For example eval 3 4 exp1 = 10.
-}

eval :: Integer -> Integer -> Expression -> Integer

eval a b (Var A) = a
eval a b (Var B) = b
eval a b (Num n) = n
eval a b (Plus  e1 e2) = (eval a b e1) + (eval a b e2)
eval a b (Minus e1 e2) = (eval a b e1) - (eval a b e2)
eval a b (Times e1 e2) = (eval a b e1) * (eval a b e2)
eval a b (Div   e1 e2) = (eval a b e1) `div` (eval a b e2)