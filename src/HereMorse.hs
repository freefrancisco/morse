-- Example of how the Here package lets us read a data file as part of the pure program,
-- probably not haskell kosher, but good trick to know

{-# LANGUAGE QuasiQuotes #-}

module HereMorse
  ( Morse
  , charToMorse
  , morseToChar
  , stringToMorse
  , letterToMorse
  , morseToLetter
  )
  where

import qualified Data.Map as M
import Data.Char (toLower)
import Data.String.Here (hereFile)

type Morse = String

charToMorse :: Char -> Maybe Morse
charToMorse c = M.lookup c letterToMorse

stringToMorse :: String -> Maybe [Morse]
stringToMorse s = sequence $ fmap charToMorse s

morseToChar :: Morse -> Maybe Char
morseToChar m = M.lookup m morseToLetter

morseToLetter :: M.Map Morse Char
morseToLetter = M.foldWithKey (flip M.insert) M.empty letterToMorse

-- interesting way to read files in source and still treat them as pure
letterToMorse :: (M.Map Char Morse)
letterToMorse = stringToMap [hereFile|data/morseTable.txt|]

stringToMap :: String -> M.Map Char Morse
stringToMap = M.fromList . fmap (mktuple . words) . lines

mktuple :: [String] -> (Char, Morse)
mktuple ((x:xs): y : _) = (toLower x, y)
