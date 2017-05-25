progenitor(homero,bart).
progenitor(homero,lisa).
progenitor(homero,maggie).
progenitor(abraham,homero).
progenitor(abraham,jose).
progenitor(jose,pepe).
progenitor(mona,homero).
progenitor(jaquie,marge).
progenitor(marge,bart).
progenitor(marge,lisa).
progenitor(marge,maggie).

abuelo(Abuelo,Nieto):-
	progenitor(Abuelo,Padre),
	progenitor(Padre,Nieto).

hermano(Hermano1,Hermano2):-
	progenitor(Padre,Hermano1),
	progenitor(Padre,Hermano2),
	Hermano1 \= Hermano2.

tio(Tio,Sobrino):-
	hermano(Padre,Tio),
	progenitor(Padre,Sobrino).
tio(Sobrino,Tio):-
	hermano(Tio,Padre),
	progenitor(Padre,Sobrino).

primo(Primo1,Primo2):-
	progenitor(Padre,Primo1),
	progenitor(Tio,Primo1),
	hermano(Padre,Tio).
