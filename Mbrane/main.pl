
:- [game_verifications].

run :-  
    display_choices, nl,
    read(Choice),
    start(Choice).

% game modes ---------------------------------------------
start(Choice) :- 
    Choice == 1,
    init_game(Board,Regions,Player),
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