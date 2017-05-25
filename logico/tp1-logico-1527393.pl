%--- Punto1 ---%

%--- Relevamiento inicial ---%

programa(fernando,cobol).
programa(fernando,visualBasic).
programa(fernando,java).
programa(santiago,ecmasScript).
programa(santiago,java).

rol(fernando,analistaFuncional).
rol(andres,projectLeader).

esProgramador(Alguien):-
	programa(Alguien,_).

%--- Punto2 ---%
%-- 1 - Que lenguaje sabe programar Fernando --%
lenguajeQueSabe(Alguien,Lenguaje):-
	programa(Alguien,Lenguaje).

%--- 2 
