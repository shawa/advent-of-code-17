module Program where
type Register = String
type Value = Int

data Operation = Increment
               | Decrement

instance Show Operation where
  show Increment = "inc"
  show Decrement = "dec"

data Comparison = Eq | Ne | Gt | Lt | Gte | Lte

instance Show Comparison where
  show Eq = "=="
  show Ne = "!="
  show Gt = ">"
  show Lt = "<"
  show Gte = ">="
  show Lte = "<="

data Instruction = Instruction Register Operation Value Register Comparison Value

instance Show Instruction where
  show (Instruction r o v cr cc cv) = unwords [ r
                                              , show o
                                              , show v
                                              , "if"
                                              , cr
                                              , show cc
                                              , show cv
                                              ]

type Program = [Instruction]
