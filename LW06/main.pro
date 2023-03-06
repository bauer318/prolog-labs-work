/*Лаба 05*/
implement main
    open core, console,string, string8,list
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


    список_кодов_фильмов = код_кф*.
    список_кодов_кинотеатров = код_кт*.
    список_выручки=выручка*.

    charlist = char*.
class facts
    кинотеатр:(код_кт,название,адрес,телефон,кол_во_мест).
    кинофильм:(код_кф,название,год_выпуска,режиссер,число_серий).
    показывает:(код_кт,код_кф,дата,время,выручка).
    match:(integer) determ.


class predicates
    p:() nondeterm.
    принадлежит:(код_кт,список_кодов_кинотеатров) nondeterm.
    принадлежит:(код_кф,список_кодов_фильмов) nondeterm.
    комп_в_множ:(список_кодов_кинотеатров,список_кодов_кинотеатров) nondeterm (i,o).
    комп_в_множ:(список_кодов_фильмов,список_кодов_фильмов) nondeterm (i,o).
    вывод_список_фильмов_определенного_кинотеатра:(код_кт) nondeterm.
    вывод_список_фильмов:(список_кодов_фильмов) nondeterm.
    вывод_список_фильмов_в_каждом_кинотеатре:(список_кодов_кинотеатров) nondeterm.
    вычислить_сумму_выручки_по_фильму:(список_выручки,выручка) nondeterm (i,i).
    p2:(код_кт) nondeterm.
    вывод_общую_сумму_выручки:(код_кт,список_кодов_фильмов) nondeterm.
    вывод_название_фильма_по_коду:(код_кф) nondeterm.


    string_list:(string,charlist) nondeterm anyflow.
    поиск_по_маске:(string,string) nondeterm (i,i).
    search_char_in_charlist:(char,charlist,integer) nondeterm anyflow.
    search_chars_in_charlist:(charlist,charlist,string) nondeterm anyflow.
    удалить:(string, string, char)nondeterm (i,o,i).
    assert_retract:(integer) determ.

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
    кинофильм(1,"Nikita",1997,"Joel Surnow",96).
    кинофильм(2,"Scorpion",2014,"Nick Santora",91).
    кинофильм(3,"The Blacklist",2013,"Jon Bokenkamp",196).
    кинофильм(4,"24 chrono",2001,"Joel Surnow",204).
    кинофильм(5,"Designed Survivor",2016,"David Guggenheim",53).
    кинофильм(6,"Game of thrones",2011,"David Friedman",73).
    кинофильм(7,"Breaking Bad",2013," Vince Gilligan",62).
    /*Определение отношения <показывает>(<код_кт>,<код_кф>,
                            <дата>,<время>,<выручка>)*/
    показывает(1,4,"17.01.2023",20,2780).
    показывает(2,4,"17.01.2023",21,1764).
    показывает(1,2,"20.02.2023",16,5745).
    показывает(4,3,"18.01.2023",15,2780).
    показывает(1,6,"18.01.2023",20,8754).
    показывает(2,6,"21.01.2023",17,2478).
    показывает(4,1,"19.02.2023",19,4578).
    показывает(1,6,"20.01.2023",20,5000).

clauses
    assert_retract(N):-retract(match(_)),
                              assert(match(N)).


    string_list("",[]):-!.
    string_list(S,[X|T]):-
                            frontchar(S,X,S1),
                            string_list(S1,T).

    поиск_по_маске(String,Maska):-
                                               string_list(String,LS),
                                               string_list(Maska,LM),
                                               search_chars_in_charlist(LS,LM,Maska).
    поиск_по_маске(_,_).


    search_char_in_charlist(_,[],N):-N=0,!.
    search_char_in_charlist(X,[X|_],N):-N=1,!.
    search_char_in_charlist(X,[_|T],N):-search_char_in_charlist(X,T,N).


    search_chars_in_charlist([],[],Str):-write(" этот фильм включает только заданые символы : ",Str),!.
    search_chars_in_charlist([],_,_):-!.
    search_chars_in_charlist(_,[],_):-!.
    search_chars_in_charlist([X|T],[X1|T1],Str):-
                                                            search_char_in_charlist(X1,[X|T],N),
                                                            N=1,
                                                            St = createFromCharList([X|T]),
                                                            St2 = createFromCharList([X1|T1]),
                                                            удалить(St,St_Out1,X1),
                                                            удалить(St2,St_Out2,X1),
                                                            string_list(St_Out1,LS),
                                                            string_list(St_Out2,LS2),
                                                            search_chars_in_charlist(LS,LS2,Str).

    удалить("","",_).
    удалить(StringI, StringO, CharZ):-
                                                frontChar(StringI, Символ, String1),
                                                удалить(String1, StringO1, CharZ),
                                                Символ = CharZ,
                                                StringO =StringO1,!.

   удалить(StringI, StringO, CharZ):-
                                                frontChar(StringI, Символ, String1),
                                                Str = charToString(Символ),
                                                удалить(String1, StringO1, CharZ),
                                                Символ <> CharZ,
                                                StringO = concat(StringO1,Str).

clauses

    /*Список фильмов, идущих в каждом кинотеатре*/
    p():-findall(Idkt,показывает(Idkt,_,_,_,_),List),
          комп_в_множ(List,NonRepetList),
          вывод_список_фильмов_в_каждом_кинотеатре(NonRepetList).

    /*Подсчитать общую сумму выручки по каждому фильму в заданном кинотеатре*/
    p2(Idkt):-write("Общие суммы по каждому фильму в кинотеатре ",Idkt),nl,
                  findall(Idkf,показывает(Idkt,Idkf,_,_,_),List),
                  комп_в_множ(List,NonRepetList),
                  вывод_общую_сумму_выручки(Idkt,NonRepetList).


    вывод_список_фильмов_в_каждом_кинотеатре([X|T]):-вывод_список_фильмов_определенного_кинотеатра(X),
                                                                                  вывод_список_фильмов_в_каждом_кинотеатре(T).

    вывод_список_фильмов_определенного_кинотеатра(Idkt):-write("Список фильмов, идущих в кинотеатре ",Idkt," :"),nl,
                                                                                      findall(Idkf,показывает(Idkt,Idkf,_,_,_),List),
                                                                                      вывод_список_фильмов(List).

    вывод_список_фильмов([]):-nl.
    вывод_список_фильмов([X|T]):-кинофильм(X,Film,_,_,_),
                                                 write("  ",Film),
                                                 поиск_по_маске(Film,"ikitaN"),nl.
                                                 вывод_список_фильмов(T).

    комп_в_множ([X1],[X1]):-!.
    комп_в_множ([X1|T1],[X1|T2]):-комп_в_множ(T1,T2),
                                                  not(принадлежит(X1,T2)),!.
    комп_в_множ([_|T1],T2):-комп_в_множ(T1,T2).

    принадлежит(X,[X|_]).
    принадлежит(X,[_|Y]):-принадлежит(X,Y).

    вычислить_сумму_выручки_по_фильму([],Recete):-write(" : ",Recete).
    вычислить_сумму_выручки_по_фильму([X|T],Recete):- N = X + Recete,
                                                                                 вычислить_сумму_выручки_по_фильму(T,N).

    вывод_общую_сумму_выручки(_,[]).
    вывод_общую_сумму_выручки(Idkt,[X|T]):-вывод_название_фильма_по_коду(X),
                                                                findall(Rec,показывает(Idkt,X,_,_,Rec),List),
                                                                вычислить_сумму_выручки_по_фильму(List,0),nl,
                                                                вывод_общую_сумму_выручки(Idkt,T).

    вывод_название_фильма_по_коду(Idkf):-кинофильм(Idkf,Film,_,_,_),write(Film).



clauses
    run():-p(),!.
    run():-p2(1),!.
    %run():- поиск_по_маске("Nikot","iktoNe"),nl,!.
    run().
    %run().

end implement main

goal
    console::runUtf8(main::run).