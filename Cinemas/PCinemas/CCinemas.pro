% Copyright

implement cCinemas
    open core
constants
	className = "PCinemas/cCinemas".
	classVersion = "".
clauses
	classInfo(className, classVersion).
class facts - filmDB
    кинотеатр:(код_кт,название,адрес,телефон,кол_во_мест).
    кинофильм:(код_кф,название,год_выпуска,режиссер,число_серий).
    показывает:(код_кт,код_кф,дата,время,выручка).
class facts
    currentDirectory: string:="".
clauses
    /*определение отношения <телефон_кинотеатра>(<телефон>,<название_фильма>)*/
        телефон_кинотеатра_п(TEL,F):-кинофильм(IDKF,F,_,_,_),
                                                 кинотеатр(IDKT,_,_,TEL,_),
                                                 показывает(IDKT,IDKF,_,_,_).
        /*определение отношения <кинотеатр_режиссер>(<режиссер>,<название>)*/
        кинотеатр_режиссер_п(REG,KINO):-кинотеатр(IDKT,KINO,_,_,_),
                                                      кинофильм(IDKF,_,_,REG,_),
                                                      показывает(IDKT,IDKF,_,_,_).

        кинофильм_п(Id,Film,Date,Reg,Ep):-кинофильм(Id,Film,Date,Reg,Ep).
        кинотеатр_п(Id,Cine,Adress, Tel, Site):-кинотеатр(Id,Cine,Adress,Tel,Site).

        reconsult(Filename) :-
                                    retractFactDB(filmDB),
                                    file::consult(Filename,filmDB).
        загрузитьБД():-
                        currentDirectory:=directory::getCurrentDirectory(),
                        directory::setCurrentDirectory("..\\"),
                        Filename = vpiCommonDialogs::getFileName("*.txt",["БД Аптек (*.txt)","*.txt","Все файлы","*.*"],"\nЗагрузка...\n", [], ".", _),
                        directory::setCurrentDirectory(currentDirectory),! ,
                        reconsult(Filename),
                        stdIO::writef("База данных % загружена\n", Filename).
        загрузитьБД().

        сохранитьБД():-
                            currentDirectory:=directory::getCurrentDirectory(),
                            directory::setCurrentDirectory("..\\"),
                            Filename =vpiCommonDialogs::getFileName( "",
                            ["Text files (*.txt)", "*.*"],
                            "Загрузка БД о студентах", [], ".", _),
                            directory::setCurrentDirectory(currentDirectory), ! ,
                            file::save(Filename,filmDB),
                            stdIO::writef("База данных % сохранена\n", Filename).
        сохранитьБД().




end implement cCinemas