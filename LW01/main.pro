﻿% Copyright
/*Лаба 01*/
implement main
    open core, console
/*Типы данных*/
domains
    код_кт=integer.
    название=string.
    адрес=string.
    телефон=string.
    кол_во_мест=integer.
    код_кф=integer.
    год_выпуска=integer.
    режиссер=string.
    число_серий=integer.
    дата=string.
    время=integer.
    выручка=integer.
class facts
    кинотеатр:(код_кт,название,адрес,телефон,кол_во_мест).
    кинофильм:(код_кф,название,год_выпуска,режиссер,число_серий).
    показывает:(код_кт,код_кф,дата,время,выручка).
/*Определение отношениий с помощью фактов*/
clauses
    /*Определение отношения <кинотеатр>(<код_кт>,<название>,
                            <адрес>,<телефон>,<кол_во_мест>)*/
    кинотеатр(1,"кинотеатр 1","Гагарина дом 63/29","999-000-854",50).
    кинотеатр(2,"кинотеатр 2","4я линия дом 27","999-111-245",100).
    кинотеатр(3,"кинотеатр 3","Татарская дом 68","999-245-854",125).
    кинотеатр(4,"кинотеатр 4","Виктория дом 104","995-745-854",11).
    /*Определение отношения <кинофильм>(<код_кф>,
                            <название>,<год_выпуска>,<режиссер>,<число_серий>)*/
    кинофильм(1,"24 chrono",2001,"Bauer",9).
    кинофильм(2,"Scorpion",2006,"Walter",4).
    кинофильм(3,"Black List",2011,"Agent Gol",7).
    кинофильм(4,"Designed Survivor",2016,"Bauer",9).
    кинофильм(5,"Game of throne",2017,"Cameron",5).
    кинофильм(6,"Breaking Bad",2019,"Eddy",2).
    /*Определение отношения <показывает>(<код_кт>,<код_кф>,
                            <дата>,<время>,<выручка>)*/
    показывает(1,4,"17.01.2023",20,2780).
    показывает(2,4,"17.01.2023",21,1764).
    показывает(1,2,"20.02.2023",16,5745).
    показывает(3,3,"18.01.2023",15,2780).
    показывает(5,6,"18.01.2023",20,8754).
    показывает(4,6,"21.01.2023",17,2478).
    показывает(3,1,"19.02.2023",19,4578).
class predicates
    телефон_кинотеатра:(телефон,название)nondeterm anyflow.
    кинотеатр_режиссер:(режиссер,название)nondeterm anyflow.
clauses
/*Определение отношений с помощью правил*/
        /*определение отношения <телефон_кинотеатра>(<телефон>,<название_фильма>)*/
        телефон_кинотеатра(TEL,F):-кинофильм(IDKF,F,_,_,_),кинотеатр(IDKT,_,_,TEL,_),
                                           показывает(IDKT,IDKF,_,_,_).
        /*определение отношения <кинотеатр_режиссер>(<режиссер>,<название>)*/
        кинотеатр_режиссер(REG,KINO):-кинотеатр(IDKT,KINO,_,_,_),
                                                кинофильм(IDKF,_,_,REG,_),
                                                показывает(IDKT,IDKF,_,_,_).

clauses
    run() :- console::init(),
                write("Введите название нужного филма :"),
                Film = readLine(),
                nl, write("телефон кинотеатра, показывающего фильм ",Film),
                nl,телефон_кинотеатра(Tel, Film),
                write(Tel),nl,
                fail.
    run() :- console::init(),nl,
                write("Введите имя режиссера :"),
                REG = readLine(),
                nl, write("Фильмы режиссера ",REG," идут в кинотеатрах "),
                кинотеатр_режиссер(REG, Kino),nl,
                write(Kino),fail.

    run().

end implement main

goal
    console::runUtf8(main::run).