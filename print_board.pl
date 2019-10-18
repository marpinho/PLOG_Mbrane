start :- 
	init_board(Board),
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
	write('      a   b   c    d   e   f    g   h   i  ').

printHorizontalSeparator:-
	write('     ___________  ___________  ___________ ').


printRowId(X):-
	write('  '),
	write(X).

init_board([
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' '],
		 [' ', ' ',' ',' ',' ',' ',' ',' ',' ']
		]).

display_board(Board) :-
	print_rows(Board, 1), nl.

print_rows([], _).

print_rows([H|T], X) :-
	X =\= 4, X =\= 7,
	print_line([H|T], X).

print_rows([H|T], X) :-
	nl,
	print_line([H|T], X).
	
print_line([H|T], X):-
	printHorizontalSeparator, nl,
	printRowId(X),
	format(' | ~w | ~w | ~w || ~w | ~w | ~w || ~w | ~w | ~w |', H), nl,
	N is X+1,
	print_rows(T, N).
