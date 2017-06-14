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
proyecto(sumatra,[java,pnet]).
proyecto(prometeus,[cobol]).

% trabaja([Persona],Proyecto) %
trabaja([julieta,marcos,andres],sumatra).
trabaja([fernando,santiago],prometeus).

proyecto(Proyecto):-
    proyecto(Proyecto,_).

%--- Punto 1.2.2 Proyectos ---%
%-- a --%
bienAsignada(Persona,Proyecto):-
	persona(Persona),
	proyecto(Proyecto),
	forall(trabaja(Personas,Proyecto), (member(Persona,Personas),programaEnProyecto(Proyecto,Persona))).
%-- b --%
bienAsignada(Persona,Proyecto):-
	persona(Persona),
	proyecto(Proyecto),
	forall(trabaja(Personas,Proyecto),(member(Persona,Personas), rol(Persona,analistaFuncional))).
%-- c --%
bienAsignada(Persona,Proyecto):-
	persona(Persona),
	proyecto(Proyecto),
	forall(trabaja(Personas,Proyecto),(member(Persona,Personas), rol(Persona,projectLeader))).

programaEnProyecto(Proyecto,Persona):-
	persona(Persona),
	proyecto(Proyecto),
	programa(Persona,Lenguaje),
	forall(proyecto(Proyecto, Lenguajes), member(Lenguaje,Lenguajes)).

%--- Punto 1.3 Validación de Proyectos ---%
bienDefinido(Proyecto):-
	proyecto(Proyecto),
	trabaja(Personas,Proyecto),
	forall(member(Persona,Personas), bienAsignada(Persona,Proyecto)),
	findall(Persona, (member(Persona,Personas), rol(Persona,projectLeader)), ProyectLeaders),
	length(ProyectLeaders,Cantidad),
	Cantidad = 1.

%----------------------------------------------%
%-------------------- TEST --------------------%
%----------------------------------------------%

:- begin_tests(programadores).

% Test Entrega 2 - Punto 2 Proyectos
test(lenguajesDeSumatra, nondet) :-
    proyecto(sumatra,[java,pnet]).%, proyecto(sumatra, net).
        
/*test(lenguajesDeSumatraExplicito, set(Lenguajes == [java, pnet])) :-
	proyecto(sumatra, Lenguajes).
*/
test(lenguajesDePrometeusEsSoloCobol/*, set(Lenguajes == [cobol])*/) :-
    proyecto(prometeus, [cobol]).

test(fernandoTrabajaEnPrometeus,nondet) :-
    trabaja(Personas, prometeus),
	member(fernando,Personas).

test(santiagoTrabajaEnPrometeus) :-
    trabaja(Personas, prometeus),
	member(santiago,Personas).

test(genteDeSumatra/*, set(Personas == [julieta, marcos, andres])*/) :-
    trabaja([julieta, marcos, andres], sumatra).

test(trabajadoresDeSumatraBienAsignados, set(Gente == [julieta, marcos, andres])) :-
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

test(proyectosMalDefinidos, set(Proyectos == [prometeus])) :-
    proyecto(Proyectos), not(bienDefinido(Proyectos)).

:- end_tests(programadores).
