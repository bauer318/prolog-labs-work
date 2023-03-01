% Copyright

implement main
    open core,console

class predicates
    series_asc:(integer,real) nondeterm (i,o).
    series_asc:(integer,real,integer,real) nondeterm (i,o,i,i).
    series_desc:(integer,real) nondeterm (i,o).
    series_it:(integer,real) determ (i,o).
    repeat:() multi.
class facts
    response:(integer,real) determ.


clauses
    repeat().
    repeat():-repeat().
    series_it(K,A):-assert(response(0,1)),
                    repeat(),
                    retract(response(K1,A1)),
                    K2 = K1+1,
                    P= K2*A1+1/K2,
                    A = P,
                    asserta(response(K2,P)),
                    K2 = K,retract(response(_,_)),!.

    series_desc(0,1):-!. /*начальные условия*/
    series_desc(K,A):-K1 = K - 1,
                    series_desc(K1,A1),
                    A = K*A1+1/K.

    series_asc(N,A):- /*Основной предикат*/
                    series_asc(N,A,0,1).
    series_asc(N,A,N,A):-!. /*Терминальная ситуация K = N*/
    series_asc(N,A,K,P):-K1 = K+1,
                          P1=K1*P+1/K1,
                          series_asc(N,A,K1,P1).

clauses
    run():-write("Введите n = "),
            N=read(),
            series_it(N,A1),
            series_desc(N,A2),
            series_asc(N,A3),
            nl,
            write("Итерационный метод : a",N," = ",A1),
            nl,nl,
            write("Нисходящая рекурсия : a",N," = ",A2),
            nl,nl,
            write("Восходящая рекурсия : a",N," = ",A3),
            fail.
    run().

end implement main

goal
    console::runUtf8(main::run).