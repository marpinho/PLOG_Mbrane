:- [print_board].


verify_board(Board) :-
    convert_board(Board, [], ConvBoard),
    verify_regions(Board, ConvBoard, 0, 0),
    verify_horizontally(ConvBoard),
    verify_vertically(Board, ConvBoard, 0).


convert_board([], ConvBoard,ConvBoard).
convert_board([H|T], TmpBoard, ConvBoard) :-
    convert_row(H, [], ConvRow),
    concat(TmpBoard, [ConvRow], NewTmp),
    convert_board(T, NewTmp, ConvBoard).

convert_row([], ConvRow, ConvRow).
convert_row([H|T], RowTmp, ConvRow) :-
    H > 9,
    H1 is H - 10,
    concat(RowTmp, [H1], NewTmp),
    convert_row(T, NewTmp, ConvRow).
convert_row([H|T], RowTmp, ConvRow) :-
    concat(RowTmp, [H], NewTmp),
    convert_row(T, NewTmp, ConvRow).





% Limite superior vai ser I + 2 | J + 2.
verify_regions([], _Board, _I, _J).
verify_regions(List, _Board, I, J) :-
    J == 3,
    I1 is I + 1,
    J1 is 0,
    verify_regions(List, _Board, I1, J1).
verify_regions([_|T], Board, I, J) :-
    Imin is I*3,
    Jmin is J*3,
    Imax is Imin + 3,
    Jmax is Jmin + 3,
    get_region(Board, Imin, Imax, Jmin, Jmax, 0, [], NewRegion),
    % format(' ~d ~d ~d ~d ~d ~d ~d ~d ~d ', NewRegion), nl,
    verify_row(NewRegion),
    J1 is J + 1,
    verify_regions(T, Board, I, J1).


get_region(_, _Imin, Cnt, _Jmin, _Jmax, Cnt, NewRegion, NewRegion).
get_region([H|T], Imin, Imax, Jmin, Jmax, Cnt, ListTmp, NewRegion) :-
    Cnt >= Imin,
    Cnt < Imax,
    get_row(H, Jmin, Jmax, ListTmp, NewList),
    Cnt1 is Cnt + 1,
    get_region(T, Imin, Imax, Jmin, Jmax, Cnt1, NewList, NewRegion).
get_region([_H|T], Imin, Imax, Jmin, Jmax, Cnt, ListTmp, NewRegion) :-
    Cnt < Imin,
    Cnt1 is Cnt + 1,
    get_region(T, Imin, Imax, Jmin, Jmax, Cnt1, ListTmp, NewRegion).

get_row(_, Jmax, Jmax, NewList, NewList).
get_row(List, Jmin, Jmax, ListTmp, NewList) :-
    Jmin < Jmax,
    get_number(List, 0, Jmin, Number),
    append(ListTmp, [Number], Reg),
    Cnt is Jmin + 1,
    get_row(List, Cnt, Jmax, Reg, NewList).
    
    


% verify_vertically(+Tabuleiro1, +Tabuleiro, +Incremento)
% Tabuleiro1 - Serve como condição de paragem.
% Tabuleiro - Representa o tabuleiro de jogo.
% Incremento - É uma variável que aumenta de forma a "varrer" as colunas todas do tabuleiro.
% Verifica se existe algum número em duplicado nas colunas do tabuleiro 
verify_vertically([], _List, _I).
verify_vertically([_|T], Board, I) :-
    get_col(Board, I, [], Col),
    verify_row(Col),
    I1 is I + 1,
    verify_vertically(T, Board, I1).

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

