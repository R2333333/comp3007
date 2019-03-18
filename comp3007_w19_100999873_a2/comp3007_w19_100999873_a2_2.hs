--Base Code by Prof.Roert
--Modified by Roy Xu 100999873

import Comp3007_w19_100999873_a2_1

searchASCII :: [[Char]] ->[[Char]] -> (Int, Int)
searchASCII [] _ = (-1, -1)
searchASCII search find =
  let y = findLine 0 search find
  in ((findX 0 (search !! y) (find !! 0)),y)

lineCompare :: [Char] -> [Char] -> Bool
lineCompare _ [] = True
lineCompare [] _ = False
lineCompare (firstH:firstT) (secondH:secondT)
  | startCmp (firstH:firstT) (secondH:secondT) == False = lineCompare firstT (secondH:secondT)
  | otherwise  = True

startCmp :: [Char] -> [Char] -> Bool
startCmp _ [] = True
startCmp [] _ = False
startCmp (firstH:firstT) (secondH:secondT)
  | firstH == secondH = startCmp firstT secondT
  | otherwise = False

graphCompare :: [[Char]] -> [[Char]] -> Bool
graphCompare _ [] = True
graphCompare [] _ = False
graphCompare (firstH:firstT) (secondH:secondT)
  | lineCompare firstH secondH == True = graphCompare firstT secondT
  | otherwise = False

findLine :: Int -> [[Char]] -> [[Char]] -> Int
findLine _ [] _ = error "Not Found Image"
findLine pos (firsH:firstT) (secondH:secondT)
  | graphCompare (firsH:firstT) (secondH:secondT) == False = findLine (1 + pos) firstT (secondH:secondT)
  | otherwise = pos

findX :: Int -> [Char] -> [Char] -> Int
findX _ [] _ = error "Not Found Image"
findX pos (h:t) second
  | startCmp (h:t) second == False = findX (1 + pos) t second
  | otherwise = pos
