module Main where

import Data.Char (isDigit, digitToInt)
import System.IO (hFlush, stdout)

-- Question 1

{-
Recall the discussion of the Maybe monad in lectures, and the definitions
of maybe_head, maybe_sqrt and maybe_sqrt_of_head. In a similar style, write
Haskell code for the function

    maybe_tail :: [a] -> Maybe [a]

which returns the tail of a list if the list is not empty, and

    maybe_drop :: Int -> [a] -> Maybe [a]

which is like the prelude function drop ("drop n xs" drops the first n elements
of the list xs), but returns a Maybe type. If n is greater than the length
of xs, it should return Nothing (drop returns [] in this case), otherwise
it should return Just the resulting list.

Code two versions of maybe_drop. Both should use maybe_tail. One should
explicitly check for Nothing and the other should use >>=.
-}

maybe_tail :: [a] -> Maybe [a]

maybe_tail [] = Nothing
maybe_tail (_:xs) = Just xs


maybe_drop :: Int -> [a] -> Maybe [a]

maybe_drop 0 xs = Just xs
maybe_drop n xs
    | n > 0 = maybe_tail xs >>= maybe_drop (n-1)


maybe_drop' :: Int -> [a] -> Maybe [a]

maybe_drop' 0 xs = Just xs
maybe_drop' n xs | n > 0 =
        let mt = maybe_tail xs in
        case mt of
                Nothing -> Nothing
                Just xs1 -> maybe_drop' (n-1) xs1


-- QUESTION 2

{-Given the tree data type defined below, write the Haskell function

   print_tree :: Show a => Tree a -> IO ()

which does an inorder traversal the tree, printing the contents of each node
on a separate line. What are the advantages and disadvantages of this approach
compared to traversing the tree and returning a string, and then printing
the string?-}

data Tree a = Empty | Node (Tree a) a (Tree a)


print_tree :: Show a => Tree a -> IO ()

print_tree Empty = return ()
print_tree (Node l val r) = do
    print_tree l
    print val
    print_tree r


-- QUESTION 3

{-Write a Haskell function

    str_to_num :: String -> Maybe Int

that converts a string containing nothing but digits to Just the number they
represent, and any other string to Nothing. Hint: the standard library module
Data.Char has a function isDigit that tests whether a character is a decimal
digit, and another function digitToInt that converts such characters to a
number between between 0 and 9.-}

str_to_num :: String -> Maybe Int

str_to_num [] = Nothing
str_to_num (d:ds) = str_to_num_acc 0 (d:ds)


str_to_num_acc :: Int -> String -> Maybe Int

str_to_num_acc val [] = Just val
str_to_num_acc val (d:ds)
   | isDigit d = str_to_num_acc (10*val + digitToInt d) ds
   | otherwise = Nothing

-- QUESTION 4
{-Write two versions of a Haskell function that reads in a list of lines
containing numbers, and returns their sum. The function should read in lines
until it finds one that contains something other than a number.

The first version of the function should sum up the numbers as it read them in.
The second should collect the entire list of numbers before it starts summing
them up.-}

sum_lines :: IO Int
sum_lines = do
    nums <- list_num_lines
    return (sum nums)

list_num_lines :: IO [Int]
list_num_lines = do
   line <- getLine
   case str_to_num line of
       Nothing -> return []
       Just num -> do
           nums <- list_num_lines
           return (num:nums)


-- QUESTION 5
{-Write a Haskell main function that repeatedly reads in and executes commands
to implement a trivial phonebook program.  The commands it should support are:

    print           prints the entire phone book
    add name num    adds num as the phone number for name
    delete name     delete the entry for name
    lookup name     print the entries that match name
    quit            exit the program

To keep things simple, only check the first letter of commands (so people
can abbreviate commands to a single letter). You may assume that a name is
a single word, and that it must match exactly. You can use the Haskell
prelude function words to split a single string into a list of words.
If you print a prompt and expect to read the command on the same line,
you need to do hFlush stdout to ensure the prompt is written before reading
the user command.  To use this, you will need to import System.IO.-}

type Phonebook = [(String,String)]

main :: IO ()

main = phonebook []


phonebook :: Phonebook -> IO ()
phonebook pbook = do
    putStr "phonebook> "
    hFlush stdout
    command <- getLine
    case words command of
        [] -> phonebook pbook     -- empty command; just prompt again
        ((commandLetter:_):args) -> executeCommand pbook commandLetter args


executeCommand :: Phonebook -> Char -> [String] -> IO ()

executeCommand pbook 'p' [] =
    printPhonebook pbook >> phonebook pbook
executeCommand pbook 'a' [name,num] =
    phonebook $ pbook ++ [(name,num)] -- add to the end
executeCommand pbook 'd' [name] =
    phonebook $ filter ((/= name) . fst) pbook
executeCommand pbook 'l' [name] =
    printPhonebook (filter ((== name) . fst) pbook) >> phonebook pbook
executeCommand _ 'q' [] = return ()
executeCommand pbook 'h' [] = usage >> phonebook pbook
executeCommand pbook '?' [] = usage >> phonebook pbook
executeCommand pbook cmd _ = do
    putStrLn ("Unknown command letter '" ++ [cmd] ++ "'")
    usage
    phonebook pbook


printPhonebook :: Phonebook -> IO ()
printPhonebook = mapM_ (\(name,num) -> putStrLn $ name ++ " " ++ num)


usage :: IO ()
usage = putStrLn $ unlines [
        "Usage:",
        "    print           prints the entire phone book",
        "    add name num    adds num as the phone number for name",
        "    delete name     delete the entry for name",
        "    lookup name     print the entries that match name",
        "    quit            exit the program",
        "    help            display this usage message"]