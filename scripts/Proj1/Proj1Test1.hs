--  File     : proj1test.hs
--  RCS      : $Id$
--  Author   : Peter Schachte
--  Origin   : Sat Aug 20 22:06:04 2011
--  Purpose  : Test program for proj1 project submissions

module TestPro1 where

import Data.List
import System.Environment
import System.Exit
import Proj1
import Debug.Trace

-- | Compute the correct answer to a guess.  First argument is the 
--   target, second is the guess.
response :: [String] -> [String] -> (Int,Int,Int)
response target guess = (right, rightNote, rightOctave)
  where guess'      = nub guess
        right       = length $ intersect guess' target
        num         = length guess'
        rightNote   = num - (length $ deleteFirstsBy (eqNth 0) guess' target) 
                    - right
        rightOctave = num - (length $ deleteFirstsBy (eqNth 1) guess' target) 
                    - right


-- | eqNth n l1 l2 returns True iff element n of l1 is equal to 
--   element n of l2.
eqNth :: Eq a => Int -> [a] -> [a] -> Bool
eqNth n l1 l2 = (l1 !! n) == (l2 !! n)


-- |Returns whether or not the chord passed in is a valid chord.  A
-- chord is valid if it is a list of exactly three valid pitches with 
-- no repeats.
validChord :: [String] -> Bool
validChord chord =
  length chord == 3 && nub chord == chord && all validPitch chord 

    
-- |Returns whether or not its argument is a valid pitch.  That is, it
-- is a two-character strings where the first character is between 'A'
-- and 'G' (upper case) and the second between '1' and '3'.
validPitch :: String -> Bool
validPitch note =
  length note == 2 && 
  note!!0 `elem` ['A'..'G'] && 
  note!!1 `elem` ['1'..'3']

choose :: [String] -> Int -> [[String]]
choose _ 0 = [[]]
choose [] _ = []
choose (x:xs) n = (map (\ys -> x:ys) (choose xs (n-1))) ++ (choose xs n)

allPossible :: [[String]]
allPossible = choose ["A1","A2","A3","B1","B2","B3","C1","C2","C3","D1","D2","D3","E1","E2","E3","F1","F2","F3","G1","G2","G3"] 3
-- | Main program.  Gets the target from the command line (as three
--   separate command line arguments, each a note letter (upper case)
--   followed by an octave number.  Runs the user's initialGuess and
--   nextGuess functions repeatedly until they guess correctly.
--   Counts guesses, and prints a bit of running commentary as it goes.


testProj1 :: [[String]]-> Int
(guess,other) = initialGuess
testProj1 [] = 0
testProj1 (x:xs) = trace("pitch:" ++ show x) (loop x guess other 1) + (testProj1 xs)


loop :: [String] -> [String] -> Proj1.GameState -> Int -> Int
loop target guess other guesses
  | response target guess == (3,0,0) = guesses
  | otherwise = loop target guess' other' (guesses+1)
    where (guess',other') = nextGuess (guess,other) (response target guess)