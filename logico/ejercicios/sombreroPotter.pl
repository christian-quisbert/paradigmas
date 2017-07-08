/*Base de Conocimiento*/
mago(harry,mestiza,[coraje,amistad,orgullo,inteligencia]).
mago(ron,pura,[amistad,diversion,coraje]).
mago(hermione,impura,[inteligencia,coraje,responsabilidad,amistad,orgullo]).
mago(hannahAbbott,mestiza,[amistad,diversion]).
mago(draco,pura,[inteligencia,orgullo]).
mago(lunaLovegood,mestiza,[inteligencia,responsabilidad,amistad,coraje]).
mago(Mago):-
	mago(Mago,_,_).

casa(gryffindor).
casa(hufflepaff).
casa(ravenclaw).
casa(slytherin).

odia(harry,slytherin).
odia(draco,hufflepuff).

caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).

caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).

caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).

caracteriza(hufflepaff,amistad).
caracteriza(hufflepaff,diversion).

/*Punto 1*/
permiteEntrar(Casa,Mago):-
	mago(Mago),
	casa(Casa),
	not((Casa = slytherin, mago(Mago,impura,_))).
	
/*Punto 2*/
tieneCaracter(Mago,Casa):-
	casa(Casa),
	mago(Mago,_,Caracteristicas),
	forall(caracteriza(Casa,Caracter),	member(Caracter,Caracteristicas)).

/*Punto 3*/
casaPosible(Mago,Casa):-
	tieneCaracter(Mago,Casa),
	permiteEntrar(Mago,Casa),
	not(odia(Mago,Casa)).

/*Punto 4*/  /*No funciona*/
cadenaDeAmistades(Magos):-
	forall(member(Mago,Magos),caracterizaAmistad(Mago)),
	cumpleCasa(Magos).

caracterizaAmistad(Mago):-
	mago(Mago,_,Caracteristicas),
	member(amistad,Caracteristicas).

cumpleCasa([Mago1,Mago2|[]]):-
	casaPosible(Mago1,Casa),
	casaPosible(Mago2,Casa),
	Mago1 \= Mago2.

cumpleCasa([Mago1,Mago2|Magos]):-
	casaPosible(Mago1,Casa),
	casaPosible(Mago2,Casa),
	Mago1 \= Mago2,
	cumpleCasa([Mago2|Magos]).

/*Punto 5*/
alumno(Alumno):-
	hizo(Alumno,_).

esBuenAlumno(Alumno):-
	alumno(Alumno),
	not((hizo(Alumno, Accion),puntaje(Alumno, Accion, Puntaje), Puntaje < 0)).

puntaje(Alumno,responder(_,_,Profesor),0):-
	alumnoOdiado(Profesor, Alumno).

puntaje(Alumno,responder(_,Dificultad, Profesor),Puntaje):-
	alumnoFavorito(Profesor, Alumno),
	Puntaje is Dificultad * 2.

puntaje(Alumno,responder(_,Dificultad,Profesor),Dificultad):-
	not(alumnoOdiado(Profesor,Alumno)),
	not(alumnoFavorito(Profesor,Alumno)).


