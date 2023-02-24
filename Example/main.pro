% Copyright

implement main
    open core,console

/*Examples */
domains
	месяц = string.
	день = integer.
	проезд = real.
	питание = real.
	гостиница = real.
class facts
    dop:(string).
    pod:(string).
    cka:(string).
    стипендия:(string, integer, integer).
    стипендия1:(string, integer, integer).
    summy:(проезд, питание, гостиница)determ.
clauses
    dop("He").
    dop("Kate").
    dop("Schenok").

    pod("Rununing").
    pod("Sings").
    pod("Sits").

    cka("on the ground").
    cka("On the bridge").
    cka("in the forest").

    стипендия("Иванов",943,800).
    стипендия("Петров",944,700).
    стипендия("Жак",943,318).

    расходы("май", 1, 100.0, 300.0, 150.0).
	расходы("май", 2, 250.0, 350.0, 200.0).
	расходы("май", 3, 150.0, 400.0, 180.0).
	расходы("май", 4, 200.0, 450.0, 300.0).

class predicates
    func:(integer, integer, integer) nondeterm(i,i,o).
    maximum:(integer, integer, integer) nondeterm(i,i,o).
    pred:(string,string,string) nondeterm anyflow.
    all_pred:() procedure.
    увеличение_стипендии:(integer) procedure anyflow.
    вывод_стипендии:() procedure.
    расходы:(месяц, день, проезд, питание, гостиница)
			nondeterm anyflow.
	расчет_итого:(месяц, проезд, питание, гостиница, real)
			nondeterm (i, o, o, o, o).
clauses
    func(L,K,Z):-L>20,Z=L div K.
    func(L,K,Z):-L<=20, Z=L mod K.
    maximum(X,Y,X):-X>Y.
    maximum(X,Y,Y):-X<=Y.
    pred(X,Y,Z):-dop(X),pod(Y),cka(Z).
    all_pred():-pred(X,Y,Z),write(" ",X," ",Y," ",Z),nl,fail.
    all_pred().
    увеличение_стипендии(H):-retract(стипендия(Fio,Ngr,St)),St1=St+H,asserta(стипендия1(Fio,Ngr,St1)),fail.
    увеличение_стипендии(H):-retract(стипендия1(Fio,Ngr,St)),asserta(стипендия(Fio,Ngr,St)),fail.
    увеличение_стипендии(H):-write("Done"),nl.
    вывод_стипендии():-стипендия(Fio,_,St),write(Fio," ",St),nl,fail.
    вывод_стипендии().
    расчет_итого(M, _ , _ , _ , _ ) :-
		assert(summy(0.0,0.0,0.0)),
		/* начальные значения */
		расходы(M, _ , Pr, Pi, Go),
		/* расходы за текущий день*/
		retract(summy(SPr1, SPi1, SGo1)),
		/*расходы за предыд. дни */
		SPr2 = SPr1 + Pr,
		SPi2 = SPi1 + Pi,
		SGo2 = SGo1 + Go,
		/*к итоговым суммам добавляем расходы за день */
		asserta(summy(SPr2, SPi2, SGo2)),
		/*сохраняем новые итоговые суммы*/
		fail.
	/* порождаем процесс возврата */
	расчет_итого(M, SPr, SPi, SGo, S):-
		retract(summy(SPr, SPi, SGo)),
		/* удаляем факт и извлекаем итоговые суммы */
		S = SPr + SPi + SGo.
		/*находим общую сумму расходов */

class predicates
    calculate:() procedure.
    findmax:() procedure.
clauses
    calculate():-write("Put L= "), L=read(),
                     write("Put K= "), K=read(),
                     func(L,K,Z),write("Z= ",Z),nl,fail.
    calculate().
    findmax():-maximum(2,4,M),write("max =",M),fail.
    findmax().
    /*run():-calculate(),findmax(),вывод_стипендии(),увеличение_стипендии(500),вывод_стипендии().*/
    run():-	console::init(),
		расчет_итого("май", SPr, SPi, SGo, S),
		write(SPr," ", SPi," ", SGo," ", S), nl,fail.
	run().


end implement main

goal
    console::runUtf8(main::run).