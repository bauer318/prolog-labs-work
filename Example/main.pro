% Copyright

implement main
    open core,console

/*Программа "Студенты" */
domains
    student=string.
    facultet=string.
    gruppa=integer.
class facts
    студент:(student, gruppa).
    наим_фак:(integer,facultet).
    группа:(gruppa).
clauses
/*Определение отношения Группа с помощью фактов*/
    группа(943).
    группа(9413).
    группа(043).
/*Определение отношения Студент с помощью фактов*/
    студент("Орлова Л.И.",943).
    студент("Семенова М.П.",232).
    студент("Цуканова В.В.",943).
/*Определение отношения Наименование факультета с помощью фактов*/
    наим_фак(1,"РТФ").
    наим_фак(2,"ФЭ").
    наим_фак(3,"ФАИТУ").
    наим_фак(4,"ФВТ").
    наим_фак(7,"ИЭФ").
class predicates
    факультет:(gruppa, facultet)nondeterm anyflow.
    вторая_цифра:(gruppa, integer)nondeterm anyflow.
clauses
/*Определение отношения Факультетк с помощью правила*/
    факультет(NG,F):-вторая_цифра(NG,G2),наим_фак(G2,F).
/*Определение отношения вторая цифра  с помощью правила*/
    вторая_цифра(NG,G2):-G1=NG mod 100, G2 = G1 div 10.
clauses
    run() :- группа(Gruppa),студент(Student, Gruppa),
                факультет(Gruppa,Facultet),
                write(Student," ",Gruppa, " ", Facultet), nl,
                fail.
    run().
        %succeed. % place your own code here
end implement main

goal
    console::runUtf8(main::run).