:- use_module(library(clpfd)).
f(1 + X, X).
eq(X, X, true).
eq(_, _, false).

rotate(X, 0, X).
rotate([H|T], N, R) :-
    append(T, [H], R0),
    succ(N0, N),
    rotate(R0, N0, R).

select(Xs, Is, R) :- select(Xs, Is, [], R).
select([], _, R, R).
select([X|Xs], [true|Is], Acc, R) :-
  append(Acc, [X], Acc0),
  select(Xs, Is, Acc0, R). 

select([_|Xs], [false|Is], Acc, R) :-
  select(Xs, Is, Acc, R).

rotation(one, _, 1).
rotation(two, X, R) :- 
  length(X, L),
  R is div(L, 2).

solve(Part, X, R) :-
  rotation(Part, X, Degree),
  rotate(X, Degree, Rotated),
  maplist(eq, X, Rotated, Indices),
  select(X, Indices, Numbers),
  sumlist(Numbers, R).


part1(X, R) :- solve(one, X, R).
part2(X, R) :- solve(two, X, R).
