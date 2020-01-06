
print_board(L, Size) :- 
    print_board(L, Size, 0). 

print_board([], _Size, _N).

print_board(L, Size, Size) :- 
    nl,nl,
    print_board(L, Size, 0).

print_board([H|T], Size, N) :-
    map(H, Valor),
    format('~w | ', Valor),
    N1 #= N + 1,
    print_board(T, Size, N1).

map(0,' ').
map(1,'F').
map(2,'F').
map(3,'C').
map(4,'C').


reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.