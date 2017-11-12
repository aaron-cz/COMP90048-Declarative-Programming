-- QUESTION 1
{-Write a function fibs :: Int -> [Integer] which returns a list containing
the first n numbers in the Fibonacci sequence: [0,1,1,2,3,5,8,...], where
the third and subsequent numbers are the sum of the two preceeding numbers
(0+1=1, 1+1=2, 1+2=3, 2+3=5, etc). We use Integer rather than Int because
the numbers grow exponentially and therefore overflow native Ints quite
quickly. Is the algorithmic complexity of your solution acceptable?-}

fibs :: Integer -> [Integer]

fibs 0 = []
fibs 1 = [0]
fibs n
    | n > 1 = 0:1:fibs1 0 1 (n-2)

fibs1 :: Integer -> Integer -> Integer -> [Integer]

fibs1 fpp fp 0 = []
fibs1 fpp fp n = (fpp+fp) : fibs1 fp (fpp+fp) (n-1)