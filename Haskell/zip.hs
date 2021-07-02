import Prelude hiding (zip)

zip :: [a] -> [b] -> [(a,b)]
zip []     ys    = []
zip xs    []     = []
zip (x:xs) (y:ys) = (x,y) : zip xs ys

main :: IO()
main = do print(zip [1, 2] ['a', 'b'])
          print(zip [1] ['a', 'b'])
