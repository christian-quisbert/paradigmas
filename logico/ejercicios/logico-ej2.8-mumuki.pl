puedeUsar(Operador,Tipo):-
	seRelaciona(Tipo,Typeclass),
	estaDefinido(Operador,Typeclass).

seRelaciona(Tipo,Typeclass):-
	pertenece(Tipo,Typeclass).
seRelaciona(Tipo,Typeclass):-
	pertenece(Tipo,TypeclassHijo),
	incluido(TypeclassHijo,Typeclass).

incluido(fractional,num).
pertenece(int,num).
estaDefinido(sumar,num).
