module Main where

import System.Environment (getArgs)

import Control.Monad ((>>), void)

import Text.Parsec hiding (Stream)
import Text.Parsec.String (Parser)

data Stream = Group [Stream] | Garbage Int
            deriving (Show)

stream :: Parser Stream
stream = garbage <|> group

garbage :: Parser Stream
garbage = between (string "<") (string ">") $ garbage' >>= return . Garbage . sum
  where garbage'  = many $ escaped <|> unescaped
        escaped   = (void $ char '!' >> anyChar) >> return 0
        unescaped = (void $ noneOf ">")          >> return 1

group :: Parser Stream
group = between (string "{") (string "}") children >>= return . Group
  where children = option [] $ do
          c <- stream
          cs <- many $ char ',' >> stream
          return $ c:cs

score :: Stream -> Int
score = score' 1
  where score' _     (Garbage _) = 0
        score' depth (Group [])  = depth
        score' depth (Group cs)  = (sum $ (score' $ depth + 1) <$> cs) + depth

countGarbage :: Stream -> Int
countGarbage (Garbage n) = n
countGarbage (Group [])  = 0
countGarbage (Group cs)  = sum $ countGarbage <$> cs

main :: IO ()
main = do
  args <- getArgs
  let infile = head args
  streamContents <- readFile infile
  let parsed = parse stream [] streamContents
  case parsed of
    Left _ -> putStrLn "Failed to parse"
    Right s -> do
      putStrLn $ "S has score of: " ++ (show $ score s)
      putStrLn $ "Total garbage chars: " ++ (show $ countGarbage s)
