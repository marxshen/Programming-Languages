findSum :: [Int] -> Int -> [(Int, Int)]
findSum xs sum = trim [(x, y) | ys <- sets xs
                              , len ys == 2
                              , let x = head ys
                              , let y = head (tail ys)
                              , (+ x) y == sum]

extendedFindSum :: [Int] -> [(Int, [(Int, Int)])]
extendedFindSum xs = merge $ trim [(sum, (x, y)) | ys <- sets xs
                                                 , len ys == 2
                                                 , let x = head ys
                                                 , let y = head (tail ys)
                                                 , let sum = (+ x) y]

len :: [a] -> Int
len = foldr (\_ n -> 1+n) 0

trim :: Eq a => [a] -> [a]
trim [] = []
trim (x:xs) = x : [y | y <- trim xs, x /= y]

merge :: [(Int, (Int, Int))] -> [(Int, [(Int, Int)])]
merge xs = do let parse = \ls -> (fst $ head ls, map snd ls)
              map parse $ classify (\a b -> fst a == fst b) $ sort xs

sort :: (Ord a) => [(a, (a, a))] -> [(a, (a, a))]
sort [] = []
sort (x:xs) = sort [y | y <- xs, fst y <= fst x]
              ++ [x] ++
              sort [y | y <- xs, fst y > fst x]
                    
classify :: (a -> a -> Bool) -> [a] -> [[a]]
classify _ []       = []
classify cmp (x:xs) = let (ts,fs) = span (cmp x) xs
                      in (x:ts) : classify cmp fs

sets :: [a] -> [[a]]
sets xs = [] : valSets xs

valSets :: [a] -> [[a]]
valSets sets = case sets of
                 [] -> []
                 (x:xs) -> let acc `op` ret = acc : (x:acc) : ret
                           in [x] : foldr op [] (valSets xs)

main :: IO ()
main = do putStrLn "findSum:"
          print(findSum [1,3,8,12,7,11,9,4,2,10,5] 12)
          putStrLn "extendedFindSum:"
          print(extendedFindSum [1,3,8,12,7,11,9,4,2,10,5])