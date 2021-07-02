longestString :: String -> String
longestString xs = [y | let ys = chop xs
                      , ys /= []
                      , y <- maxby (cmp len) ys]

extendedLongestString :: String -> [String]
extendedLongestString xs = [y | let ys = chop xs
                              , ys /= []
                              , let maxLen = len (maxby (cmp len) ys)
                              , y <- ys
                              , len y == maxLen
                              , y /= ""]

chop :: String -> [String]
chop "" = []
chop xs = do let (_, ys) = span issp xs
             let (word, ret) = span nosp ys in word : chop ret

len :: [a] -> Int
len = foldr (\_ n -> 1+n) 0

nosp :: Char -> Bool
nosp c = not $ issp c

issp :: Char -> Bool
issp c = c == ' ' || fromEnum c - fromEnum '\t' <= 4 || fromEnum c == 0xa0

maxby :: (a -> a -> Ordering) -> [a] -> a
maxby cmp = foldl1 (\a b -> if cmp a b == GT then a else b)

cmp :: (Ord a) => (b -> a) -> b -> b -> Ordering
cmp pred a b = compare (pred a) (pred b)

main :: IO ()
main = do putStrLn "longestString:"
          print(longestString "Programming languages are awesomeeeeee")
          putStrLn "extendedLongestStrings:"
          print(extendedLongestString "string abcdef ghi jk l")