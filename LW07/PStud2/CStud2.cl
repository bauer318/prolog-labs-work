% Copyright

class cStud2
    open core
domains
	группа = integer. фио = string.
	возраст = integer. оценка = integer.
predicates
	classInfo : core::classInfo.
	группа_п:(группа) nondeterm (o) (i) .
	студент_п:(фио, группа) nondeterm (o,o) (i,o) (o,i) (i,i).
	возраст_студента_п:(фио, возраст)
		nondeterm (o,o) (i,i) (i,o) (o,i).
	оценки_средний_балл:(фио, оценка, оценка, оценка, real)
		nondeterm (i,o,o,o,o) .
end class cStud2