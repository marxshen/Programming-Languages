myAllPairs([],_,[]) :- !.
myAllPairs(_,[],[]) :- !.
myAllPairs([H|T],Y,L) :-
        pairs(H,Y,L1),!,
        myAllPairs(T,Y,L2),!,
        merge(L1,L2,L3),!,
        trim(L3,L).

pairs(_,[],[]) :- !.
pairs(X,[Y|T],[(X,Y)|L]) :-
        pairs(X,T,L).

merge([],L,L) :- !.
merge([H|T],L,[H|L1]) :-
        merge(T,L,L1).

trim([],[]) :- !.
trim([H|T],L) :-
        trim(T,L1),
        (   \+ exist(H,L1)
        ->  L = [H|L1]
        ;   L = L1
        ).

exist(E,[E|_]) :- !.
exist(E,[_|L]) :-
        exist(E,L).