{-
QUESTION 1
Write a Haskell version of the tree sort algorithm, which inserts
all the to-be-sorted data items into a binary search tree, then performs
an inorder traversal to extract the items in sorted order. Use simple
structural induction where possible.
-}

data Tree a = Empty | Node (Tree a) a (Tree a)


treeSort :: Ord a => [a] -> [a]

treeSort xs = tree_inorder (list_to_bst xs)



list_to_bst :: Ord a => [a] -> Tree a

list_to_bst [] = Empty
list_to_bst (x:xs) = bst_insert x (list_to_bst xs)



bst_insert :: Ord a => a -> Tree a -> Tree a

bst_insert i Empty = Node Empty i Empty
bst_insert i (Node l v r)
    | i <= v = (Node (bst_insert i l) v r)
    | i > v = (Node l v (bst_insert i r))


tree_inorder :: Ord a => Tree a -> [a]

tree_inorder Empty = []
tree_inorder (Node l v r) = (tree_inorder l) ++ [v] ++ (tree_inorder r)


{-
QUESTION 2
Write a Haskell function to "transpose" a list of lists. You may assume that
all lists are non-empty, and that the inner lists are all the same length.
If you are given a list of N lists, each of length M, the result should be
a list of M lists, each of length N. For example,

        transpose [[1,2],[4,4],[8,9]]

should return

    [[1,4,8],[2,4,9]]
-}

transpose :: [[a]] -> [[a]]
transpose [] = error "transpose of zero-height matrix"
transpose list@(xs:xss)
  | len > 0   = transpose' len list
  | otherwise = error "transpose of zero-width matrix"
  where len = length xs

transpose' :: Int -> [[a]] -> [[a]]
transpose' len [] = replicate len []
transpose' len (xs:xss)
  | len == length xs = zipWith (:) xs (transpose' len xss)
  | otherwise = error "transpose of non-rectangular matrix"

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] [] = []
zipWith _ [] (_:_) = error "zipWith: list length mismatch"
zipWith _ (_:_) _ = error "zipWith: list length mismatch"
zipWith f (x:xs) (y:ys) = (f x y):(zipWith f xs ys)

{-
QUESTION 3
Write a Haskell function which takes a list of numbers and returns
a triple containing the length, the sum of the numbers, and the sum of the
squares of the numbers. Try coding this with (1) three separate traversals
of the list and (2) a single traversal of the list.
-}

stats1 :: [Int] -> (Int, Int, Int)
stats1 ns = (length ns, sum ns, sumsq ns)


sumsq :: [Int] -> Int
sumsq [] = 0
sumsq (n:ns) = n*n + sumsq ns

stats2 :: [Int] -> (Int, Int, Int)
stats2 [] = (0,0,0)
stats2 (n:ns) =
   let (l,s,sq) = stats2 ns
   in (l+1, s+n, sq+n*n)