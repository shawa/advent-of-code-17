module Parser (parseProgram, parseLine) where

import Program
import Data.Either (rights)

import Text.Parsec
import Text.Parsec.String (Parser)
import Text.ParserCombinators.Parsec.Number (int)
import Text.ParserCombinators.Parsec.Char

parseString :: Parser Instruction
parseString = do
  targetRegister <- parseRegisterName
  space
  operation <- parseOperation
  space
  value <- int
  space
  string "if"
  space
  comparisonRegister <- parseRegisterName
  space
  comparator <- parseComparator
  space
  comparisonValue <- int
  return $ Instruction targetRegister operation value comparisonRegister comparator comparisonValue


parseRegisterName = many1 letter
parseOperation = do
  op <- string "inc" <|> string "dec"
  return $ case op of
    "inc" -> Increment
    "dec" -> Decrement

parseComparator = do
  cmp <-  try (string ">=" <|> string "<=" <|> string "==" <|> string "!=")
          <|> string ">" <|> string "<"
  return $ case cmp of
    ">" -> Gt
    "<" -> Lt
    "==" -> Eq
    "!=" -> Ne
    ">=" -> Gte
    "<=" -> Lte


parseLine = parse parseString []

parseProgram :: [String] -> Program
parseProgram = rights . map parseLine
