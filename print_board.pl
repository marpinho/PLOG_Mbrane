% Imports

:- [utils].
% :- use_module(library(lists)).

%----------------
% Representação interna
%	'-1' - Representa o espaço vazio
%	'[0-9]' - Representa os números do jogador 1
%	'[10-19]' - Representa os números do jogador 2



display_game_name :- nl,
	write('          |\\    /|  |                                 '), nl,
	write('          | \\  / |  |___    __  ___   __    ___       | R1 | R2 | R3 | '), nl,
	write('          |  \\/  |  |   | |/    ___| |   \\ |___|      | R4 | R5 | R6 | '), nl,
	write('          |      |  |___| |    |___| |   | |___       | R7 | R8 | R9 |'), nl,
	nl.

printColumnIdentifiers:-
	write('                 a    b    c     d    e    f     g    h    i  ').

printHorizontalSeparator:-
	write('                ______________  ______________  ______________ ').

printRowId(X):-
	write('             '),
	write(X).

display_regions_points(Regions) :-
	nl,
	format('     R1: ~d | R2: ~d | R3: ~d | R4: ~d | R5: ~d | R6: ~d | R7: ~d | R8: ~d | R9: ~d ', Regions), nl,nl.
	

display_player(Player):-
	Player == 1,
	write('     Player: X'), nl, nl, nl.

display_player(Player):-
	Player == 2,
	write('     Player: Y '), nl, nl, nl.

display_board(Board):-
	print_rows(Board, 1), nl.

print_rows([], _).

print_rows([H|T], X) :-
	X =\= 4, X =\= 7,
	print_line(H, X),
	N is X+1,
	print_rows(T, N).

print_rows([H|T], X) :-
	nl,
	print_line(H, X),
	N is X+1,
	print_rows(T, N).
	
print_line(H, X) :-
	printHorizontalSeparator, nl,
	printRowId(X),
	format(' | ~w | ~w | ~w || ~w | ~w | ~w || ~w | ~w | ~w |', H), nl.


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

display_game(Board,Regions,Player) :- 
	display_game_name, nl, nl, 
	display_regions_points(Regions),
	printColumnIdentifiers, nl,
	switch_board(Board, B),
 	display_board(B),nl,
 	display_player(Player).


display_choices :-
	nl,write('Chose your game mode: '),nl,nl,
	write('1. Player versus player'),nl,
	write('2. Player versus computer'),nl,
	write('3. Computer versus computer'),nl,
	write('4. Quit').


% messages ----------------------------------------------------------------
not_implemented :-
    nl, write('--This mode is not yet available--'),
	abort.

valid_move :-
    write('--valid choice--'), nl.
not_valid_move :-
    write('--not a valid choice, try again--'), nl, nl.
