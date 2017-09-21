multiply(X, Y, XY) :- multiply1(X, Y, 0, XY).
% XY IS X * Y + A

multiply1(X, Y, A, XYA) :-
    ( X =:= 0 ->
        XYA is A
    ;
        X1 is X-1,
        A1 is A + Y,
        multiply1(X1, Y , A1, XYA)
    ).