filter(_, [], []).
filter(Pred, [X|Xs], Result) :-
    ( call(Pred, X) ->
        Result = [X|Tail]
    ; Result = Tail
    ),
    filter(Pred, Xs, Tail).

%give the set of herbrand type constrains for this function definition:

Filter = F => L => Result,
L = [_], Result = [_],
L = [X], Xs = [X],
Filter = F => Xs => Fxs,
F = X => bool,
Result = [X], Fxs = [X],
Result = Fxs.
