-- any :: (a -> Bool) -> [a] -> Bool
-- all :: (a -> Bool) -> [a] -> Bool

-- returns the (infinite) list of all primes 
all_primes :: [Integer]
all_primes = prime_filter [2..]

prime_filter :: [Integer] -> [Integer]
prime_filter [] = []
prime_filter (x:xs) =
    x:prime_filter (filter (not . (`divisibleBy` x)) xs)

-- n ‘divisibleBy‘ d means n is evenly divisible by d
divisibleBy n d = n `mod` d == 0

-- take n all_primes


-- $ is of type(a->b)->a->b
greet :: IO ()
greet = do
    putStr "Greetings! What is your name? "
    name <- getLine
    putStr "Where are you from? "
    town <- getLine
    putStrLn $ "Welcome, " ++ name ++ " from " ++ town


main :: IO ()
main = do
    putStrLn "Please input a string"
    len <- readlen
    putStrLn $ "The length of that string is " ++ show len

readlen :: IO Int
readlen = do
    str <- getLine
    return (length str)