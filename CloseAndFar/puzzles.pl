:- use_module(library(clpfd)).


puzzle_size(1, 7).
puzzle_size(2, 7).
puzzle_size(3, 7).
puzzle_size(4, 6).
puzzle_size(5, 6).
puzzle_size(6, 6).
puzzle_size(7, 6).


%----------------------------- size: 7x7

puzzle(1,L) :-
    element(4, L, 1),
    element(14, L, 1),
    element(20, L, 3),
    element(24, L, 3),
    element(30, L, 3),
    element(36, L, 1),
    element(47, L, 3).

puzzle(2,L) :-
    element(1, L, 3),
    element(9, L, 1),
    element(19, L, 3),
    element(28, L, 3),
    element(31, L, 1),
    element(41, L, 1),
    element(46, L, 3).

puzzle(3,L) :-
    element(5, L, 3),
    element(9, L, 3),
    element(17, L, 1),
    element(22, L, 1),
    element(35, L, 3),
    element(41, L, 1),
    element(46, L, 1).


%----------------------------- size: 6x6

puzzle(4,L) :-
    element(1, L, 1),
    element(11, L, 1),
    element(16, L, 3),
    element(24, L, 3),
    element(26, L, 1),
    element(33, L, 1).

puzzle(5,L) :-
    element(2, L, 3),
    element(12, L, 1),
    element(15, L, 1),
    element(22, L, 3),
    element(25, L, 1),
    element(35, L, 3).

puzzle(6,L) :-
    element(2, L, 1),
    element(9, L, 1),
    element(18, L, 1),
    element(23, L, 1),
    element(28, L, 1),
    element(31, L, 1).

puzzle(7,L) :-
    element(2, L, 3),
    element(7, L, 3),
    element(16, L, 1),
    element(24, L, 1),
    element(29, L, 1),
    element(33, L, 1).