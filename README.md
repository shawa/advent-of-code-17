# How to (try to) understand APL!
APL is an array-oriented, expression-based language. It's known for having a weird character set, with usually-complicated functions expressed as single characters. Problems that can be expressed as operations on arrays usually take an extremely small amount of code to solve.

APL is traditionally used in an interactive manner, in a REPL. The very basics of understanding a REPL session is given below.

You should definitely watch Imperial College London's APL demo from the '70s, the language has hardly changed at all, save for a few extra new functions.

https://www.youtube.com/watch?v=_DTpQ4Kk2wA

```apl
      ⍝ Indented text is input to the REPL, results are displayed with no indent
      ⍝ Some notes on notation:

      ⍝ Functions are defined by braces {}
      ⍝ Within braces, ⍺ refers to the left argument, and ⍵ to the right
      ⍝ For example add the left and right arguments together and multiply them by two
      5 {2 ×  ⍺ + ⍵} 10
30
      ⍝ Assignment is done using the arrow ←
      pi ← 3.14
      pi
3.14
      ⍝ We can of course assign functions to names
      succ ← {1 + ⍵}
      succ 1
2
      ⍝ Functions are applied by juxtaposition. 
      ⍝ Functions are right-associative with no precedence rules at all:
      succ succ 0
2
      1 + 2 × succ succ 0
5
      ⍝ Vectors are also formed by juxtaposition, for example the triple 
      ⍝ [1, 2, 3] is just 1 2 3:
      1 2 3
1 2 3 

      ⍝ As well as functions over values, there are operators over functions
      ⍝ We'll see more later, but just know that operators are left-associative

      ⍝ For example, the reduce / operator works just like a foldl in Haskell, taking a function to apply between elements of a vector
      ⍝ A sum reduction is then +/ 1 2 3 4, parsed as ((+/)(1 2 3 4))
      +/ 1 2 3 4
10
```
