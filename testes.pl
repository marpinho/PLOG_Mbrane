:- [print_board].
:- [board_verifications].



% Testes (Funções de testes para testar as estruturas)

% f(1).
% f(2).
% f(3).
% f(4).
% t(5).
% f(6).
% f(7).
% f(8).
% f(9).

% teste(A1, A2, A3, A4, A5, A6, A7, A8, A9) :- 
%     f(A1), !, f(A2),
%     f(A3), !, t(A4),
%     f(A5), !, f(A6),
%     f(A7), !, f(A8),
%     f(A9).
% teste :- fail.



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



teste :- b_teste(B), verify_horizontally(B).

teste2 :- b_teste(B), verify_vertically(B, B, 0).

teste3(I, L) :- b_teste(B2), get_col(B2, I, [], L).

teste4 :- init_board(B3), verify_board(B3).

%get_region([H|T], Imin, Imax, Jmin, Jmax, Cnt, ListTmp, NewRegion)
% teste5(L) :- b_teste3(B3), get_region(B3, 3, 6, 3, 6, 0, [], L).
teste5 :- b_teste3(Board), verify_regions(Board, Board, 0, 0).

teste6(NewB) :- b_teste4(Board), convert_board(Board, [], NewB).

% start :- 
%     b_teste3(B),
% 	switch_board(B, Board),
%  	display_game_name, 
% 	printColumnIdentifiers, nl,
%  	display_board(Board).