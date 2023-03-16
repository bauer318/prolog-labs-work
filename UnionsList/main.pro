% Copyright

implement main
    open core,console,list

domains
    integerList = integer*.
class predicates
    присоединить:(integerList,integerList,integerList)nondeterm (o,i,i).
    комп_в_множ:(integerList,integerList) nondeterm (i,o).
    принадлежит:(integer, integerList) nondeterm (i,i).
    задание:(integerList,integerList,integerList) nondeterm (o,i,i).

clauses
    присоединить(L,[],[]):-L=[].
    присоединить([X1|Y1],[X2|Y2],L3):-X1=X2,
                                                      присоединить(Y1,Y2,L3).
    присоединить([X1|Y1],[],[X3|Y3]):-X1=X3,
                                                      присоединить(Y1,[],Y3).

    комп_в_множ([X1],[X1]):-!.
    комп_в_множ([X1|T1],[X1|T2]):-комп_в_множ(T1,T2),
                                                  not(принадлежит(X1,T2)),!.
    комп_в_множ([_|T1],T2):-комп_в_множ(T1,T2).

    принадлежит(X,[X|_]).
    принадлежит(X,[_|Y]):-принадлежит(X,Y).

    задание(Lout,L1,L2):-присоединить(Lout1,L1,L2),
                                  комп_в_множ(Lout1,Lout).


clauses
    run() :- задание(Lout, [1,2,3],[2,1,3,4]),write(Lout),!.
    run().


end implement main

goal
    console::runUtf8(main::run).