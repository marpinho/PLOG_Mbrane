:- use_module(library(clpfd)).
:- include('puzzles.pl').
:- include('print.pl').

close_or_far(PuzzleNr):-
    solve_puzzle(PuzzleNr, Board, Size ),
    print_board(Board, Size, 0), nl.


% O domínio representa a peça em si
% Pode ser 0 - espaço vazio
% Pode ser 1 - A letra F
% Pode ser 2 - A letra C
% A posição do número na lista é a posição no tabuleiro da peça

solve_puzzle(PuzzleNr, Board, Size ) :-
    init_board(PuzzleNr, Board, Size),
    verify_row(Board, [], Size, 0),
    verify_col(Board, Size, 0),
    labeling([], Board).

% -------------- INIT BOARD ----------------------------------------------

init_board(PuzzleNr, Board, Size) :-
    ListSize #= Size * Size,
    length(Board, ListSize),
    domain(Board, 0, 2),
    puzzle(PuzzleNr, Board).


% -------------- ROW RESTRICTIONS ------------------------------------------
verify_row([], _List, _Size, _N).

verify_row(Board, List, Size, Size) :-
    check_elements(List, Size),
   % verify_dist(List, Size),
    verify_row(Board, [], Size, 0).

verify_row([H|T], List, Size, N) :-
    N1 is N + 1,
    append(List, [H], L),
    verify_row(T, L, Size, N1).

% -------------- COLUMN RESTRICTIONS -----------------------------------------
verify_col(_Board, N, N).

verify_col(Board, Size, N) :-
    N1 is N + 1,
    verify_col_list(Board, [], Size, N1, 0),
    verify_col(Board, Size, N1).

verify_col_list(_Board, List, Size, _I, Size) :-
    check_elements(List, Size).
    %verify_dist(List, Size).

verify_col_list(Board, List, Size, I, C) :-
    element(I, Board, H),
    append(List, [H], L),
    I1 is I + Size, 
    C1 is C + 1,
    verify_col_list(Board, L, Size, I1, C1).

% -------------- CHECK DISTANCES ------------------------------------------
% Ainda não está feito

verify_dist(List, Size) :-
    get_pos_f(List, F_pos, 0),
    get_pos_g(List, C_pos, 0),
    element(P, List, 1),
    element(P1, List, 1),
    element(O, List, 2),
    element(O1, List, 2),
    P #=< Size #/\ P1 #=< Size,
    O #\= O1 #/\ O #=< Size #/\ O1 #=< Size,
    abs(O1-O) #\= abs(P1-P),
    abs(O1-O) #< abs(P1-P).


% ----------- NUMBER OF LETTERS PER LIST ---------------------------------
check_elements(List, Size) :-
    MaxZeroLine #= Size - 4,
    global_cardinality(List, [0-MaxZeroLine, 1-2, 2-2]).

