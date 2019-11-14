
:- [game_verifications].

run :-  
    display_choices, nl, 
    write('Your Choice: '), nl,
    read(Choice),
    start(Choice).


% game modes ---------------------------------------------
start(Choice) :- 
    Choice == 1,
    init_board(Board),
    init_reg(Regions),
	init_player(Player),
    display_game(Board, Regions, Player),
    game_1(Board, Regions, Player).

start(Choice):- 
    Choice == 2,
    not_implemented.

start(Choice) :-
    Choice == 3,
    not_implemented.

start(Choice) :-
    Choice == 4,
    abort.

start(_) :-
    nl, write('--INVALID INPUT--'), nl,
    run.