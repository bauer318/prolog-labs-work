/*Лаба 06*/
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
    список_фильмов = название*.

    charlist = char*.
    stringlist = string*.
    integerlist = integer*.
class facts
    кинотеатр:(код_кт,название,адрес,телефон,кол_во_мест).
    кинофильм:(код_кф,название,год_выпуска,режиссер,число_серий).
    показывает:(код_кт,код_кф,дата,время,выручка).


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


    string_list:(string,charlist) nondeterm (i,o).
    поиск_по_маске:(string,string) nondeterm (i,i).
    search_char_in_charlist:(char,charlist,integer) nondeterm (i,i,o).
    search_chars_in_charlist:(charlist,charlist) procedure (i,i).
    удалить:(string, string, char)nondeterm (i,o,i).
    получить_список_фильмов:(список_кодов_фильмов,список_фильмов) nondeterm (i,o).
    поиск_название_фильмов_по_маске:(string,список_фильмов) nondeterm (i,i).
    длина_строки:(string,integer) nondeterm (i,o).
    count_chars_in_list:(charlist,integer,integer) nondeterm (i,i,o).
    string_word:(string,stringlist) nondeterm anyflow.
    string_length:(stringlist,integerlist) nondeterm (i,o).
    наибольшее:(integer, integer, integer) nondeterm (i, i, o).
    find_max_in_list:(integerlist,integer,integer) nondeterm (i,i,o).
    find_string:(stringlist,integer) nondeterm (i,i).

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

    %Преобразует строку на список
    string_list("",[]):-!.
    string_list(S,[X|T]):-
                            frontchar(S,X,S1),
                            string_list(S1,T).

    %поиск в строке String по маске Maska
    поиск_по_маске(String,Maska):-
                                               string_list(String,LS),
                                               string_list(Maska,LM),
                                               search_chars_in_charlist(LS,LM).

    длина_строки(String,Len):-string_list(String,LS),
                                              count_chars_in_list(LS,0,Len).


    count_chars_in_list([],Lin,Lout):-Lout=Lin,!.
    count_chars_in_list([_|T],Length,OutL):-Len = Length+1,
                                                    count_chars_in_list(T,Len,OutL).

    string_word(S,[H|T]):-frontToken(S,H,S1),!,
                                    string_word(S1,T).
    string_word(_,[]).

    string_length([X|T],[L|Z]):-длина_строки(X,L),
                                          string_length(T,Z).
    string_length([],[]):-!.

    наибольшее(X, Y, X):- X>Y.
	наибольшее(X, Y, Y):- X<=Y.

    find_max_in_list([],N,N2):-N2=N.
    find_max_in_list([X|T],N,N2):-наибольшее(N,X,Nout),
                                        find_max_in_list(T,Nout,N2).

    find_string([],_):-!.
    find_string([X|T],N):-длина_строки(X,Nout),
                                 N=Nout,nl,
                                 write(X),nl,
                                 find_string(T,N).
    find_string([X|T],N):-длина_строки(X,Nout),
                                 not(N=Nout),
                                 find_string(T,N).


    %поиск символ в список символов
    /*если символ из маски не находится в строке (название фильма)*/
    search_char_in_charlist(_,[],N):-N=0,write("       - этот фильм не включает только заданые символы"),nl,!.
    /*символ из маски находится в строке*/
    search_char_in_charlist(X,[X|_],N):-N=1,!.
    /*символ из маски не совпадает с первого элемента списка из строки*/
    search_char_in_charlist(X,[_|T],N):-search_char_in_charlist(X,T,N).



    /*поиск всех элементов второго списка в первом списке
        при нахождении элемента в обоих списках этот элемент удаяется из списков.
        если в конце у нас оба списка пустые, то строка (из первого списка)
        включает только заданные символы (из второго списка - маска), иначе
        строка не влючает только заданные символы.
    */
    search_chars_in_charlist([],[]):-write("       + этот фильм включает только заданые символы"),nl,!.
    search_chars_in_charlist([],_):-write("       - этот фильм не включает только заданые символы"),!.
    search_chars_in_charlist(_,[]):-write("       - этот фильм не включает только заданые символы"),!.
    search_chars_in_charlist([X|T],[X1|T1]):-
                                                            search_char_in_charlist(X1,[X|T],N),
                                                            N=1,
                                                            St = createFromCharList([X|T]),
                                                            St2 = createFromCharList([X1|T1]),
                                                            удалить(St,St_Out1,X1),
                                                            удалить(St2,St_Out2,X1),
                                                            string_list(St_Out1,LS),
                                                            string_list(St_Out2,LS2),
                                                            search_chars_in_charlist(LS,LS2),!.
    search_chars_in_charlist(_,_).

    %удаляет символ CharZ из строки StringI и возвращает новую строку StringO
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

    %Найти наименование, включаючее только заданные символы
    поиск_название_фильмов_по_маске(_,[]).
    поиск_название_фильмов_по_маске(Maska,[X|T]):-write("       поиск в названии фильма \"",X,"\" по маске :",Maska),nl,
                                                                            поиск_по_маске(X,Maska),
                                                                            поиск_название_фильмов_по_маске(Maska,T).


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

    вывод_список_фильмов_определенного_кинотеатра(Idkt):-nl,write("Список фильмов, идущих в кинотеатре ",Idkt," :"),nl,
                                                                                      findall(Idkf,показывает(Idkt,Idkf,_,_,_),List),
                                                                                      вывод_список_фильмов(List),
                                                                                      получить_список_фильмов(List,ListFilmName),
                                                                                      поиск_название_фильмов_по_маске("ikNat",ListFilmName).

    вывод_список_фильмов([]):-nl.
    вывод_список_фильмов([X|T]):-кинофильм(X,Film,_,_,_),
                                                 write(Film),nl,
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

    получить_список_фильмов([],L):-L=[].
    получить_список_фильмов([X|T], [X1|T2]):-  кинофильм(X,Film,_,_,_),
                                                                    X1 = Film,
                                                                    получить_список_фильмов(T,T2).




clauses
    /*run():-p(),!.
    run():-p2(1),!.*/
    run():-string_word("Je donnes mon travail au professeur",List),
    string_length(List,ListLen),
    write(ListLen),
    find_max_in_list(ListLen,0,N),nl,
    write("максимальная длина ",N),nl,
    find_string(List,N),nl,!.
    run().

end implement main

goal
    console::runUtf8(main::run).