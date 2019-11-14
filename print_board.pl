% Imports

:- [utils].
% :- use_module(library(lists)).

%----------------


% Representação interna
%	'-1' - Representa o espaço vazio
%	'[0-9]' - Representa os números do jogador 1
%	'[10-19]' - Representa os números do jogador 2


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


display_board(Board, Regions) :-
	print_rows(Board, 1), nl, 
	display_regions_points(Regions).

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


display_regions_points(Regions) :-
	nl,
	format(' R1: ~f | R2: ~f | R3: ~f | R4: ~f | R5: ~f | R6: ~f | R7: ~f | R8: ~f | R9: ~f ', Regions), nl.


switch_board(Board, BoardVis) :-
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

