module Main where

import System.Environment (getArgs)

import Control.Monad ((>>), void)

import Text.Parsec hiding (Stream)
import Text.Parsec.String (Parser)

data Stream = Group [Stream]
            | Garbage Int
            deriving (Show)

parseStream :: Parser Stream
parseStream = parseGarbage <|> parseGroup

parseGarbage :: Parser Stream
parseGarbage = between (string "<") (string ">") $ do
  charCounts <- many (escapedChar <|> garbageChar)
  return $ Garbage $ sum charCounts

garbageChar :: Parser Int
garbageChar = do
  void $ noneOf ">"
  return 1

escapedChar :: Parser Int
escapedChar = do
  void $ char '!' >> anyChar
  return 0

parseGroup :: Parser Stream
parseGroup = do
  children <- between (string "{") (string "}") parseChildren
  return $ Group children

parseChildren :: Parser [Stream]
parseChildren = option [] $ do
  c <- parseStream
  cs <- many groupComma
  return $ c:cs

groupComma :: Parser Stream
groupComma = char ',' >> parseStream


score' :: Int -> Stream -> Int
score' _ (Garbage _) = 0
score' depth (Group []) = depth
score' depth (Group children) = depth + (sum $ (score' (depth+1)) <$> children)

score :: Stream -> Int
score = score' 1

countGarbage :: Stream -> Int
countGarbage (Garbage n) = n
countGarbage (Group [])  = 0
countGarbage (Group children) = sum $ countGarbage <$> children

main :: IO ()
main = do
  args <- getArgs
  let infile = head args
  streamContents <- readFile infile
  let parsed = parse parseStream [] streamContents
  case parsed of
    Left _ -> putStrLn "Failed to parse"
    Right stream -> do
      putStrLn $ "Stream has score of: " ++ (show $ score stream)
      putStrLn $ "Total garbage chars: " ++ (show $ countGarbage stream)
