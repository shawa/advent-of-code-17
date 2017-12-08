module Main where

import Lib
import qualified Data.Map.Strict as Map

newtype Registers = Map String Int

main :: IO ()
main = someFunc
