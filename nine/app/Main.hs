module Main where

import System.Environment (getArgs)

import Control.Monad ((>>))

import Text.Parsec hiding (Stream)
import Text.Parsec.String (Parser)

data Stream = Group [Stream] | Garbage deriving (Show)

parseStream :: Parser Stream
parseStream = parseGarbage <|> parseGroup

parseGarbage :: Parser Stream
parseGarbage = between (string "<") (string ">") $ do
  skipMany $ (char '!' >> anyChar) <|> noneOf ">"
  return Garbage

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
score' _ Garbage = 0
score' depth (Group []) = depth
score' depth (Group children) = depth + (sum $ (score' (depth+1)) <$> children)

score :: Stream -> Int
score = score' 1

main :: IO ()
main = do
  args <- getArgs
  let infile = head args
  streamContents <- readFile infile
  let parsed = parse parseStream [] streamContents
  case parsed of
    Left _ -> putStrLn "Failed to parse"
    Right stream -> print $ score stream
