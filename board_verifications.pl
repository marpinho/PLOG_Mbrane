% Imports

:- [utils].
:- [print_board].




verify_board(Board, Col, Row, Num, Valid) :- 
    Num > 10,
    N is Num - 10,
    verify_board_1(Board, Col, Row, N, Valid).

verify_board(Board, Col, Row, Num, Valid) :- 
    Num < 10,
    verify_board_1(Board, Col, Row, Num, Valid).

verify_board_1(Board, Col, Row, Num, Valid):-
    verify_available(Board, Col, Row, V1),
    (
        V1 == 'false' ->
        Valid = V1;
        verify_board_2(Board, Col, Row, Num, Valid)
    ).

verify_board_2(Board, Col, Row, Num, Valid):-
    convert_board(Board, [], ConvBoard),
    verify_hori(ConvBoard, Row, Num, Valid).



%------------------------------------------------------------------------
verify_available(Board, Col, Row, Valid) :-
    verify_available(Board, Col, Row, 0, Valid).

verify_available([H|T], Col, Row, Counter, Valid):-
    Counter < Row,
    C is Counter + 1,
    verify_available(T, Col, Row, C, Valid).

verify_available([H|T], Col, Row, Counter, Valid):-
    Counter == Row,
    check_number(H, Col, Num),
   (
       Num == -1 ->
       Valid = 'true';
       Valid = 'false'
   ).

check_number([H|T], Col, Num):-
    check_number([H|T], Col, Num, 0).

check_number([H|T], Col, Num, Counter):-
    Counter < Col,
    C is Counter + 1,
    check_number(T, Col, Num, C).

check_number([H|T], Col, Num, Counter):-
    Counter == Col,
    Num is H,!.

%----------------------------------------------------------------------

verify_hori(Board, Row, Num, Valid) :-
    verify_hori(Board, Row, Num, 0, Valid).

verify_hori([H|T], Row, Num, Counter, Valid):-
    Counter < Row,
    C is Counter + 1,
    verify_hori(T, Col, Num, C, Valid).

verify_hori([H|T], Row, Num,Counter, Valid):-
    Counter == Row,
    check_row(H, Num, Valid).
   
check_row([], Num, Valid):-
    Valid = 'true'.

check_row([H|T], Num, Valid):-
    H == Num,
    Valid = 'false'.

check_row([H|T], Num, Valid ):-
    H =\= Num,
    check_row(T, Num, Valid).



%--------------------------------------------------------------------

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

%------------------------------------------------------------------------

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
    get_number_row(List, 0, Jmin, Number),
    append(ListTmp, [Number], Reg),
    Cnt is Jmin + 1,
    get_row(List, Cnt, Jmax, Reg, NewList).
    
    
%-------------------------------------------------------------------------------------------------

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

% get_col(+Tabuleiro, +I, +ListaTmp, -NovaLista)
% Tabuleiro - Tabuleiro no qual o predicado vai efetuar a pesquisa dos números 
%               que estão na coluna de indice I. 
% Indice - Variável que indica a posição da coluna.
% ListaTmp - Lista temporária que vai armazenar os números do tabuleiro ao longo do ciclo recursivo.
% NovaLista - Lista com os elementos da coluna de indice I.
get_col([], _I, NewCol, NewCol).
get_col([H|T], I, Num, NewCol) :-
    get_number_row(H, 0, I, NewNum),
    append([NewNum], Num, NewList),
    get_col(T, I, NewList, NewCol).


get_number([Row|_], I, I, J, NewNum) :- 
    get_number_row(Row, 0, J, NewNum).
get_number([_H|T], Inc, I, J, NewNum) :-
    Inc1 is Inc + 1,
    get_number(T, Inc1, I, J, NewNum).


get_number_row([H|_T], I, I, H).
get_number_row([_H|T], I2, I, NewNum) :-
    X1 is I2 + 1, !,
    get_number_row(T, X1, I, NewNum).


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

