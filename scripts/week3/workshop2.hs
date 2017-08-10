-- Question 2
{-
Define a Haskell type for representing "font" tags in HTML. A font tag
can specify zero or more of the following: the size in points (e.g. 10),
the face (e.g. "courier") and the colour. The colour can be described
using a colour name (e.g., "red"), a six−digit hexidecimal number
(e.g. #02EA1F) or a RGB triple of numbers (e.g. rgb(255,100,0)).
-}
type Font_tag = [Font_specifier]
data Font_specifier 
    =  Size Int
    | Face String
    | Colour Colour

data Colour = Name String | Hexidecimal Int | RGB (Int, Int, Int)


-- Question 3
{-
Implement a function ’factorial’ that computes the factorial of a given
integer.  Include a type declaration.
-}

factorial :: Int -> Int

factorial 0 = 1
factorial n = n * factorial (n - 1)


-- Question 4
{-
Implement a function ’myElem’ which returns True if a given item is 
present in a given list.  Include a type declaration.
-}

myElem :: Eq t => t -> [t] -> Bool

myElem _ [] = False
myElem n (x:xs)
    | n == x = True
    | otherwise = myElem n xs


-- Question 5
{-
Implement a function ’longestPrefix’ which returns the longest common prefix
of two lists. ie: When applied to "extras" and "extreme", the function
should return "extr".
-}

longestPrefix :: [Char] -> [Char] -> [Char]

longestPrefix _ [] = []
longestPrefix [] _ = []
longestPrefix (a:as) (b:bs)
    | a == b = [a] ++ longestPrefix as bs
    | otherwise = []


-- Question 6
{-
Without necessarily understanding the code, translate the following
C function into Haskell.
int mccarthy_91(int n)
{
    int c = 1;
    while (c != 0) {
        if (n > 100) {
            n = n − 10;
            c−−;
        } else {
            n = n + 11;
            c++; }
        }
    }
    
    return n;
}
-}


mccarthy_91 :: Int -> Int

mccarthy_91 n = mywhile (1, n)

mywhile x =
   if cond x then mywhile (next_version_of x)
   else final_version_of x

cond (c,n) = c /= 0
next_version_of (c,n) =
   if n > 100 then (c-1, n-10) else (c+1, n+11)
final_version_of (c,n) = n

-- Question 7
{-
Write a Haskell function which takes two integers, min and max, and
returns a list of integers from min to max, inclusive.  Note there are
two different strategies to solve this problem: we can build up the list
from min to max or backwards, from max to min.  How does your Haskell
code compare with a version in an imperative language such as C, and how
would you reason about the correctness of a C version?
-}

minToMax :: Int -> Int -> [Int]

minToMax min max
    | min > max = []
    | otherwise = [min] ++ minToMax (min + 1) max