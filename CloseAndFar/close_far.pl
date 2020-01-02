:- use_module(library(clpfd)).

start(L, Size, P, P1) :- 
    close_far(L, Size, P, P1),
    print_l(L, Size, 0), nl.

print_l([], _Size, _N).
print_l(L, Size, Size) :- 
    nl,
    print_l(L, Size, 0).

print_l([H|T], Size, N) :-
    format(' ~d ', H),
    N1 #= N + 1,
    print_l(T, Size, N1).

example_board_1(L) :-
    element(4, L, 1),
    element(14, L, 1),
    element(20, L, 2),
    element(24, L, 2),
    element(30, L, 2),
    element(36, L, 1),
    element(47, L, 2).


% O domínio representa a peça em si
% Pode ser 0 - espaço vazio
% Pode ser 1 - A letra F
% Pode ser 2 - A letra C
% A posição do número na lista é a posição no tabuleiro da peça
close_far(Board, Size, A, B) :-
    ListSize #= Size * Size,
    MaxNumber #= 2 * Size,
    MaxZero #= ListSize - (2 * MaxNumber),
    length(Board, ListSize),
    domain(Board, 0, 2),
    example_board_1(Board),
    global_cardinality(Board, [0-MaxZero, 1-MaxNumber, 2-MaxNumber]),
    verify_row(Board, [], Size, 0),
    verify_col(Board, Size, 0),
    labeling([], Board).

% Faz as restriçoes para as linhas do tabuleiro
verify_row([], _List, _Size, _N).

verify_row(Board, List, Size, Size) :-
    check_elements(List, Size),
    verify_dist(List, Size),
    verify_row(Board, [], Size, 0).

verify_row([H|T], List, Size, N) :-
    N1 is N + 1,
    append(List, [H], L),
    verify_row(T, L, Size, N1).

% Faz as restriçoes para as colunas do tabuleiro
verify_col(_Board, N, N).

verify_col(Board, Size, N) :-
    N1 is N + 1,
    verify_col_list(Board, [], Size, N1, 0),
    verify_col(Board, Size, N1).

verify_col_list(_Board, List, Size, _I, Size) :-
    check_elements(List, Size),
    verify_dist(List, Size).

verify_col_list(Board, List, Size, I, C) :-
    element(I, Board, H),
    append(List, [H], L),
    I1 is I + Size, 
    C1 is C + 1,
    verify_col_list(Board, L, Size, I1, C1).

% Verifica as distâncias das letras
% Ainda não está feito
verify_dist(List, Size) :-
    get_pos_f(List, F_pos, 0),
    get_pos_g(List, C_pos, 0),
    element(P, List, 1),
    element(P1, List, 1),
    element(O, List, 2),
    element(O1, List, 2),
    P #=< Size #/\ P1 #=< Size,
up201703607    O #\= O1 #/\ O #=< Size #/\ O1 #=< Size,
    abs(O1-O) #\= abs(P1-P),
    abs(O1-O) #< abs(P1-P).


% Restringe o número de letras por lista
check_elements(List, Size) :-
    MaxZeroLine #= Size - 4,
    global_cardinality(List, [0-MaxZeroLine, 1-2, 2-2]).
