% Imports

:- [utils].
:- [print_board].
:- [board_verifications].

% initialize values ----------------------------------------------------

init_reg([0,0,0,0,0,0,0,0,0]).

init_board([
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1],
	[-1, -1, -1, -1, -1, -1, -1, -1, -1]
]).

init_player(1).


% player vs player --------------------------------------------------------

game_1(Board, Regions, Player):-
    get_new_play(Player, Col, Row, Num),
    write(Col), nl,
    write(Row), nl,
    write(Num), nl, 
    change_player(Player, Next),
    write(Next), nl, 
    display_game(Board, Regions, Next),
    game_1(Board, Regions, Next).


get_new_play(Player, IntCol, IntRow, IntNum):-
    write('column: '), nl,
    read(Col),
    map_col(Col,IntCol),
    write('row: '), nl,
    read(Row),
    IntRow is Row  - 1,
    write('number: '), nl,
    read(Num),    
    get_internal_rep(Player, Num, IntNum).

get_internal_rep(Player, Num, Inum):-
    Player == 2,
    map_y(Num,Inum).
get_internal_rep(Player, Num, Inum):-
    Player == 1,
    Inum = Num.

add_play(Board, Col, Row , Num, NewBoard):-
    replace_value_matrix( Board, Col, Row, Num, [], NewBoard, 0).
    
replace_value_matrix([H|T], Col, Row, Num, TmpList, NewBoard, Counter) :-
    Counter < Row,
    C is Counter + 1,
    concat(TmpList, [H], Tmp),
    replace_value_matrix(T, Col, Row, Num, Tmp, NewBoard, C).

replace_value_matrix([H|T], Col, Row, Num, TmpList, NewBoard, Counter) :-
    Counter == Row,
    replace_value_list(H, Col, Num, NewRow),
    concat(TmpList, [NewRow|T], NewBoard).

change_player(Player, Next):-
    Player == 1,
    Next is 2.
change_player(Player, Next):-
    Player == 2,
    Next is 1.


% Representação das Regiões por uma lista (Regions) tamanho 9. --------------

regions_points(Board, Regions, NewRegions_P) :-
    power_points(Regions, Board, 0, 0, [], Regions_tmp),
    influence_points(Regions, Board, 0, 0, Regions_tmp, NewRegions_P).



power_points([], _Board, _I, _J, Regions_p, Regions_p).
power_points(List, Board, I, J, TmpList, Regions_p) :-
    J == 3,
    I1 is I + 1,
    J1 is 0,
    power_points(List, Board, I1, J1, TmpList, Regions_p).
power_points([_|T], Board, I, J, TmpList, Regions_p) :-
    Imin is I*3,
    Jmin is J*3,
    Imax is Imin + 3,
    Jmax is Jmin + 3,
    get_region(Board, Imin, Imax, Jmin, Jmax, 0, [], NewRegion),
    sum_region(NewRegion, 0, Region_Point),
    concat(TmpList, [Region_Point], RegList),
    J1 is J + 1,
    power_points(T, Board, I, J1, RegList, Regions_p).

sum_region([], Regions_p, Regions_p).
sum_region([H|T], Sum, Regions_p) :-
    H == -1,
    sum_region(T, Sum, Regions_p).
sum_region([H|T], Sum, Regions_p) :-
    H > 9,
    H1 is H - 10,
    H2 is -H1,
    Total is Sum + H2,
    sum_region(T, Total, Regions_p).
sum_region([H|T], Sum, Regions_p) :-
    Total is Sum + H,
    sum_region(T, Total, Regions_p).



% influence_points(+Lista, +Board, +I, +J, +Old_Region_P, -N_Regions_p)

influence_points([], _Board, _I, _J, NRegions_p, NRegions_p).
influence_points(List, Board, I, J, Old_Region_P, N_Regions_p) :-
    J == 3,
    I1 is I + 1,
    J1 is 0,
    influence_points(List, Board, I1, J1, Old_Region_P, N_Regions_p).
influence_points([_|T], Board, I, J, Old_Region_P, N_Regions_p) :-
    Imin is I*3,
    Jmin is J*3,
    Imax is Imin + 3,
    Jmax is Jmin + 3,
    Id_R is I*3 + J,
    get_region(Board, Imin, Imax, Jmin, Jmax, 0, [], NewRegion),
    calculate_influence(NewRegion, Id_R, Old_Region_P, Regions_points_tmp),
    J1 is J + 1,
    influence_points(T, Board, I, J1, Regions_points_tmp, N_Regions_p).




% Calcula a Influencia da região 1 sobre as suas regiões vizinhas
% calculate_influence(_Region, 3, R, R).
calculate_influence(_Region, 4, R, R).
calculate_influence(_Region, 5, R, R).
calculate_influence(_Region, 6, R, R).
calculate_influence(_Region, 7, R, R).
calculate_influence(_Region, 8, R, R).
% calculate_influence(_Region, 9, R, R).
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 0, !,
    
    get_numbers_right(Region, Sum_Numbers_R), % Vai buscar a soma dos valores que fazem fronteira na direita
    update_region_point(Regions_points, Sum_Numbers_R, 1, Regions_Update), % Altera a Pontuação da Região à sua direita 
    
    update_diag_region(Regions_Update, Region, 8, 4, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal baixa à direita

    get_numbers_down(Region, Sum_Numbers_D), % Vai buscar a soma dos valores que fazem fronteira abaixo
    update_region_point(Regions_Update_II, Sum_Numbers_D, 3, NewRegions_points). % Altera a Pontuação da Região abaixo

% Calcula a Influencia da região 2 sobre as suas regiões vizinhas    
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 1, !,
    get_numbers_right(Region, Sum_Numbers_R), % Vai buscar a soma dos valores que fazem fronteira na direita
    update_region_point(Regions_points, Sum_Numbers_R, 2, Regions_Update), % Altera a Pontuação da Região à sua direita 
     
    update_diag_region(Regions_Update, Region, 8, 5, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal baixa à direita

    get_numbers_down(Region, Sum_Numbers_D), % Vai buscar a soma dos valores que fazem fronteira abaixo
    update_region_point(Regions_Update_II, Sum_Numbers_D, 4, Regions_Update_III), % Altera a Pontuação da Região abaixo
    
    update_diag_region(Regions_Update_III, Region, 6, 3, Regions_Update_IV), % Altera a Pontuação da Região na sua diagonal baixa à esquerda

    get_numbers_left(Region, Sum_Numbers_L), % Vai buscar a soma dos valores que fazem fronteira na esquerda
    update_region_point(Regions_Update_IV, Sum_Numbers_L, 0, NewRegions_points). % Altera a Pontuação da Região à sua esquerda 
    



% Calcula a Influencia da região 3 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 2, !,
    get_numbers_down(Region, Sum_Numbers_D), % Vai buscar a soma dos valores que fazem fronteira abaixo
    update_region_point(Regions_points, Sum_Numbers_D, 5, Regions_Update), % Altera a Pontuação da Região abaixo
    
    update_diag_region(Regions_Update, Region, 6, 4, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal baixa à esquerda

    get_numbers_left(Region, Sum_Numbers_L), % Vai buscar a soma dos valores que fazem fronteira na esquerda
    update_region_point(Regions_Update_II, Sum_Numbers_L, 1, NewRegions_points). % Altera a Pontuação da Região à sua esquerda 

% Calcula a Influencia da região 4 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 3, !,
    get_numbers_up(Region, Sum_Numbers_U), % Vai buscar a soma dos valores que fazem fronteira acima
    update_region_point(Regions_points, Sum_Numbers_U, 0, Regions_Update), % Altera a Pontuação da Região acima
   
    update_diag_region(Regions_Update, Region, 2, 1, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal alta à direita

    get_numbers_right(Region, Sum_Numbers_R), % Vai buscar a soma dos valores que fazem fronteira na direita
    update_region_point(Regions_Update_II, Sum_Numbers_R, 4, Regions_Update_III), % Altera a Pontuação da Região à sua direita 

    update_diag_region(Regions_Update_III, Region, 8, 7, Regions_Update_IV), % Altera a Pontuação da Região na sua diagonal baixa à direita

    get_numbers_down(Region, Sum_Numbers_D), % Vai buscar a soma dos valores que fazem fronteira abaixo
    update_region_point(Regions_Update_IV, Sum_Numbers_D, 6, NewRegions_points). % Altera a Pontuação da Região abaixo 


% Calcula a Influencia da região 5 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 4, !,
    get_numbers_up(Region, Sum_Numbers_U), % Vai buscar a soma dos valores que fazem fronteira acima
    update_region_point(Regions_points, Sum_Numbers_U, 1, Regions_Update), % Altera a Pontuação da Região acima
   
    update_diag_region(Regions_Update, Region, 2, 2, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal alta à direita

    get_numbers_right(Region, Sum_Numbers_R), % Vai buscar a soma dos valores que fazem fronteira na direita
    update_region_point(Regions_Update_II, Sum_Numbers_R, 5, Regions_Update_III), % Altera a Pontuação da Região à sua direita 

    update_diag_region(Regions_Update_III, Region, 8, 8, Regions_Update_IV), % Altera a Pontuação da Região na sua diagonal baixa à direita

    get_numbers_down(Region, Sum_Numbers_D), % Vai buscar a soma dos valores que fazem fronteira abaixo
    update_region_point(Regions_Update_IV, Sum_Numbers_D, 7, Regions_Update_V), % Altera a Pontuação da Região abaixo 

    update_diag_region(Regions_Update_V, Region, 6, 6, Regions_Update_VI), % Altera a Pontuação da Região na sua diagonal baixa à esquerda

    get_numbers_left(Region, Sum_Numbers_L), % Vai buscar a soma dos valores que fazem fronteira à esquerda
    update_region_point(Regions_Update_VI, Sum_Numbers_L, 3, Regions_Update_VII), % Altera a Pontuação da Região à esquerda 

    update_diag_region(Regions_Update_VII, Region, 0, 0, NewRegions_points). % Altera a Pontuação da Região na sua diagonal alta à esquerda


% Calcula a Influencia da região 6 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 5, !,
    get_numbers_up(Region, Sum_Numbers_U), % Vai buscar a soma dos valores que fazem fronteira acima
    update_region_point(Regions_points, Sum_Numbers_U, 2, Regions_Update_II), % Altera a Pontuação da Região acima
   
    get_numbers_down(Region, Sum_Numbers_D), % Vai buscar a soma dos valores que fazem fronteira abaixo
    update_region_point(Regions_Update_II, Sum_Numbers_D, 8, Regions_Update_III), % Altera a Pontuação da Região abaixo 

    update_diag_region(Regions_Update_III, Region, 6, 7, Regions_Update_IV), % Altera a Pontuação da Região na sua diagonal baixa à esquerda

    get_numbers_left(Region, Sum_Numbers_L), % Vai buscar a soma dos valores que fazem fronteira à esquerda
    update_region_point(Regions_Update_IV, Sum_Numbers_L, 4, Regions_Update_V), % Altera a Pontuação da Região à esquerda 

    update_diag_region(Regions_Update_V, Region, 0, 1, NewRegions_points). % Altera a Pontuação da Região na sua diagonal alta à esquerda

% Calcula a Influencia da região 7 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 6, !,
    get_numbers_up(Region, Sum_Numbers_U), % Vai buscar a soma dos valores que fazem fronteira acima
    update_region_point(Regions_points, Sum_Numbers_U, 3, Regions_Update), % Altera a Pontuação da Região acima
   
    update_diag_region(Regions_Update, Region, 2, 4, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal alta à direita

    get_numbers_right(Region, Sum_Numbers_R), % Vai buscar a soma dos valores que fazem fronteira na direita
    update_region_point(Regions_Update_II, Sum_Numbers_R, 7, NewRegions_points). % Altera a Pontuação da Região à sua direita 



% Calcula a Influencia da região 8 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 7, !,
    get_numbers_up(Region, Sum_Numbers_U), % Vai buscar a soma dos valores que fazem fronteira acima
    update_region_point(Regions_points, Sum_Numbers_U, 4, Regions_Update), % Altera a Pontuação da Região acima
   
    update_diag_region(Regions_Update, Region, 2, 5, Regions_Update_II), % Altera a Pontuação da Região na sua diagonal alta à direita

    get_numbers_right(Region, Sum_Numbers_R), % Vai buscar a soma dos valores que fazem fronteira na direita
    update_region_point(Regions_Update_II, Sum_Numbers_R, 8, Regions_Update_III), % Altera a Pontuação da Região à sua direita 

    get_numbers_left(Region, Sum_Numbers_L), % Vai buscar a soma dos valores que fazem fronteira à esquerda
    update_region_point(Regions_Update_III, Sum_Numbers_L, 6, Regions_Update_IV), % Altera a Pontuação da Região à esquerda 

    update_diag_region(Regions_Update_IV, Region, 0, 3, NewRegions_points). % Altera a Pontuação da Região na sua diagonal alta à esquerda


% Calcula a Influencia da região 9 sobre as suas regiões vizinhas
calculate_influence(Region, Region_Id, Regions_points, NewRegions_points) :-
    Region_Id == 8, !,
    get_numbers_up(Region, Sum_Numbers_U), % Vai buscar a soma dos valores que fazem fronteira acima
    update_region_point(Regions_points, Sum_Numbers_U, 5, Regions_Update), % Altera a Pontuação da Região acima
   
    get_numbers_left(Region, Sum_Numbers_L), % Vai buscar a soma dos valores que fazem fronteira à esquerda
    update_region_point(Regions_Update, Sum_Numbers_L, 7, Regions_Update_II), % Altera a Pontuação da Região à esquerda 

    update_diag_region(Regions_Update_II, Region, 0, 4, NewRegions_points). % Altera a Pontuação da Região na sua diagonal alta à esquerda




update_diag_region(Regions_points, Region, Id_diag, Id_R, Regions_Update) :-
    get_number_row(Region, 0, Id_diag, NDiag),
    convert_number(NDiag, NDiag_N),
    New_R_P is NDiag_N/2,
    get_number_row(Regions_points, 0, Id_R, Old_R_P),
    Value is New_R_P + Old_R_P,
    replace_value_list(Regions_points, 0, Id_R, Value, [], Regions_Update). % Altera a Pontuação da Região na sua diagonal baixa à direita
 


update_region_point(Regions_points, Sum_Numbers, Id_R, Regions_Update) :-
    get_number_row(Regions_points, 0, Id_R, Old_Reg_P), % Retorna a pontuação da zona fronteiriça da região Id_R
    New_P is Sum_Numbers + Old_Reg_P, % Soma o novo valor com a pontuação anterior da região
    replace_value_list(Regions_points, 0, Id_R, New_P, [], Regions_Update). % Atualiza a lista das pontuações das regiões



convert_number(-1, 0).
convert_number(N, NC) :-
    N > 9,
    NC is -N + 10, !.
convert_number(N, N).


get_numbers_right(Region, Influence_value) :-
    get_number_row(Region, 0, 2, N2),
    get_number_row(Region, 0, 5, N5),
    get_number_row(Region, 0, 8, N8),
    sum_region([N2, N5, N8], 0, Sum),
    Influence_value is Sum / 2.

get_numbers_left(Region, Influence_value) :-
    get_number_row(Region, 0, 0, N0),
    get_number_row(Region, 0, 3, N3),
    get_number_row(Region, 0, 6, N6),
    sum_region([N0, N3, N6], 0, Sum),
    Influence_value is Sum / 2.

get_numbers_up(Region, Influence_value) :-
    get_number_row(Region, 0, 0, N0),
    get_number_row(Region, 0, 1, N1),
    get_number_row(Region, 0, 2, N2),
    sum_region([N0, N1, N2], 0, Sum),
    Influence_value is Sum / 2.

get_numbers_down(Region, Influence_value) :-
    get_number_row(Region, 0, 6, N6),
    get_number_row(Region, 0, 7, N7),
    get_number_row(Region, 0, 8, N8),
    sum_region([N6, N7, N8], 0, Sum),
    Influence_value is Sum / 2.