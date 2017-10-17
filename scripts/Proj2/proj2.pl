%  File     : proj2.pl
%  Author   : Hanwei Zhu (hanweiz@student.unimelb.edu.au)
%  ID       : 811443
%  Origin   : Oct 10 2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Purpose:
%% This program is used to solve maths puzzles. A maths puzzle is defined in Project 2 Specification.
%% 
%%
%% My implementation simply has 4 steps. Firstly, it unifies all the squares on the diagonal; Then it 
%% generates all possible solutions for unbound variables; Thirdly, it checks if each row of the 
%% puzzle is a valid solution; Finally it checks if each column of the puzzle is a valid solution.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Dependency Tree
%%
%% puzzle_solution
%% |- check_diagonal/1
%% |- solve_puzzle/2
%%    |- solve_row/1
%%       |- chek_row/1
%%
%% Utilities:
%% product/2, get_squares/3, transpose/1, no_repeated_digits/1
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Test Results:
%%
%% Num Test                              Secs Status    Score    Remark
%% --- ----                              ---- ------    -----    ------
%%   1 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   2 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   3 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   4 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   5 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   6 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   7 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%   8 puzzle_solution(inout) ...        0.01   PASS   1.0/1.0   
%%   9 puzzle_solution(inout) ...        0.01   PASS   1.0/1.0   
%%  10 puzzle_solution(inout) ...        0.01   PASS   1.0/1.0   
%%  11 puzzle_solution(inout) ...        0.00   PASS   1.0/1.0   
%%  12 puzzle_solution(inout) ...        0.01   PASS   1.0/1.0   
%%  13 puzzle_solution(inout) ...        0.01   PASS   1.0/1.0   
%%  14 puzzle_solution(inout) ...        0.04   PASS   1.0/1.0   
%%  15 puzzle_solution(inout) ...        0.04   PASS   1.0/1.0   
%%  16 puzzle_solution(inout) ...        0.41   PASS   1.0/1.0   
%%  17 puzzle_solution(inout) ...        0.22   PASS   1.0/1.0   
%%  18 puzzle_solution(inout) ...        1.28   PASS   1.0/1.0   
%%  19 puzzle_solution(inout) ...        1.76   PASS   1.0/1.0   
%%  20 puzzle_solution(inout) ...        0.57   PASS   1.0/1.0   
%%  21 puzzle_solution(inout) ...        0.54   PASS   1.0/1.0   
%%
%% Total tests executed: 21
%% Total correctness : 21.00 / 21.00 = 100.00%
%% Marks earned : 100.00 / 100.00
%% true.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                          Code
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- ensure_loaded(library(clpfd)).

%% puzzle_solution(Puzzle)
%% Main predicate. Puzzle is the representation of a solved maths puzzle.
%%
%% test cases
%% puzzle_solution([[0, 14, 10, 35], [14, 7, 2, 1], [15, 3, 7, 5], [28, 4, 1, 7]]). -> true.
%% puzzle_solution([[0, 10, 14], [14, 7, 2], [21, 3, 7]]).
%% puzzle_solution([[0, 14, 10, 35], [14, 7, 2, 2], [15, 3, 7, 5], [28, 4, 1, 7]]). -> false.
%% puzzle_solution([[0, 14, 10, 35], [14, 7, 2, 1], [15, 7, 7, 5], [28, 4, 1, 7]]). -> false.
puzzle_solution(Puzzle) :-
    length(Puzzle, Puzzle_size),
    get_squares(Puzzle, Squares, Puzzle_size),
    check_diagonal(Squares),
    solve_puzzle(Puzzle, Puzzle_size),
    transpose(Puzzle, Puzzle1),
    solve_puzzle(Puzzle1, Puzzle_size).



% get_squares(Puzzle, Square, Puzzle size)
% input a puzzle and its size, returns an squres with deleting all row and column heading
%
% test cases
% get_squares([[0, 14, 10, 35], [14, 7, 2, 1], [15, 3, 7, 5], [28, 4, 1, 7]], X, 4).
% get_squares([[0, 14, 10], [14, 7, 2], [15, 3, 7]], X, 3). -> X = [[7, 2], [3, 7]].
% get_squares([[0, 14], [14, 7], X, 2). -> X = [[7]].
get_squares([], [], _).
get_squares([[Head|Tail]|Ls], Squares, Puzzle_size) :-
    (   length([[Head|Tail]|Ls], Len), Len = Puzzle_size
    ->  get_squares(Ls, Squares, Puzzle_size)
    ;
        get_squares(Ls, Sub_squares, Puzzle_size),
        append([Tail], Sub_squares, Squares)
    ).



%% solve_puzzle(Puzzle, Puzzle size)
%% The predicate solve_puzzle/2 gives the valid solution (only for rows) of a puzzle.
%% 
%% test cases
%% solve_puzzle([[0, 14, 10, 35], [14, 7, 2, 1], [15, 3, 7, 5], [28, 4, 1, 7]], 4). -> true
%% solve_puzzle([[0, 14, 10, 35], [14, 7, X, 1], [15, 3, 7, 5], [28, 4, 1, 7]], 4). -> X = 2
solve_puzzle([], _).
solve_puzzle([[Head|Tail]|Ls], Puzzle_size) :-
    (   length([[Head|Tail]|Ls], Len), Len = Puzzle_size
    ->  solve_puzzle(Ls, Puzzle_size)
    ;
        solve_row(Tail),
        check_row([Head|Tail]),
        solve_puzzle(Ls, Puzzle_size)
    ).



%% solve_row(Row)
%% The predicate solve_row/1 generates all possible solutions for a row and uses 
%% check_row/1 to checks if it is valid.
%%
%% test cases
%% solve_row([4, X, 5]). -> X = 1 2 3 6 7 8 9
%% solve_row([4, X, Y]). -> X = 1 - 9, Y = 1 - 9
solve_row([]).
solve_row([E|Elt]) :-
    (   \+ ground(E)
    ->  between(1, 9, E),
        solve_row(Elt)
    ;
        solve_row(Elt)
    ).



%% check_diagonal(Squares)
%% The predicate check_diagonal/1 checks if the diagonal of a puzzle (without heading) is unifying.
%%
%% test cases
%% check_diagonal([[4, 1, 7], [7, 2, 1], [3, 7, 5]]).
%% check_diagonal([[7, 2, 1], [3, 7, 5], [4, 1, 7]]).
check_diagonal(Ls) :-
    check_diagonal1(Ls, 0).
 
check_diagonal1([_|[]], _).
check_diagonal1([L1, L2|Ls], N) :-
    N1 is N + 1,
    nth0(N, L1, E),
    nth0(N1, L2, E),
    check_diagonal1([L2|Ls], N1).



%% no_repeated_digits(Row)
%% The predicate no_repeated_digits/1 checks if a row of the puzzle havs repeated digits.
no_repeated_digits(L) :-
    sort(L, Sorted),
    length(L, Len),
    length(Sorted, Len).



%% check_row(Row)
%% The predicate check_row/1 checks if a row of the puzzle is a valid solution.
check_row([Head|Tail]) :-
    (sum_list(Tail, Head);
    product(Tail, Head)),
    no_repeated_digits(Tail).



%% product(List, Result)
%% The predicate product/2 calculates the product of a list of numbers.
%% Result is the product.
product([], 0).
product([Head|Tail], P) :-
    product1(Tail, Head, P).

product1([], P, P).
product1([Head|Tail], H0, P) :-
    product1(Tail, Head, P0),
    P is P0 * H0.