myMaximum          :: (Ord a) => [a] -> a
myMaximum []       = errorWithoutStackTrace "empty list"
myMaximum [x]      = x
myMaximum (x:y:xs)
    | x > y        = myMaximum (x:xs)
    | otherwise    = myMaximum (y:xs)

myIntersection               :: (Eq t) => [t] -> [t] -> Bool
myIntersection _ []          = True
myIntersection [] _          = True
myIntersection (x:xs) ys
    | notExist x ys == False = False
    | otherwise              = myIntersection xs ys

notExist          :: (Eq t) => t -> [t] -> Bool
notExist _ []     = True
notExist x (y:ys)
    | x == y      = False
    | otherwise   = notExist x ys
    
myUnion       :: (Eq a) => [a] -> [a] -> [a]
myUnion xs [] = xs
myUnion [] ys = ys
myUnion xs ys = trim $ xs ++ ys

trim        :: Eq a => [a] -> [a]
trim []     = []
trim (x:xs) = x : [y | y <- trim xs, x /= y]

myFinal        :: [a] -> a
myFinal []     = errorWithoutStackTrace "empty list"
myFinal [x]    = x
myFinal (_:xs) = myFinal xs

myAllPairs           :: (Eq a, Eq b) => [a] -> [b] -> [(a,b)]
myAllPairs _ []      = []
myAllPairs [] _      = []
myAllPairs (x:xs) ys = trim $ [(x,y) | y <- ys] ++ myAllPairs xs ys