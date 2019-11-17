
:- [game_verifications].

r :-
    init_regi(R),
    display_regions_points(R),
    get_points(R,X,Y),
    write(X), 
    write(Y).


run :-  
    %display_choices, nl, 
    %write('Your Choice: '), nl,
    %read(Choice),
    start(1).

% game modes ---------------------------------------------
start(Choice) :- 
    Choice == 1,
    init_board(Board),
    init_reg(Regions),
	init_player(Player),
    display_game(Board, Regions, Player, 0,0),
    game_pvp(Board, Regions, Player).

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