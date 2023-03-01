% Copyright
% Jn+1 = 2*n*Jn-Jn-1, J1=0, J2=2
implement main
    open core,console

class predicates
    series_it:(integer,real) determ (i,o).
    repeat:() multi.
    series_asc:(integer,real,integer,real,real) nondeterm (i,o,i,i,i).
    series_asc:(integer,real) nondeterm (i,o).
    series_desc:(integer,real) nondeterm(i,o).

class facts
    temp:(integer,real, real) determ.

clauses
    repeat().
    repeat():-repeat().

    series_it(Q,J):-assert(temp(2,0.0,2.0)),
                        repeat(),
                        retract(temp(Q1,J1,J2)),
                        Q2 = Q1+1,
                        J3 = 2*Q1*J2-J1,
                        J = J3,
                        asserta(temp(Q2,J2,J3)),
                        Q2=Q,
                        retract(temp(_,_,_)),
                        !.
    series_desc(1,0.0):-!. /*начальные условия*/
    series_desc(2,2.0):-!.
    series_desc(Q,J):-Q1 = Q-1, /*Jn*/
                            series_desc(Q1,J1),
                            Q2 = Q-2, /*Jn-1*/
                            series_desc(Q2,J2),
                            J=2*Q1*J1-J2.

    series_asc(Q,J):- series_asc(Q,J,2,2.0,0.0).
    /*начальные условия*/
    series_asc(Q,J,Q,J,_):-!. /*терминальная ситуация*/
    series_asc(Q,J,K,J1,J2):-K1=K+1,
                                     J3=2*K*J1-J2,
                                     series_asc(Q,J,K1,J3,J1).

clauses
    run():-write("Введите q = "),
            Q=read(),
            series_it(Q,J1),
            series_desc(Q,J2),
            series_asc(Q,J3),
            nl,
            write("Итерационный метод : a",Q," = ",J1),
            nl,nl,
            write("Нисходящая рекурсия : a",Q," = ",J2),
            nl,nl,
            write("Восходящая рекурсия : a",Q," = ",J3),
            fail.
    run().


end implement main

goal
    console::runUtf8(main::run).