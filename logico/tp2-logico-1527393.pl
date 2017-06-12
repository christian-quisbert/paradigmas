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
			
%--- Tp2 - lógico ---%
%-- Punto 1.2 Proyectos --%
persona(Persona):-
    programa(Persona,_),
persona(Persona):-
    rol(Persona,_).

% proyecto(Nombre,[Lenguaje],[Persona]) %
proyecto("Sumatra",[java,pnet],[julieta,marcos,andres]).
proyecto("Prometeus",[cobol],[fernando,santiago]).

proyecto(Proyecto):-
    proyecto(Proyecto,_,_).
    
%-- Punto 1.2.2 Proyectos --%
trabajaEnProyecto(Persona,Proyecto):-
    persona(Persona),
    proyecto(Proyecto),
    forall(proyecto(Proyecto,_,Personas), member(Persona,Personas),
    /*forall(proyecto(Proyecto,Lenguajes,_), programa(Persona,Lenguaje), member(Lenguaje,Lenguajes).*/
