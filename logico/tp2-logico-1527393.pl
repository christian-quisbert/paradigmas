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
	forall(member(Persona,Personas), bienAsignada(Persona,Proyecto)).
	/*Y si ademas hay 1 solo projectLeader (Usar not)*/
	
	
