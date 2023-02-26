% Copyright

implement main
    open core,console

class predicates
    series:(integer, real) nondeterm (i,o).

clauses
    series(0,1):-!. /*начальные условия*/
    series(K,A):-K1 = K - 1,
                    series(K1,A1),
                    A = K*A1+1/K.

clauses
    run():-write("Введите n = "), N=read(),series(N,A),nl, write("a",N," = ",A),nl,fail.
    run().

end implement main

goal
    console::runUtf8(main::run).