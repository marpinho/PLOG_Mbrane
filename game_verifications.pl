:- [print_board].
:- [board_verifications].

% initialize values ----------------------------------------------------

init_reg([0,0,0,0,0,0,0,0,0]).

init_board([
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1]
]).

init_player(1).


% player vs player --------------------------------------------------------

game_1(Board, Regions, Player):-
    display_game(Board, Regions, Player).

get_new_play(Col, Row, Num):-
    write('column: '), nl,
    read(Col),
    write('row: '), nl,
    read(Row),
    write('number: '), nl,
    read(Num).

% Representação das Regiões por uma lista (Regions) tamanho 9. --------------

region_points([], _Board, _I, _J, Regions_p, Regions_p).
region_points(List, _Board, I, J, TmpList, Regions_p) :-
    J == 3,
    I1 is I + 1,
    J1 is 0,
    region_points(List, _Board, I1, J1, TmpList, Regions_p).
region_points([_|T], Board, I, J, TmpList, Regions_p) :-
    Imin is I*3,
    Jmin is J*3,
    Imax is Imin + 3,
    Jmax is Jmin + 3,
    get_region(Board, Imin, Imax, Jmin, Jmax, 0, [], NewRegion),
    sum_region(NewRegion, 0, Region_Point),
    concat(TmpList, [Region_Point], RegList),
    J1 is J + 1,
    region_points(T, Board, I, J1, RegList, Regions_p).

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

