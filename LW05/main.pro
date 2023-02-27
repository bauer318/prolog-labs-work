% Copyright
/*Лаба 01*/
implement main
    open core, console
/*Типы данных*/
domains
    fio=string. facultet=string. discip=string. tip=string.
    kaf=string. tel=string. denj=string. c_z=string.
    ngrouppa=integer. kol_vo=integer. schifr=integer.
    nau=integer. vrem=integer.
    stringlist=string*. aud=aud(nau,kol_vo).
    audList=aud*.
class facts
    student:(fio,ngrouppa).
    grouppa:(ngrouppa, facultet, kol_vo,fio).
    discipline:(schifr,discip,kol_vo).
    teachers:(fio,kqf,tel).
    auditorie:(nau,tip,kol_vo).
    shedule:(ngrouppa,schifr,fio,nau,denj,vrem,c_z).

class predicates
    list_goup_1:(ngrouppa,kol_vo) nondeterm (i,o).
    outputL:(stringlist) nondeterm anyflow.
    dlina:(stringlist, kol_vo) nondeterm anyflow.
    aud_max:(aud,audList) nondeterm anyflow.
    max:(aud,aud,aud) nondeterm anyflow.
    p:() nondeterm.
    aud_kol:(aud) nondeterm anyflow.

clauses
    grouppa(243,"Fvt",23,"Bauer").
    grouppa(243,"Fvt",25,"Jack").

    student("Ivanov",243).
    student("Petrov",243).
    student("Ivangin",243).
    student("Luneva",243).
    student("Volkov",244).
    student("Mosin",244).

    auditorie(132 "aud",30).
    auditorie(206 "lab",300).
    auditorie(403 "aud",30).
    auditorie(411 "aud",10).

    list_goup_1(Ng,Nst):-
                            findall(F,student(F,Ng),List),
                            outputL(List),
                            dlina(List,Nst).

    outputL([]).
    outputL([X|T]):- write(" ",X),
                            nl,
                            outputL(T).


    dlina([],0).
    dlina([X|T]):-dlina(T,N1),
                       N = N1+1.

    aud_kol(aud(Aud,Nsa)):-auditorie(Aud,_,Nsa).
    aud_max(Audmax):-
                            findall(Aud,aud_kol(Aud),List),
                            maxList(Audmax,List).


clauses
    run():-input_film_list(L),nl,write("List ",L),nl,output_film_list(L),!.
    run().

end implement main

goal
    console::runUtf8(main::run).