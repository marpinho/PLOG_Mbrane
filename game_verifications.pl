% Imports

:- [utils].
:- [print_board].
:- [board_verifications].

%----------------



% Representação das Regiões por uma lista (Regions) tamanho 9.

power_points([], _Board, _I, _J, Regions_p, Regions_p).
power_points(List, _Board, I, J, TmpList, Regions_p) :-
    J == 3,
    I1 is I + 1,
    J1 is 0,
    power_points(List, _Board, I1, J1, TmpList, Regions_p).
power_points([_|T], Board, I, J, TmpList, Regions_p) :-
    Imin is I*3,
    Jmin is J*3,
    Imax is Imin + 3,
    Jmax is Jmin + 3,
    get_region(Board, Imin, Imax, Jmin, Jmax, 0, [], NewRegion),
    sum_region(NewRegion, 0, Region_Point),
    concat(TmpList, [Region_Point], RegList),
    J1 is J + 1,
    power_points(T, Board, I, J1, RegList, Regions_p).

sum_region([], Regions_p, Regions_p).
sum_region([H|T], Sum, Regions_p) :-
    H == -1,
    sum_region(T, Sum, Regions_p).
sum_region([H|T], Sum, Regions_p) :-
    H > 9,
    H1 is H - 10,
    H2 is -H1,
    Total is Sum + H2,
    sum_region(T, Total, Regions_p).
sum_region([H|T], Sum, Regions_p) :-
    Total is Sum + H,
    sum_region(T, Total, Regions_p).

influence_points(L, _Board, 10, L).
influence_points(Regions_points, Board, Inc, L) :-
    get_region_pos(Inc, Region_Pos),
    region_neighbours(Inc, Neighbours),
    % Se calhar faz sentido ter o get_region 
    calculate_points(Neighbours, Inc, Board, Region_Pos, Regions_points, NewRegions_points),
    Inc1 is Inc + 1,
    influence_points(NewRegions_points, Board, Inc1, L).

calculate_points([], _Inc, _Board, _Regions_Pos, R, R).
calculate_points([H|T], Inc, Board, Regions_Pos, Regions_points, NewRegions_points) :-
    Regions_pos == 'TLC',
    % Aqui seria mais fácil para retirar os valores de cada região tendo a board da região
    get_numbers_right(Board, NL),
    get_number(Board, 0, 3, 3, NDiag),
    get_numbers_down(Board, ND).
    
