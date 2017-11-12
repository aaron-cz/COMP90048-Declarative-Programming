% Write a predicate filter(Pred, List, Filtered) such that 
% Filtered is a list of the elements of List (in the same 
% border) that satisfy the predicate Pred.


filter(_, [], []).
filter(P, [X|Xs], Filtered) :-
    ( call(P, X) ->
        Filtered = [X|Filtered1]
    ;
        Filtered = Filtered1
    ),
    filter(P, Xs, Filtered1).

% give the set of herbrand type constrains for this function
% definition:
% filter f l = case l of
%     [] -> []
%     (x:xs) -> let fxs = filter f xs
%         in if f x then x:fxs else fxs

% op(200,xfy,’=>’).

% Filter = F => L => Result,
% L = [ ],
% L = [X], Xs = [X],
% Filter = F => Xs => Fxs,
% F = X => bool,
% Result = [X], Fxs = [X],
% Result = Fxs.