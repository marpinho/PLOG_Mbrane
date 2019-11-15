:- [utils].
:- [print_board].
:- [board_verifications].
:- [game_verifications].


b_teste(
    [
        [1, 2, 3, 4, 5, 6],
        [7, 8, 9, 10, 11, 12],
        [13, 14, 15, 16, 17, 18], 
        [-1, -1, -1, -1, -1, -1]
    ]
).

b_teste2(
    [
        [1, 2, 3],
        [-1, -1, -1]
    ]
).

b_teste3([
	[0, 1, 0, 2, 1, 2, 3, 1, 3],
	[0, -1, 0, 2, -1, 2, 3, -1, 3],
	[0, 1, 0, 2, 1, 2, 3, 1, 3],
	[4, -1, 4, 5, -1, 5, 6, -1, 6],
	[4, 1, 4, 5, 1, 5, 6, 1, 6],
	[4, -1, 4, 5, -1, 5, 6, -1, 6],
	[7, 1, 7, 8, 1, 8, 9, 1, 9],
	[7, -1, 7, 8, -1, 8, 9, -1, 9],
	[7, 1, 7, 8, 1, 8, 9, 1, 9]
]).

b_teste4([
	[10, 11, 10, 2, 1, 2, 3, 1, 3],
	[10, -1, 10, 2, -1, 2, 3, -1, 3],
	[10, 11, 10, 12, 1, 12, 13, 1, 3],
	[4, -1, 4, 5, -1, 15, 6, -1, 6],
	[4, 1, 4, 5, 1, 15, 6, 1, 6],
	[4, -1, 4, 5, -1, 5, 6, -1, 6],
	[7, 1, 7, 8, 1, 8, 19, 1, 9],
	[7, -1, 7, 8, -1, 18, 9, -1, 9],
	[7, 1, 7, 8, 1, 18, 9, 1, 9]
]).

b_teste5([
	[11, -1, -1, -1, -1, -1, -1, 11, -1],
	[-1, 11, -1, 3, 5, -1, -1, 5, 11],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1]
]).


b_teste6([
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, 8, 16, -1, 1, -1, 4, 17, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1]
]).

init_reg3([0,0,0,0,0,0,0,0,0]).
init_reg2([-13,8,0,8,8,0,0,0,0]).


teste :- b_teste(B), verify_horizontally(B).

teste2 :- b_teste(B), verify_vertically(B, B, 0).

teste3(I, L) :- b_teste(B2), get_col(B2, I, [], L).

teste4 :- init_board(B3), verify_board(B3).

%get_region([H|T], Imin, Imax, Jmin, Jmax, Cnt, ListTmp, NewRegion)
% teste5(L) :- b_teste3(B3), get_region(B3, 3, 6, 3, 6, 0, [], L).
teste5 :- b_teste4(Board), verify_regions(Board, Board, 0, 0).

teste6(NewB) :- b_teste4(Board), convert_board(Board, [], NewB).

teste7(L) :- conv([10,11,12,13,14], L).

teste8(L) :- b_teste4(Board), init_reg(Reg), region_points(Reg, Board, New_reg).
t(T) :- T is -3/2.

teste9(L) :- replace_value_list([1,2,3,4,5,6], 0, 3, 12, [], L).

teste10(New_reg) :- b_teste6(Board), init_reg(Reg), influence_points(Reg, Board, 0, 0, Reg, New_reg).

teste11(New_reg) :- b_teste6(Board), init_reg(Reg), regions_points(Board, Reg, New_reg).

teste12(L) :- update_region_point([0,0,0,0,0,0,0,0,0], 22, 5, L).

teste13 :- 
    init_board(Board),
    init_reg(Regions), replace_value_matrix(Board, 5, 2, 5, NewBoard),
    display_game(NewBoard, Regions, 1).

teste14 :- 
    init_board(Board),
    init_reg(Regions), board_update([10, 11, 10, 12, 1, 12, 13, 1, 3], 6, 6, 6, 9, Board, NewBoard),
    display_game(NewBoard, Regions, 1).
