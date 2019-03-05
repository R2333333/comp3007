--Author: Roy Xu 100999873
--All Right Reserved

module Comp3007_w19_100999873_a2_1
  ( loadBitmap
  , convertToASCIIArt
  ) where

import Codec.BMP
import Data.ByteString
import Data.Either
import GHC.Word
import System.IO.Unsafe

loadBitmap :: FilePath -> [[(Int, Int, Int)]]
loadBitmap filename = repackAs2DList (either returnEmptyOnError processDataOnBMP (unsafePerformIO (readBMP filename)))
  
returnEmptyOnError :: Error -> ([(Int, Int, Int)], (Int, Int))
returnEmptyOnError _ = ([], (0, 0))

processDataOnBMP :: BMP -> ([(Int, Int, Int)], (Int, Int))
processDataOnBMP bmp = ((parseIntoRGBVals (convertToInts (unpack (unpackBMPToRGBA32 bmp)))), (bmpDimensions bmp))
  
convertToInts :: [Word8] -> [Int]
convertToInts [] = []
convertToInts (h:t) = (fromIntegral (toInteger h)) : (convertToInts t)

parseIntoRGBVals :: [Int] -> [(Int, Int, Int)]
parseIntoRGBVals [] = []
parseIntoRGBVals (h:i:j:_:t) = (h,i,j) : (parseIntoRGBVals t)

repackAs2DList :: ([(Int, Int, Int)], (Int, Int)) -> [[(Int, Int, Int)]]
repackAs2DList (pixels, (width, height)) = (Prelude.reverse (repackAs2DList' pixels width height))

repackAs2DList' :: [(Int, Int, Int)] -> Int -> Int -> [[(Int, Int, Int)]]
repackAs2DList' []  width  height = []
repackAs2DList' pixels width height = (Prelude.take width pixels) : (repackAs2DList' (Prelude.drop width pixels) width height)

showAsASCIIArt :: [[Char]] -> IO ()
showAsASCIIArt pixels = Prelude.putStr (unlines pixels)

convertToASCIIArt :: [Char] -> Bool -> [[(Int, Int, Int)]] -> [[Char]]
convertToASCIIArt _ _ [] = []
convertToASCIIArt shade flip (h:t) = (line h shade flip) : (convertToASCIIArt shade flip t)

line :: [(Int, Int, Int)] -> [Char] -> Bool -> [Char]
line [] _ _ = []
line ((r, g, b):t) shade flip
  | flip == True = (convertPixel (fromIntegral r, fromIntegral g, fromIntegral b) shade):(line t shade flip)
  | otherwise = (convertPixel (fromIntegral r, fromIntegral g, fromIntegral b) (myInverse shade)):(line t shade flip)

convertPixel :: (Double, Double, Double) -> [Char] -> Char
convertPixel (r, g, b) shade
  | ((0.3 * r) + (0.59 * g) + (0.11 * b)) / 255 == 1 ||
    round ((((0.3 * r) + (0.59 * g) + (0.11 * b)) / 255) * fromIntegral (myLength shade)) == myLength shade = shade !! 0 
  | ((0.3 * r) + (0.59 * g) + (0.11 * b)) / 255 == 0 = Prelude.last shade
  | otherwise = shade !! ( myLength shade - 1 - round ((((0.3 * r) + (0.59 * g) + (0.11 * b)) / 255) * fromIntegral (myLength shade)))


myInverse :: [a] -> [a]
myInverse [] = []
myInverse (h:t) = (myInverse t) ++ [h]

myLength :: [Char] -> Int
myLength [] = 0
myLength (h:t) = 1 + myLength t
