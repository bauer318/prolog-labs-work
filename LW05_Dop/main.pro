% Copyright

implement main
    open core,console

domains
       integerList = integer*.

class predicates
    разность:(integerList,integerList,integerList) nondeterm (i,i,o).
    принадлежит:(integer,integerList) nondeterm.



clauses
    разность(L,[],L).
    разность([],_,[]).
    разность([X|T],L1,[X2|T2]):-not (принадлежит(X,L1)),
                                            X2=X,
                                            разность(T,L1,T2).
    разность([X|T],L1,L):-принадлежит(X,L1),
                                                    разность(T,L1,L).

    принадлежит(X,[X|_]).
    принадлежит(X,[_|Y]):-принадлежит(X,Y).

clauses
    run():-разность([10,8,5,6],[10,5,20,3],L1),
             write(L1,"  "),nl,fail.
    run().

end implement main

goal
    console::runUtf8(main::run).