%% If multiplication were not built into Prolog, we could define it as:
%% multiply(X, Y, XY) :-
%% ( X = 0 ->
%%      XY = 0
%%  ;   X1 is X - 1,
%%      multiply(X1, Y, X1Y),
%%      XY is X1Y + Y
%% ).
%%
%% Give a tail recursive definition of multiply/3.

multiply(X, Y, XY) :-
    multiply1(X, Y, 0, XY).

multiply1(X, Y, A, XY) :-
    ( X = 0 ->
        XY is A
    ;   X1 is X - 1,
        A1 is A + Y,
        multiply1(X1, Y, A1, XY)
    ).

