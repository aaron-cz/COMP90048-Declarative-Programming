mySumList :: Num a => [a] -> a

mySumList [] = 0
mySumList (x:xs) =
    x + mySumList xs

data Gender = Female | Male
data Role = Staff | Student

data Suit = Club | Diamond | Heart | Spade 
    deriving (Show, Eq, Ord)
data Rank = R2 | R3 | R4 | R5 | R6 | R7 | R8 | R9 | R10 
    | Jack | Queen | King | Ace
    deriving Show
data Card = Card Suit Rank

-- Define a type to represent a naughts-and-crosses 
-- (tic-tac-toe) board.

data SquareContent = O | X | Empty
data Board = 
    Board 
    SquareContent SquareContent SquareContent
    SquareContent SquareContent SquareContent
    SquareContent SquareContent SquareContent

-- Define a type LibraryItem representing an item the library
-- loans to patrons: either a book or a periodical. Books have 
-- a catalogue number, title, and author. Periodicals have a 
-- catalogue number, a title, and a publication frequency. 
-- A publication frequency is either a number of days or of months.

data LibraryItem = 
    Book Integer String String | Periodical Integer String Period

data Period = Days Integer | Months Integer

-- Given the LibraryItem type, define a function title that 
-- will return the title of any LibraryItem

title :: LibraryItem -> String

title (Book _ title _) = title
title (Periodical _ title _) = title

{-
In Haskell, if a value is optional, you indicate this by 
using the maybe type defined in the prelude:

data Maybe t = Nothing | Just t
-}