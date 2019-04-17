--Roy Xu 100999873
countZeroFree :: [Int] -> Int
countZeroFree list = zeroFree list 0

zeroFree :: [Int] -> Int -> Int
zeroFree [] ans = ans
zeroFree (h:t) ans = zeroFree t (ans + zeroF h)

zeroF :: Int -> Int
zeroF a
  | a < 0 = error "NO NEGATIVE VALUES!!!"
  | a == 0 = 0
  | a < 10 = 1
  | (myRem a 10) == 0 = 0
  | otherwise = zeroF (myDiv a 10 1)

x :: Int
x = 10

y :: Int
y = 12

myRem :: Int -> Int -> Int
myRem a b
  | a < b = b
  | otherwise = a - (myDiv a b 1) * b

myDiv :: Int -> Int -> Int -> Int
myDiv _ 0 _ = error "cannot divided by 0"
myDiv a b c
  | a < b*c = c-1
  | a == b*c = c
  | otherwise = myDiv a b (c + 1)
