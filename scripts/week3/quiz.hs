-- representation of binary search trees
data Tree = Leaf | Node String Int Tree Tree

-- How would you represent “maybe a tree, maybe nothing” in Haskell?

-- Maybe Tree

-- Searching a BST in Haskell
search_bst :: Tree -> String -> Maybe Int
search_bst Leaf _ = Nothing
search_bst (Node k v l r) sk
    | sk == k = Just v
    | sk < k = search_bst l sk
    | otherwise = search_bst r sk



-- Write a Haskell function to filter out the negative 
-- numbers from a list. Begin with a type declaration.

nonNegElts :: (Ord t, Num t) => [t] -> [t]

nonNegElts [] = []
nonNegElts (x:xs)
    | x < 0 = nonNegElts xs
    | otherwise = x:(nonNegElts xs)

-- Write a type declaration for a Haskell function to insert 
-- an element into a sorted list of Ints.
listInsert :: Int -> [Int] -> [Int]
listInsert v [] = [v]
listInsert v (x:xs)
    | v > x = x:listInsert v xs
    | otherwise = v:x:xs

-- One can build a BST by starting with the empty tree and
-- inserting key/value pairs into it.

assoc_list_to_bst :: [(String, Int)] -> Tree 
assoc_list_to_bst [] = Leaf
assoc_list_to_bst ((hk, hv):kvs) =
    let t0 = assoc_list_to_bst kvs in
    insert_bst t0 hk hv

-- Updating a BST
insert_bst :: Tree -> String -> Int -> Tree
insert_bst Leaf ik iv = Node ik iv Leaf Leaf
insert_bst (Node k v l r) ik iv
    | ik == k = Node ik iv l r
    | ik < k = Node k v (insert_bst l ik iv) r
    | otherwise = Node k v l (insert_bst r ik iv)


