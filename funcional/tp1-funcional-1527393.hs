module TP where

import Text.Show.Functions

--- PUNTO 2.2 ---
data Cliente = Persona {
	nombre :: String,
	resistencia :: Int,
	amigos :: [Cliente]
} deriving(Eq,Show)

--- PUNTO 2.3 ---
rodri = Persona {
	nombre = "Rodri",
	resistencia = 55,
	amigos = []
}
marcos = Persona {
	nombre = "Marcos",
	resistencia = 40,
	amigos = [rodri]
}
cristian = Persona {
	nombre = "Cristian",
	resistencia = 2,
	amigos = []
}
ana = Persona {
	nombre = "Ana",
	resistencia = 120,
	amigos = [marcos, rodri]
}

--- PUNTO 2.4 ---
comoEsta persona
	| estaFresco persona = "fresco"
	| (not.estaFresco) persona && tieneMasDeUnAmigo persona = "piola" 
	| otherwise = "duro"

estaFresco = ((>50).resistencia)		-- Aplicacion Parcial --
tieneMasDeUnAmigo = ((>1).length.amigos)	-- Aplicacion parcial --

--- PUNTO 4 ---
reconocerAmigo uno otro
	| (esMismaPersona uno otro || amigoExistente uno otro) = uno
	| not (amigoExistente uno otro) = agregarAmigo uno otro

esMismaPersona pers1 pers2 = nombre pers1 == nombre pers2
amigoExistente pers1 amigoABuscar = (elem (nombre amigoABuscar).map nombre.amigos) pers1

agregarAmigo (Persona name resistencia listaAmigos) amigoAAgregar = Persona name resistencia (amigoAAgregar : listaAmigos)

--- PUNTO 5 ---

----- Grog -----
tomaGrog (Persona name resistencia amigos) =  Persona name 0 amigos
--tomaGrog persona = persona {resistencia = 0} (FORMA SIMPLIFICADA DE MODIFICAR LAS CARACTERISTICAS DE PERSONA)
------ Jarra loca -----
tomaJarraLoca (Persona name resist friends) =  (Persona name (resist - 10) (map (disminuirResistencia 10) friends))

----- Toma Klusener -----
tomaKlusener gusto persona = disminuirResistencia (length gusto) persona

----- Toma Tintico ------
tomaTintico persona = aumentarResistencia ((length.amigos) persona * 5) persona

----- Toma Soda -----
tomaSoda fuerza (Persona name resistencia amigos) = Persona (modificoNombre name fuerza) resistencia amigos

modificoNombre name cantidadErres = "e" ++ replicate cantidadErres 'r' ++ "p" ++ name

disminuirResistencia cant (Persona name resistencia amigos) = Persona name (resistencia - cant) amigos
aumentarResistencia cant (Persona name resistencia amigos) = Persona name (resistencia + cant) amigos

--- PUNTO 6 ---
-- seRescata :: Cliente -> Int -> Cliente
seRescata persona horas
	| horas > 3 = aumentarResistencia 200 persona
	| horas > 0 && horas <= 3 = aumentarResistencia 100 persona


