%--- Base de conocimiento ---%
programa(fernando,cobol).
programa(fernando,visualBasic).
programa(fernando,java).
programa(julieta,java).
programa(marcos,java).
programa(santiago,ecmaScript).
programa(santiago,java).

rol(fernando,analistaFuncional).
rol(andres,projectLeader).
rol(Persona,programador):-
    esProgramador(Persona).
    
esProgramador(Alguien):-
	programa(Alguien,_).

%----------------------------------%
%---------- Tp2 - lógico ----------%
%----------------------------------%

%--- Punto 1.2.1 Proyectos ---%
persona(Persona):-
    rol(Persona,_).

% proyecto(Nombre,[Lenguaje]) %
proyecto(sumatra,java).
proyecto(sumatra,pnet).
proyecto(prometeus,cobol).
proyecto(Proyecto):-
	proyecto(Proyecto,_).

% trabaja([Persona],Proyecto) %
trabaja(julieta,sumatra).
trabaja(marcos,sumatra).
trabaja(andres,sumatra).
trabaja(fernando,prometeus).
trabaja(santiago,prometeus).

%--- Punto 1.2.2 Proyectos ---%
bienAsignada(Persona,Proyecto):-
	persona(Persona),
	proyecto(Proyecto),
	trabaja(Persona,Proyecto),
	condicionDeAceptacion(Persona,Proyecto).

%-- a --%
condicionDeAceptacion(Persona,Proyecto):-	programaEnProyecto(Proyecto,Persona).
condicionDeAceptacion(Persona,_):-	rol(Persona,analistaFuncional).
condicionDeAceptacion(Persona:_):-	rol(Persona,projectLeader).

%-- b --%
programaEnProyecto(Proyecto,Persona):-
	persona(Persona),
	proyecto(Proyecto),
	programa(Persona,Lenguaje),	%/*Obtengo el LENGUAJE de Persona*/
	proyecto(Proyecto, Lenguajes),	%/*Obtengo los LNGUAJES de Proyecto*/
	member(Lenguaje,Lenguajes).	%/*Busco LENGUAJE en LENGUAJES*/

%--- Punto 1.3 Validación de Proyectos ---%
bienDefinido(Proyecto):-
	proyecto(Proyecto),
	forall(trabaja(Persona,Proyecto), bienAsignada(Persona,Proyecto)),
	findall(Persona, (trabaja(Persona,Proyecto), rol(Persona,projectLeader)), ProyectLeaders),
	length(ProyectLeaders,Cantidad),
	Cantidad = 1.
%	/*
%	trabaja(Persona,Proyecto), rol(Persona,projectLeader),
%	not(( trabaja(OtraPersona,Proyecto), rol(OtraPersona,projectLeader),(Persona \= OtraPersona))).
%	*/

%----------------------------------%
%---------- Tp3 - lógico ----------%
%----------------------------------%

/*--- Punto 1.1 ---*/
esCopado(fernando,	santiago).
esCopado(santiago, julieta).
esCopado(julieta, andres).
escopado(santiago, marcos).


copado(Persona1, Persona2):-
	esCopado(Persona1, Persona2).
copado(Persona1, Persona2):-
	esCopado(Persona1, PersonaIntermedia),
	copado(PersonaIntermedia, Persona2).	
	
lePuedeEnseniar(Persona1, Persona2, Lenguaje):-
	persona(Persona1),
	persona(Persona2),
	programa(Persona1,Lenguaje),
	not(programa(Persona2,Lenguaje)),
	copado(Persona1,Persona2).

/*lepuedeEnseñar(Persona1,Persona2,_):-
	copado(Persona1,Persona2).	*/


/*--- Punto 1.2 ---*/
tarea(fernando, evolutiva(compleja)).  
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algoritmica(150)).
tarea(marcos, algoritmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)).


seniority(Persona,Puntos):-
	persona(Persona),
	findall(PuntosDeUnaTarea,(tarea(Persona,Tarea), puntaje(Tarea,PuntosDeUnaTarea)),Puntajes),
	sum_list(Puntajes,Puntos).

puntaje(evolutiva(compleja),Puntos):-	Puntos = 5.
puntaje(evolutiva(simple),	Puntos):-	Puntos = 3.
puntaje(correctiva(Lineas,_),Puntos):-	Lineas > 50,	Puntos = 5.
puntaje(correctiva(_,brainfuck),Puntos):-	Puntos = 5.
puntaje(algoritmica(N),	Puntos):-		Puntos = N / 10.


%----------------------------------------------%
%-------------------- TEST  2 -----------------%
%----------------------------------------------%
/*
:- begin_tests(programadores).

% Test Entrega 2 - Punto 2 Proyectos
test(lenguajesDeSumatra, nondet) :-
	proyecto(sumatra,java),
	proyecto(sumatra,pnet).
        
test(lenguajesDeSumatraExplicito, set(Lenguajes == [java, pnet])) :-
	proyecto(sumatra, Lenguajes).

test(lenguajesDePrometeusEsSoloCobol, set(Lenguajes == [cobol])) :-
    proyecto(prometeus,Lenguajes).

test(fernandoTrabajaEnPrometeus,nondet) :-
    trabaja(fernando, prometeus).

test(santiagoTrabajaEnPrometeus) :-
    trabaja(santiago, prometeus).

test(genteDeSumatra, set(Personas == [julieta, marcos, andres])) :-
    trabaja(Personas, sumatra).

test(trabajadoresDeSumatraBienAsignados, set(Gente == [julieta, marcos, andres])):-
	bienAsignada(Gente, sumatra).

test(trabajadoresDePrometeusBienAsignados, set(Gente == [fernando])) :-
    bienAsignada(Gente, prometeus).


test(trabajadoresBienAsignados, set(Gente == [julieta, marcos, andres, fernando])) :-
	bienAsignada(Gente, _).

test(proyectosConGenteBienAsignada, set(Proyectos == [prometeus, sumatra])) :-
	bienAsignada(_, Proyectos).


% Punto 3 - Proyectos bien definidos

test(proyectosBienDefinidos, set(Proyectos == [sumatra])) :-
    bienDefinido(Proyectos).

test(prometeusNoEstaBienDefinido):-
    not(bienDefinido(prometeus)).

test(proyectosMalDefinidos, set(Proyectos == [prometeus])) 	:-
    proyecto(Proyectos), not(bienDefinido(Proyectos)).

:- end_tests(programadores).
*/

%----------------------------------------------%
%-------------------- TEST  3 -----------------%
%----------------------------------------------%

:- begin_tests(programadores).

% ... tests anteriores ...

% Punto 4 - Te copas?

test(fernandoEsCopadoConSantiago, nondet) :-
    esCopado(fernando, santiago).

test(fernandoNoEsCopadoConJulieta, nondet) :-
    not(esCopado(fernando, julieta)).
        
test(aQuienesLesEnseniaFernandoCobol, set(Gente == [santiago, julieta, marcos, andres])) :-
    lePuedeEnseniar(fernando, Gente, cobol).

test(fernandoNoLeEnseniaHaskellAAlguien, nondet) :-
    not(lePuedeEnseniar(fernando, _, haskell)).

test(quienesLeEnsenianJavaAAndres, set(Gente == [santiago, julieta, fernando])) :-
    lePuedeEnseniar(Gente, andres, java).

test(queLenguajesEnseniaFernandoAAlguien, set(Lenguajes == [cobol, visualBasic, java])) :-
    lePuedeEnseniar(fernando, _, Lenguajes).

test(marcosNoPuedeEnseniarNadaANadie, nondet) :-
    not(lePuedeEnseniar(marcos, _, _)).

% Punto 5 - Seniority
test(fernandoTiene24DeSeniority, set(Puntajes == [25])) :-
    seniority(fernando, Puntajes).

test(genteSinSeniority, set(Gente == [santiago, andres])) :-
    seniority(Gente, 0).

test(julietaNoTieneSeniority6, nondet) :-
    not(seniority(julieta, 6)).

test(julietaTieneSeniority7, nondet) :-
    seniority(julieta, 8).

:- end_tests(programadores).

