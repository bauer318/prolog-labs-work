% Copyright

class cCinemas
    open core
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
predicates
    classInfo : core::classInfo.
    телефон_кинотеатра_п:(телефон,название) nondeterm (o,i).
    кинотеатр_режиссер_п:(режиссер,название) nondeterm (i,o).
    кинотеатр_п:(код_кт,название,адрес,телефон,кол_во_мест) nondeterm (i,i,i,i,i) (o,o,o,o,o).
    кинофильм_п:(код_кф,название,год_выпуска,режиссер,число_серий) nondeterm (i,i,i,i,i) (o,o,o,o,o).

    reconsult:(string FileName).
    загрузитьБД:().
    сохранитьБД:().


end class cCinemas