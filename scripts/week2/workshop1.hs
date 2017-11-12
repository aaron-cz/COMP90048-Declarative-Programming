-- QUESTION 1
{- What are the most annoying limitations of a programming language you
have used?  It would be good if you posted something on this topic to
the LMS discussion forum.-}

{-
This question is intended to provoke general discussion about programming
languages. Often, you don't miss some feature (or recognise a limitation)
until you have programmed in a language which has that feature.
For example, after programming in Haskell, many people see the lack of
e.g. discriminated union types and convenient higher order programming
features in languages like C, Java and Python as annoying limitations. (C
does not support closures in their full generality. It supports function
pointers, which are like closures that contain no hidden arguments. This
limitation makes higher order programming much more tedious.)

Learning different programming languages enriches us as programmers
and also allows us to make better choices of which tools to use to solve
each problem.
-}

-- QUESTION 2
{-What are some useful Haskell resources on the web?-}

{-
ANSWER
The site haskell.org has a good collection, including the classic Gentle
Introduction To Haskell (perhaps not quite gentle enough for the average
computer science undergraduate). The web is a great resource for information
about programming languages, libraries etc. There is never enough time
in lectures (or workshops) to cover every significant feature of any
programming language.

Note that the web is generally not a good resource for solving programming
assignments and other forms of assessment. Apart from the issue that
using other people's code in assignments that are meant to be your own
work is a violation of ethical rules, code from the web rarely solves
the exact problem an assignment asks you to solve, and adapting the web
code to your needs typically requires as much work as writing the code
from scratch. This is because to adapt the code to your needs, you must
first understand it.
-}

-- QUESTION 3
{-
What will be printed by this C code fragment?

    #include <stdio.h>
        int f(int x, int y)
        {
                return 10 * x + y;
        }

        int main(void)
        {
                int i, j;

                i = 0;
                j = f(++i, ++i);
                printf("%d\n", j);
        return 0;
        }

What does this show about the impact of side effects in C?
-}

-- QUESTION 4
{-What are the most annoying limitations of a programming language you
have used?  It would be good if you posted something on this topic to
the LMS discussion forum.-}

len :: [t] -> Int

len [] = 0
len (x:xs) = 1 + len xs


-- QUESTION 5
{-Implement a function to perform the logical XOR (exclusive or)
operation. The XOR of two truth values is true if exactly one of them
is true.  You may approach this using pattern matching or using other
logical operations.-}
xor :: Bool -> Bool -> Bool

xor x y 
    |  x /= y = True
    |  otherwise = False


-- QUESTION 6
{-Implement your own versions of the 'head' and 'tail' functions included in
the Haskell Prelude. Do not use the existing 'head' and 'tail' functions in
your implementation. Note you should call your functions 'myHead' and 
'myTail' to avoid shadowing the existing functions. -}
myHead :: [t] -> t

myHead [x] = x
myHead (x:_) = x


myTail :: [t] -> t

myTail [x] = x
myTail (_:xs) = myTail xs


-- QUESTION 7
{-Implement your own version of the 'reverse' function included in the Haskell
Prelude. Do not use the existing 'reverse' function in your implementation.
Note you should call your function 'myReverse' to avoid shadowing the 
existing function.-}
myReverse :: [t] -> [t]

myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- QUESTION 8
{-Implement a function 'getNthElem' which takes an integer 'n' and a list, and
returns the nth element of the list.-}
getNthElem :: Int -> [t] -> t

getNthElem nth (x:xs) = 
    if nth <= 1
        then x
    -- if out of boundary, return the first element
    else if nth > length (x:xs)
        then x
    else
        getNthElem (nth - 1) xs
