solve(X, R) :- last(X, L), solve([L|X], 0, R).

solve([_], Acc, Acc).
solve([X|[X|T]], Acc, R) :- Acc0 is Acc + X, solve([X|T], Acc0, R).
solve([_|T],     Acc, R) :- solve(T, Acc, R).
