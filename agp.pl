max([X],X).
max([L | Ls], L):- max(Ls, K), L > K. 
max([L | Ls], K):- max(Ls, K), K >= L.

list_length([], 0).
list_length([_ | Ls], N):- list_length(Ls, N1), N is N1 + 1.

champions(L,N):-
    max(L, MaxNum),
    list_length(L, Points),
    champions_b(L, MaxNum, Points, N). 
champions_b([], _, _, 0).
champions_b([L | Ls], MaxNum, Points, N):-
    Points + L >= MaxNum, 
    champions_b(Ls, MaxNum, Points, N1),
    N is N1 + 1.
champions_b([L | Ls], MaxNum, Points, N):-
    Points + L < MaxNum, 
    champions_b(Ls, MaxNum, Points, N1),
    N is N1.

/* Ασκηση 2 */


append([], X, X).
append([L1 | L1x], L2, [L1 | NewList]):- append(L1x, L2, NewList).

check(List):-
    list_length(List, Length),
    checkWord(List, Length, 0).

checkWord([], _,  _):- !.
checkWord([_], _, _):-
    fail.
checkWord([First, Second | Ls], Length, Times):-
    First == Second, 
    checkWord(Ls, Length, Times).
checkWord([First, Second | Ls], Length, Times):-
    First \= Second, !,
    Times < Length,
    NewTimes is Times + 1,
    append([Second | Ls], [First], NewList),
    checkWord(NewList, Length, NewTimes).

beautiful(L, N):-
    beautiful_b(L, N).

beautiful_b([], 0).
beautiful_b([FirstWord | Rest], N):-
    check(FirstWord),
    beautiful_b(Rest, N1),
    N is N1 + 1.
beautiful_b([FirstWord|Rest], N):-
    \+ check(FirstWord),
    beautiful_b(Rest, N1),
    N is N1.

/* Ασκηση 3 */

bletter_count([], 0).
bletter_count([First | Ls], N):-
    First == b,
    bletter_count(Ls, N1),
    N is N1 + 1.
bletter_count([First | Ls], N):-
    First == a,
    bletter_count(Ls, N1),
    N is N1.

convert([], []).
convert([First | Ls], [b | NewList]):-
    First == a,
    convert(Ls, NewList).
convert([First | Ls], [a | NewList]):-
    First == b,
    convert(Ls, NewList).

shrink_list(_, 0, []).
shrink_list([Head | Rest],Total, [Head | NewRest]):-
    Total > 0,
    NewTotal is Total - 1,
    shrink_list(Rest, NewTotal, NewRest). 

changes([], 0, 0, 0).
changes(List, N, Min, Shrinked):-
    bletter_count(List, Count),
    Count < Min,
    Shrinked > 0,
    NewShrinked is Shrinked - 1,
    shrink_list(List, Shrinked, NewList),
    changes(NewList, N, Count, NewShrinked).


