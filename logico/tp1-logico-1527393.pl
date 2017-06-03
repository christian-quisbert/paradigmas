%--- Punto1 ---%

%--- 2.1 - Relevamiento inicial ---%

programa(fernando,cobol).
programa(fernando,visualBasic).
programa(fernando,java).
programa(santiago,ecmaScript).
programa(santiago,java).

rol(fernando,analistaFuncional).
rol(andres,projectLeader).

esProgramador(Alguien):-
	programa(Alguien,_).

