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


get_region_pos(1, 'TLC').
get_region_pos(2, 'T').
get_region_pos(3, 'TRC').
get_region_pos(4, 'L').
get_region_pos(5, 'C').
get_region_pos(6, 'R').
get_region_pos(7, 'BLC').
get_region_pos(8, 'B').
get_region_pos(9, 'BLC').

region_neighbours(1, [2, 5, 4]).
region_neighbours(2, [3, 6, 5, 4, 1]).
region_neighbours(3, [6, 5, 2]).
region_neighbours(4, [1, 2, 5, 8, 7]).
region_neighbours(5, [1, 2, 3, 6, 9, 8, 4]).
region_neighbours(6, [9, 8, 5, 2, 3]).
region_neighbours(7, [4, 5, 8]).
region_neighbours(8, [7, 4, 5, 6, 9]).
region_neighbours(9, [8, 5, 6]).
