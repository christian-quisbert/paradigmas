% --Base de conocimiento-- %
contador(pepe).
contador(eduardo).

honesto(lautaro).
honesto(lucia).

ambicioso(lucas).
ambicioso(federico).

trabajoEn(pepe,lavanderia).
trabajoEn(eduardo,canal13).
trabajoEn(lautaro,programacion).
trabajoEn(federico,teatro).

puedeAndar(contaduria,Empleado):-
	contador(Empleado),
	honesto(Empleado).
puedeAndar(ventas,Empleado):-
	ambicioso(Empleado),
	tieneExperiencia(Empleado).
puedeAndar(ventas,lucia).

tieneExperiencia(Empleado):-
	trabajoEn(Persona,_).

%------------------%
joven(pepe).
joven(federico).
ingeniero(lautaro).
abogado(lucas).
abogado(eduardo).

puedeAndar(proyectos,Empleado):-
	ingeniero(Empleado),
	tieneExperiencia(Empleado).
puedeAndar(proyectos,Empleado):-
	abogado(Empleado),
	joven(Empleado).
puedeAndar(logistica,Empleado):-
	profesional(Empleado),
	jovenOExperimentado(Empleado),
	Empleado \= fulgencia.
puedeAndar(proyectos,fulgencia).

jovenOExperimentado(Empleado):-
	joven(Empleado),
	tieneExperiencia(Empleado).

