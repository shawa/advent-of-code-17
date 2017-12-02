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

      ⍝ Part 1: Find the sum of the difference between the min and max of every
      ⍝ row we'll explore the solution with the first row of input 
      in ← input[1;]
      in

1224 926 1380 688 845 109 118 88 1275 1306 91 796 102 1361 27 995
      ⍝ the max of the input
      ⍝ ⍺ ⌈ ⍵ will return the larger of ⍺, and ⍵
      1 ⌈ 10
10
      ⍝ When used in a reduction over a vector, it will return the max of the
      ⍝ whole vector
      
      ⌈/ in
1380
      ⍝ No explanation needed for this :)
      ⌊/ in
27
      ⍝ WARNING: BLACK MAGIC AHEAD
      ⍝ Given two functions 
      ⍝
      ⍝    f : t → a
      ⍝ and 
      ⍝    g : t → b
      ⍝
      ⍝ We can combine them with another function 
      ⍝
      ⍝    h : a → b → u
      ⍝
      ⍝ inline.
      ⍝
      ⍝ This is called a _fork_ , written as (f h g) and will yield a function
      ⍝
      ⍝    ff : a → d
      ⍝
      ⍝ Approximately in haskell: fork f h g x = (f x) `h` (g x)

      ⍝ In our case, we can get an outrageously succinct expression for the
      ⍝ difference between the min and max:
      ⌈/ - ⌊/
 ⌈/ - ⌊/ 

      (⌈/-⌊/) in
1353
      ⍝ We can apply functions to each row of a matrix with the rank ⍤
      ⍝ operator.
      ⍝
      ⍝ This very much like the each (¨)  operator, which applies a function to
      ⍝ each element of a vector, but with a 'reaching-in depth' specification
      ⍝
      ⍝ i.e. if we have a 3-D (a "rank 3") matrix A,
      ⍝ f⍤1 will apply the function f to each 2-D matrix comprising A.
      ⍝ f⍤2 would apply the function to each 1-D row of each of those matrices,
      ⍝ f⍤3 to each # element.
      ⍝
      ⍝ So to apply our function to each row of the input array, we use f⍤1:
      (⌈/-⌊/)⍤1 in
1353 1980 1174 833 1774 3190 261 343 492 3367 2336 1154 3275 2641 4868 5540

      ⍝ The result of all these is just their sum, expressed a reduction
      +/ ((⌈/-⌊/)⍤1) input
34581

      +/ ((⌈/-⌊/)⍤1)

 +/    ⌈/ - ⌊/  ⍤ 1 

      ⍝ Our solution is read like English, an almost exact translation of the
      ⍝ problem specification!
      ⍝
      ⍝ +/          ⌈/ - ⌊/                                     ⍤ 1 
      ⍝ the sum of [the difference between the min and the max] of each row 
