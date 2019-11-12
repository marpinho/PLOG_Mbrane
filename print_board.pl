:- use_module(library(lists)).

% Representação interna
%	'-1' - Representa o espaço vazio
%	'[0-9]' - Representa os números do jogador 1
%	'[10-19]' - Representa os números do jogador 2


start :- 
	% init_board(Board),
	switch_board(Board),
 	display_game_name, 
	printColumnIdentifiers, nl,
 	display_board(Board).

display_game_name :- nl,
	write('                    |\\    /|  |                           '), nl,
	write('                    | \\  / |  |___    __  ___   __    ___ '), nl,
	write('                    |  \\/  |  |   | |/    ___| |   \\ |___|'), nl,
	write('                    |      |  |___| |    |___| |   | |___ '), nl,
	nl, nl.

printColumnIdentifiers:-
	write('      a    b    c     d    e    f     g    h    i  ').

printHorizontalSeparator:-
	write('     ______________  ______________  ______________ ').


printRowId(X):-
	write('  '),
	write(X).


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

% init_board([
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  '],
% 		 ['  ', '  ','  ','  ','  ','  ','  ','  ','  ']
% 		]).

display_board(Board) :-
	print_rows(Board, 1), nl.

print_rows([], _).

print_rows([H|T], X) :-
	X =\= 4, X =\= 7,
	print_line([H|T], X).

print_rows([H|T], X) :-
	nl,
	print_line([H|T], X).
	
print_line([H|T], X) :-
	printHorizontalSeparator, nl,
	printRowId(X),
	format(' | ~w | ~w | ~w || ~w | ~w | ~w || ~w | ~w | ~w |', H), nl,
	N is X+1,
	print_rows(T, N).



switch_board(BoardVis) :-
	init_board(Board), 
	replace(Board, [], BoardVis).

replace([], L, L).
replace([H|T], ListTmp, NewList) :-
	see_row(H, [], NewRow),
	concat(ListTmp, [NewRow], List),
	replace(T, List, NewList).

see_row([], L, L).
see_row([H|T], RowTmp, NewRow) :-
	map(H, NewNumber),
	concat(RowTmp, [NewNumber], List),
	see_row(T, List, NewRow).

concat([], L, L).
concat([X|L1], L2, [X|L3]) :- concat(L1, L2, L3).


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

