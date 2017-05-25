# Base de Conocimiento
nota(lucas,8).
nota(pedro,7).
nota(romina,10).
nota(xander,2).

docente(dodain).
docente(tefi).
docente(alf).

viveEn(dodain,liniers).
viveEn(alf,lanus).
viveEn(tefi,lanus).

% r:- p , q (Cláusula de Horn)
aprobo(Alumno):-
	nota(Alumno,Nota),
	Nota >= 6.



afortunado(Docente):-
	docente(Docente).
afortunado(Docente):-
	viveEn(Docente,lanus). 
