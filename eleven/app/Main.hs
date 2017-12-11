module Main where

import System.Environment (getArgs)
import Data.List.Split (splitOn)

type Coordinate = [Int]

toOrigin :: Coordinate -> Int
toOrigin = maximum . map abs

locations :: [Coordinate] -> [Coordinate]
locations = scanl (zipWith (+)) [0, 0, 0]

step :: String -> Coordinate
step "n"  = [ 0,  1, -1]
step "s"  = [ 0, -1,  1]
step "ne" = [ 1,  0, -1]
step "sw" = [-1,  0,  1]
step "se" = [ 1, -1,  0]
step "nw" = [-1,  1,  0]
step _    = [ 0,  0,  0]

main :: IO ()
main = do
  args <- getArgs
  input <- (readFile $ args !! 0)
  let displacements = toOrigin <$> (locations $ step <$> splitOn "," input)
  let res = show <$> ([last, maximum] <*> pure displacements)
  mapM_ putStrLn $ zipWith (++) ["Finish: ", "Furthest: "] res
