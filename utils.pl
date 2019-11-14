concat([], L, L).
concat([X|L1], L2, [X|L3]) :- concat(L1, L2, L3).

replace_value_list([_H|T], Pos, Pos, Val, TmpList, L) :-
    concat(TmpList, [Val|T], L).
replace_value_list([H|T], Pos_Ini, Pos, Val, TmpList, L) :-
    Pos_Ini < Pos,
    I is Pos_Ini + 1,
    concat(TmpList, [H], Tmp),
    replace_value_list(T, I, Pos, Val, Tmp, L).

map(-1, '  ').
map(0, 'X0').
map(1, 'X1').
map(2, 'X2').
map(3, 'X3').
map(4, 'X4').
map(5, 'X5').
map(6, 'X6').
map(7, 'X7').
map(8, 'X8').
map(9, 'X9').
map(10, 'Y0').
map(11, 'Y1').
map(12, 'Y2').
map(13, 'Y3').
map(14, 'Y4').
map(15, 'Y5').
map(16, 'Y6').
map(17, 'Y7').
map(18, 'Y8').
map(19, 'Y9').


region_neighbours(0, [2, 4, 3]).
region_neighbours(1, [2, 5, 4, 3, 0]).
region_neighbours(2, [5, 4, 1]).
region_neighbours(3, [0, 1, 4, 7, 6]).
region_neighbours(4, [0, 1, 2, 5, 8, 7, 3]).
region_neighbours(5, [8, 7, 4, 1, 2]).
region_neighbours(6, [3, 4, 7]).
region_neighbours(7, [6, 3, 4, 5, 8]).
region_neighbours(8, [7, 4, 5]).
