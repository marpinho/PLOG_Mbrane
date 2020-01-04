
print_board([], _Size, _N).
print_board(L, Size, Size) :- 
    nl,
    print_board(L, Size, 0).

print_board([H|T], Size, N) :-
    map(H, Valor),
    format(' ~w | ', Valor),
    N1 #= N + 1,
    print_board(T, Size, N1).

map(0,' ').
map(1,'F').
map(2,'C').