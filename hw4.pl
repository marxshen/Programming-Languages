myMaximum([],[])       :- !.
myMaximum([Max],Max)   :- !.
myMaximum([X,Y|T],Max) :-
        (   X =< Y
        ->  myMaximum([Y|T],Max)
        ;   myMaximum([X|T],Max)
        ).

myIntersection([],_,true) :- !.
myIntersection(_,[],true) :- !.
myIntersection(X,Y,Pred)  :-
        is_uniq(Y,X,Pred).

is_uniq([],_,true)    :- !.
is_uniq([H|_],Y,Pred) :-
        exist(H,Y), !,
        Pred = false.
is_uniq([_|T],Y,Pred) :-
        is_uniq(T,Y,Pred).

exist(E,[E|_]) :- !.
exist(E,[_|L]) :-
        exist(E,L).

myUnion([],L,L) :- !.
myUnion(L,[],L) :- !.
myUnion(X,Y,L1) :-
        merge(X,Y,L), !,
        trim(L,L1).

merge([],L,L)         :- !.
merge([H|T],L,[H|L1]) :-
        merge(T,L,L1).

trim([],[])    :- !.
trim([H|T],L1) :-
        trim(T,L), !,
        (   \+ exist(H,L)
        ->  L1 = [H|L]
        ;   L1 = L
        ).

myFinal([],[])         :- !.
myFinal([Final],Final) :- !.
myFinal([_|T],Final)   :-
        myFinal(T,Final).

myAllPairs([],_,[])    :- !.
myAllPairs(_,[],[])    :- !.
myAllPairs([H|T],Y,L3) :-
        pairs(H,Y,L), !,
        myAllPairs(T,Y,L1), !,
        merge(L,L1,L2), !,
        trim(L2,L3).

pairs(_,[],[])           :- !.
pairs(X,[Y|T],[(X,Y)|L]) :-
        pairs(X,T,L).