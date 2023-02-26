% Восходящая рекурсия
implement main
    open core,console

class predicates
    series:(integer, real) nondeterm (i,o).
    series:(integer,real,integer,real) nondeterm(i,o,i,i).

clauses
    series(N,A):- /*Основной предикат*/
                    series(N,A,0,1).
    series(N,A,N,A):-!. /*Терминальная ситуация K = N*/
    series(N,A,K,P):-K1 = K+1,
                          P1=K1*P+1/K1,
                          series(N,A,K1,P1).


clauses
    run():-write("Введите n = "), N=read(),series(N,A),nl, write("a",N," = ",A),nl,fail.
    run().

end implement main

goal
    console::runUtf8(main::run).