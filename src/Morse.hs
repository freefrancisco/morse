module Morse
  ( Morse
  , charToMorse
  , morseToChar
  , stringToMorse
  , letterToMorse
  , morseToLetter
  , letterToMorse'
  )
  where

import qualified Data.Map as M
import Data.Char (toLower)

type Morse = String

charToMorse :: Char -> Maybe Morse
charToMorse c = M.lookup c letterToMorse

stringToMorse :: String -> Maybe [Morse]
stringToMorse s = sequence $ fmap charToMorse s

morseToChar :: Morse -> Maybe Char
morseToChar m = M.lookup m morseToLetter


morseToLetter :: M.Map Morse Char
morseToLetter = M.foldWithKey (flip M.insert) M.empty letterToMorse

letterToMorse :: (M.Map Char Morse)
letterToMorse = M.fromList [
      ('a', ".-")
    , ('b', "-...")
    , ('c', "-.-.")
    , ('d', "-..")
    , ('e', ".")
    , ('f', "..-.")
    , ('g', "--.")
    , ('h', "....")
    , ('i', "..")
    , ('j', ".---")
    , ('k', "-.-")
    , ('l', ".-..")
    , ('m', "--")
    , ('n', "-.")
    , ('o', "---")
    , ('p', ".--.")
    , ('q', "--.-")
    , ('r', ".-.")
    , ('s', "...")
    , ('t', "-")
    , ('u', "..-")
    , ('v', "...-")
    , ('w', ".--")
    , ('x', "-..-")
    , ('y', "-.--")
    , ('z', "--..")
    , ('1', ".----")
    , ('2', "..---")
    , ('3', "...--")
    , ('4', "....-")
    , ('5', ".....")
    , ('6', "-....")
    , ('7', "--...")
    , ('8', "---..")
    , ('9', "----.")
    , ('0', "-----")
    ]

-- If we wanted to read the morse info from a file instead of entering it by hand
letterToMorse' :: IO (M.Map Char Morse)
letterToMorse' = do
  morse <- readFile "data/morseTable.txt"
  return $ stringToMap morse

stringToMap :: String -> M.Map Char Morse
stringToMap = M.fromList . fmap (mktuple . words) . lines

mktuple :: [String] -> (Char, Morse)
mktuple ((x:xs): y : _) = (toLower x, y)
