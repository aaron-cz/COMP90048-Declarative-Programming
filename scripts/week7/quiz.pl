parent(queen_elizabeth, prince_charles).

%% Define a Prolog predicate siblings(Sib1,Sib2) that 
%% holds when Sib1 and Sib2 are siblings (or half-siblings). 
%% That is, they share at least one parent.
%% Remember: no one is their own sibling!

siblings(Sib1,Sib2) :-
    parent(X,Sib1),
    parent(X,Sib2),
    Sib1 \= Sib2.

%% Datalog


capitol(australia, canberra).
capitol(france, paris).
continent(australia, australia).
continent(france, europe).
population(australia, 22_680_000).
population(france, 65_700_000).

%% capitol(france, Capitol).

%% continent(Country, europe),
%% capitol(Country, Capitol).

%% continent(Country, europe),
%% population(Country, Pop),
%% Pop > 50_000_000.


proper_list([]).
proper_list([_|Tail]) :-
    proper_list(Tail).


append([], C, C).
append([A|B], C, [A|BC]) :-
    append(B, C, BC).


take(N, List, Front) :-
    length(Front,N),
    append(Front, _, List).


drop(0, Back, Back).
drop(N, [_|Tail], Back) :-
    N > 0,
    N1 is N - 1,
    drop(N1, Tail, Back).


rev3(ABC, CBA) :-
    samelength(ABC, CBA),
    rev1(ABC, CBA).

samelength([], []).
samelength([_|Xs], [_|Ys]) :-
    samelength(Xs, Ys).