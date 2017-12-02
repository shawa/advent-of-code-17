      input ← LoadTEXT 'advent-of-code/02/input.csv'
      input
1224  926 1380  688  845  109  118   88 1275 1306   91  796  102 1361   27  995
1928 2097  138 1824  198  117 1532 2000 1478  539 1982  125 1856  139  475 1338
 848  202 1116  791 1114  236  183  186  150 1016 1258   84  952 1202  988  866
 946  155  210  980  896  875  925  613  209  746  147  170  577  942  475  850
1500  322   43   95   74  210 1817 1631 1762  128  181  716  171 1740  145 1123
3074  827  117 2509  161  206 2739  253 2884  248 3307 2760 2239 1676 1137 3055
 183   85  143  197  243   72  291  279   99  189   30  101  211  209   77  198
 175  149  259  372  140  250  168  142  146  284  273   74  162  112   78   29
 169  578   97  589  473  317  123  102  445  217  144  398  510  464  247  109
3291  216  185 1214  167  495 1859  194 1030 3456 2021 1622 3511  222 3534 1580
2066 2418 2324   93 1073   82  102  538 1552  962   91  836 1628 2154 2144 1378
 149  963 1242  849  726 1158  164 1134  658  161 1148  336  826 1303  811  178
3421 1404 2360 2643 3186 3352 1112  171  168  177  146 1945  319  185 2927 2289
 543  462  111  459  107  353 2006  116 2528   56 2436 1539 1770  125 2697 2432
1356  208 5013 4231  193  169 3152 2543 4430 4070 4031  145 4433 4187 4394 1754
5278  113 4427  569 5167  175  192 3903  155 1051 4121 5140 2328  203 5653 3233


      ⍝ For each row, find the two numbers which evenly divide each other
      ⍝ Sum the result of dividing the larger number by the smaller
      ⍝ Again, we'll explore a solution using the first row of input
      in ← input[1;]
      in
1224 926 1380 688 845 109 118 88 1275 1306 91 796 102 1361 27 995
      
      ⍝ The residue operator (|) will show the remainder of dividing its right
      ⍝ operand by its left:

      2 | 5
1
      ⍝ 5 ÷ 2 = 2 remainder 1

      ⍝ The residue of two numbers which divide evenly will thus be 0:
      2 | 16
0
      ⍝ We can use the . operator to construct an outer product of two vectors,
      ⍝ for example

      1 2 3 ∘.× 2 4 6
2  4  6
4  8 12
6 12 18

      ⍝ We get a matrix, where each entry [i;j] is the ith entry of the right
      ⍝ vector multiplied by the jth entry of the left vector


      ⍝ Using the residue operator we can see which elements on the right
      ⍝ vector evenly divide the elements on the left

      3 5 7 9 ∘.| 2 4 6 8  
2 1 0 2
2 4 1 3
2 4 6 1
2 4 6 8

      ⍝ entry [1;3] of the result is zero, so the 1st entry of the left (3)
      ⍝ evenly divides the 3rd entry (6) of the right


      ⍝ Now if we take the residude product of a vector with _itself_ we can
      ⍝ see when there are elements which evenly divide:

      3 5 7 9 11 ∘.| 3 5 7 9 11
0 2 1 0 2
3 0 2 4 1
3 5 0 2 4
3 5 7 0 2
3 5 7 9 0

      ⍝ The diagonal is all zero, as of course every element will divide itself
      ⍝ We can also find a zero at [1;4], so the first entry (3) evenly divides
      ⍝ the 4th entry (9)!

      ⍝ We can make this even clearer by using the find (⍷) operator to turn on
      ⍝ any entry which is zero, and turn off all the others:
      
      0 ⍷ 3 5 7 9 ∘.| 3 5 7 9 11
1 0 0 1 0
0 1 0 0 0
0 0 1 0 0
0 0 0 1 0

      ⍝ Before going any further, we'll abstract this into a function
      factors ← {0 ⍷ ⍵ ∘.| ⍵}
      factors 3 5 7 9 11
1 0 0 1 0
0 1 0 0 0
0 0 1 0 0
0 0 0 1 0
0 0 0 0 1

      ⍝ Testin this on the first row of our problem input:
      factors in
1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
      ⍝ Entry [13;1] is 1, so the first entry evenly divides the 13th entry
      in[13]
102
      in[1]
1224
      1224 ÷ 102
12
      ⍝ 1224 does indeed divide 102 with no remainder!

      ⍝ If we take a row-wise sum reduction of this matrix, we can find where
      ⍝ there are 1s off the diagonal
      +/ factors in
1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1

      ⍝ All of the diagonal entries are 1, so the row with the off-diagonal
      ⍝ must be the entry with a 2. We can use the index of (⍳) operator to
      ⍝ find the 2
      (+/ factors in) ⍳ 2
13
      ⍝ i.e. the 13th entry of our reduction contains the two

      ⍝ ASIDE: the unary commute operator (⍨) takes a function a → b → c and
      ⍝ produces a function b → c → a, by flipping its operands. This will make
      ⍝ working with ⍳ somewhat easier as we go along
      2 ⍳⍨ +/ factors in
13
      ⍝ This gives us the location of one of the dividing numbers
      ⍝ The column-wise sum reduction will give us the other
      2 ⍳⍨ +⌿ factors in
1
      ⍝ Even more ASIDE:, just as we can abstract expressions into functions
      ⍝ over values, we can abstract can abstract them into over _operators_
      ⍝ over _functions_. Just as ⍺ and ⍵ are the left and right value
      ⍝ operands, ⍺⍺ and ⍵⍵ are the left and right _function_ operands.

      ⍝ For example, we can implement the ⍨ operator ourselves:
      commute ← {⍵ ⍺⍺ ⍺}
      5 - 1
4
      5 -⍨ 1  ⍝ = 1 - 5
¯4
      5 - commute 1
¯4
      ⍝ So {⍵ ⍺⍺ ⍺} just says to take ⍵ and apply it to the left of the
      ⍝ function given, and apply ⍺ to the right 

      ⍝ Now, we can abstract our factor-finding function over rows and columns:
      find ← {2 ⍳⍨ ⍺⍺ ⍵}
      +/ find factors in
13
      +⌿ find factors in
1
      
      ⍝ So to get the indices of the two numbers in the vector that divide each
      ⍝ other, just apply a row-wise, and column-wise reduction:

      divisors ← {(+/ find factors ⍵) (+⌿ find factors ⍵)}

      ⍝ Our row
      in
1224 926 1380 688 845 109 118 88 1275 1306 91 796 102 1361 27 995

      ⍝ The indices of the divisors in `in`
      divisors in
13 1
      ⍝ The values at those indices
      in[divisors in] 
102 1224

      ⍝ Again aside: We can sort using the grade up ⍋, and grade down ⍒
      ⍝ functions. These return a vector of indices, which when used to
      ⍝ subscript the input argumet will return the input sorted, ascending,
      ⍝ and descending, respectively.
      ⍒ 2 4 6 8 10
5 4 3 2 1

      2 4 6 8 10 [⍒ 2 4 6 8 10]
10 8 6 4 2

      ⍝ As a function:
      sorted ← {⍵[⍒⍵]}

      ⍝ Finding the two divisor numbers and sorting them:
      sorted in[divisors in]
1224 102

      ⍝ And thetdivision of these:
      ÷/ sorted in[divisors in] 
12
      ⍝ This is checksum of each row! The result of dividing the two divisors
      row_check ← {÷/ sorted ⍵[divisors ⍵]}
      row_check in
12
      ⍝ And just as before, we'll sum the result of applying this to each row
      ⍝ of the input
      solution  ← { +/ (row_check⍤1) ⍵ }
      solution input
214

      ⍝ And we are done! APL is whopper. 
      ⍝ tryapl.org

      ]defs
commute   ← { ⍵ ⍺⍺ ⍺ }                               
sorted    ← { ⍵[⍒⍵] }

factors   ← { 0 ⍷ ⍵∘.|⍵ }                              
find      ← { 2 ⍳⍨  ⍺⍺ ⍵ }                                 

divisors  ← { (+/ find factors ⍵) (+⌿ find factors ⍵) }

row_check ← { ÷/ sorted ⍵[divisors ⍵] }             

solution  ← { +/ (row_check⍤1) ⍵ }
