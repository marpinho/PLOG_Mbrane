:- use_module(library(clpfd)).
:- include('puzzles.pl').
:- include('print.pl').

close_or_far(PuzzleNr):-
    puzzle_size(PuzzleNr,Size),
    show_initial_puzzle(PuzzleNr, Size), nl,
    reset_timer,
    solve_puzzle(PuzzleNr, Board, Size),
    write('SOLUTION: '), nl, nl,
    print_board(Board, Size, 0), nl,
    print_time.

% O domínio representa a peça em si
% Pode ser 0 - espaço vazio
% Pode ser 1 - 1º letra F
% Pode ser 2 - 2º letra F
% Pode ser 3 - 1º letra C
% Pode ser 4 - 2º letra C
% A posição do número na lista é a posição no tabuleiro da peça

solve_puzzle(PuzzleNr,Board, Size) :-
    init_board(PuzzleNr, Board, Size),
    verify_row(Board, [], Size, 0, 0),
    verify_col(Board, Size, 0),
    labeling([], Board).

% -------------- INIT BOARD ----------------------------------------------
init_board(PuzzleNr, Board, Size) :-
    ListSize #= Size * Size,
    length(Board, ListSize),
    domain(Board, 0, 4),
    puzzle(PuzzleNr, Board).

% -------------- SHOW PUZZLE -------------------------------------
show_initial_puzzle(PuzzleNr, Board, Size) :-
    init_board(PuzzleNr, Board, Size),
    labeling([], Board), nl,
    write('PUZZLE: '), nl, nl,
    print_board(Board, Size, 0).

    
% -------------- ROW RESTRICTIONS ------------------------------------------
verify_row(_Board, _List, Size, _N, Size).

verify_row(Board, List, Size, Size, Row) :-
    R1 is Row + 1,
    check_elements(List, Size),
    verify_row(Board, [], Size, 0, R1).

verify_row([H|T], List, Size, N, Row) :-
    N1 is N + 1,
    append(List, [H], L),
    verify_row(T, L, Size, N1, Row).

% -------------- COLUMN RESTRICTIONS -----------------------------------------
verify_col(_Board, N, N).

verify_col(Board, Size, N) :-
    N1 is N + 1,
    verify_col_list(Board, [], Size, N1, 0),
    verify_col(Board, Size, N1).

verify_col_list(_Board, List, Size, _I, Size) :-
    check_elements(List, Size).

verify_col_list(Board, List, Size, I, C) :-
    element(I, Board, H),
    append(List, [H], L),
    I1 is I + Size, 
    C1 is C + 1,
    verify_col_list(Board, L, Size, I1, C1).

% -------------- CHECK DISTANCES ------------------------------------------

verify_dist(List) :-
    element(F, List, 1),
    element(F1, List, 2),
    element(C, List, 3),
    element(C1, List, 4),
    F #\= F1,
    C #\= C1,
    abs(C1-C) #< abs(F1-F).
    
% ------------ LETTERS PER LIST ---------------------------------
check_elements(List, Size) :-
    MaxZeroLine #= Size - 4,
    global_cardinality(List, [0-MaxZeroLine, 1-1, 2-1, 3-1, 4-1]),
    verify_dist(List).

