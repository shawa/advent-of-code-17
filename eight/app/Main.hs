module Main where

import Parser (parseProgram)
import Program
import System.Environment (getArgs)

import Control.Monad (replicateM)

import qualified Data.Map.Strict as Map

type State = Map.Map Register Value

toComp :: Comparison -> (Int -> Int -> Bool)
toComp Eq = (==)
toComp Ne = (/=)
toComp Gt = (>)
toComp Lt = (<)
toComp Gte = (>=)
toComp Lte = (<=)

toOp :: Operation -> (Int -> Int -> Int)
toOp Increment = (+)
toOp Decrement = (-)

execute :: Instruction -> State -> State
execute (Instruction reg op val condReg cmp cmpVal) state =
  if cond then Map.insert reg val' state else state
  where get = \reg -> Map.findWithDefault 0 reg state
        cond = (toComp cmp) (get condReg) cmpVal
        val' = (toOp op) (get reg) val

run :: Program -> State
run = foldr execute Map.empty

findMax :: State -> Int
findMax = Map.foldr max 0

main :: IO ()
main = do
  args <- getArgs
  let infile = args !! 0
  input <- readFile infile
  let program = parseProgram $ lines input
  let result = findMax $ run program
  print result
