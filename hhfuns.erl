-module(hhfuns).
-compile(export_all).

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H)|map(F,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

base(A) ->
    B = A + 1,
    F = fun() -> A * B end,
    F().

a() ->
    Secret = "pony",
    fun() -> Secret end.

b(F) ->
    "a/0's password is " ++ F().

%% Only keep even numbers
even(L) -> lists:reverse(even(L,[])).

even([], Acc) -> Acc;
even([H|T], Acc) when H rem 2 == 0 ->
    even(T, [H|Acc]);
even([_|T], Acc) -> 
    even(T, Acc).

filter(Pred, L) -> lists:reverse(filter(Pred, L, [])).

filter(_, [], Acc) -> Acc;
filter(Pred, [H|T], Acc) ->
    case Pred(H) of
        true  -> filter(Pred, T, [H|Acc]);
        false -> filter(Pred, T, Acc)
    end.

%% Find the maximun in a list
max([H|T]) -> max2(T, H).

max2([],Max) -> Max;
max2([H|T], Max) when H > Max -> max2(T, H);
max2([_,T], Max) -> max2(T, Max).

%% Find the minimum of a list
min([H|T]) -> min2(T,H).
min2([H|T],Min) when H < Min -> min2(T,H);
min2([_|T],Min) -> min2(T,Min).

%% Sum all the elements of a list
sum(L) -> sum(L,0).
sum([], Sum) -> Sum;
sum([H|T], Sum) -> sum(T, H+Sum).

fold(_, Start, []) -> Start;
fold(F, Start, [H|T]) ->
    fold(F, F(H, Start), T).

filter2(Pred,L) ->
    F = fun(X,Acc) ->
        case Pred(X) of
            true  -> [X|Acc];
            false -> Acc
        end
    end,
    lists:reverse(fold(F, [], L)).


