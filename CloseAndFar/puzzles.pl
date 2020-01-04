:- use_module(library(clpfd)).


%----------------------------- size: 7x7

puzzle(1,L) :-
    element(4, L, 1),
    element(14, L, 1),
    element(20, L, 2),
    element(24, L, 2),
    element(30, L, 2),
    element(36, L, 1),
    element(47, L, 2).

%----------------------------- size: 6x6

puzzle(2,L) :-
    element(1, L, 1),
    element(11, L, 1),
    element(16, L, 2),
    element(24, L, 2),
    element(26, L, 1),
    element(33, L, 1).