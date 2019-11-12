:- [print_board].


verify_board(Board) :-
    % verify_quads(Board),
    verify_horizontally(Board),
    verify_vertically(Board, Board, 0).

% verify_regions(Board) :- 
%     verify_region(Board, 1), !, verify_region(Board, 2),
%     verify_region(Board, 3), !, verify_region(Board, 4),
%     verify_region(Board, 5), !, verify_region(Board, 6),
%     verify_region(Board, 7), !, verify_region(Board, 8),
%     verify_region(Board, 9), !.
% verify_regions(Board) :- fail.




% verify_vertically(+Tabuleiro1, +Tabuleiro, +Incremento)
% Tabuleiro1 - Serve como condição de paragem.
% Tabuleiro - Representa o tabuleiro de jogo.
% Incremento - É uma variável que aumenta de forma a "varrer" as colunas todas do tabuleiro.
% Verifica se existe algum número em duplicado nas colunas do tabuleiro 
verify_vertically([], _List, _I).
verify_vertically([_|T], List, I) :-
    get_col(List, I, [], NewList),
    verify_row(NewList),
    I1 is I + 1,
    verify_vertically(T, List, I1).

% get_col(+Tabuleiro, +Indice, +ListaTmp, -NovaLista)
% Tabuleiro - Tabuleiro no qual o predicado vai efetuar a pesquisa dos números 
%               que estão na coluna, cuja a posição é igual à variável Indice. 
% Indice -  Variável que indica a posição da coluna.
% ListaTmp -  Lista que vai armazenar os números do tabuleiro ao longo do "varrimento"
get_col([], _I, NewCol, NewCol).
get_col([H|T], I, Num, NewCol) :-
    get_number(H, 0, I, NewNum),
    append([NewNum], Num, NewList),
    get_col(T, I, NewList, NewCol).



get_number([H|_T], I, I, H).
get_number([_H|T], I2, I, NewNum) :-
    X1 is I2 + 1,
    get_number(T, X1, I, NewNum).


% Verifica se existe algum número em duplicado nas linhas do tabuleiro 
verify_horizontally([]).
verify_horizontally([H|T]) :- 
    verify_row(H),
    verify_horizontally(T).


verify_row([]).
verify_row([H|T]) :- 
    verify_numbers(T, H),
    verify_row(T).


verify_numbers([], _X).
verify_numbers([H|T], X) :-
    X == -1,
    verify_numbers(T, H).
verify_numbers([H|T], X) :-
    H == -1,
    verify_numbers(T, X).
verify_numbers([H|T], X) :-
    X =\= H,
    verify_numbers(T, X).

