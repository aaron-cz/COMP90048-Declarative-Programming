main ::IO ()

main = do
    putStrLn "Input a positive number:"
    n <- getLine
    putStrLn "Table of squares:"
    print_table 1 $ read n


print_table :: Int -> Int -> IO () 

print_table cur max
    | cur > max = return () 
    | otherwise = do
        putStrLn (table_entry cur) 
        print_table (cur+1) max


table_entry :: Int -> String
table_entry n = (show n) ++ "^2 = " ++ (show (n*n))

hello :: IO ()
hello =
    putStr "Hello, "
    >>=
    \_ -> putStrLn "world!"