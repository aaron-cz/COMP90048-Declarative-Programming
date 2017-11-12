-- @Author  : Hanwei Zhu
-- @Email   : hanweiz@student.unimelb.edu.au
-- @File    : quiz2.hs

countDown :: Int -> IO ()

countDown n
    | n < 0 = putStrLn "Done"
    | otherwise = do
        print n
        countDown (n - 1)


-- Write a function
-- recycle :: [t] -> [t]
-- to generate an infinite list of repetitions of the 
-- elements of its input
recycle :: [t] -> [t]
recycle l = recycle' l l

recycle' :: [t] -> [t] -> [t]
recycle' [] l = recycle' l l
recycle' (x:xs) l = x:recycle' xs l

recycle1 l = l ++ recycle1 l