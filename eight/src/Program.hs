module Program where
type Register = String
type Value = Int

data Operation = Increment
               | Decrement
               deriving (Show)

data Comparison = Eq | Ne | Gt | Lt | Gte | Lte
               deriving (Show)

data Instruction = Instruction Register Operation Value Register Comparison Value
                 deriving (Show)


type Program = [Instruction]
x :: Program
x = [ Instruction "b" Increment 5 "a" Gt 1
    , Instruction "a" Increment 1 "b" Lt 5
    , Instruction "c" Decrement (-10) "a" Lte 1
    , Instruction "c" Increment (-20) "c" Eq 10
    ]
