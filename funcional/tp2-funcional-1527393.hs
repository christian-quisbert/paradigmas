module TP where

import Text.Show.Functions

--- PUNTO 2.2 ---
data Cliente = Persona {
	nombre :: String,
	resistencia :: Int,
	amigos :: [Cliente],
	bebidas :: [Bebida]
} deriving(Show)


type Bebida = Cliente -> Cliente

--- PUNTO 2.3 ---
rodri = Persona {
	nombre = "Rodri",
	resistencia = 55,
	amigos = [],
	bebidas = [tomaTintico]
}
marcos = Persona {
	nombre = "Marcos",
	resistencia = 40,
	amigos = [rodri],
	bebidas = [tomaKlusener "guinda"]
}
cristian = Persona {
	nombre = "Cristian",
	resistencia = 2,
	amigos = [],
	bebidas = [tomaGrog, tomaJarraLoca]
}
ana = Persona {
	nombre = "Ana",
	resistencia = 120,
	amigos = [marcos, rodri],
	bebidas = []
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
	| (esMismaPersona uno otro || amigoExistente uno otro) = error ("Error, es la misma persona o un amigo existente")
	| not (amigoExistente uno otro) = agregarAmigo uno otro

esMismaPersona pers1 pers2 = nombre pers1 == nombre pers2
amigoExistente pers1 amigoABuscar = (elem (nombre amigoABuscar).map nombre.amigos) pers1

agregarAmigo (Persona name resistencia listaAmigos bebidas) amigoAAgregar = Persona name resistencia (amigoAAgregar : listaAmigos) bebidas

--- PUNTO 5 ---

----- Grog -----
tomaGrog (Persona name resistencia amigos bebidas) =  Persona name 0 amigos (bebidas ++ [tomaGrog])

------ Jarra loca -----
tomaJarraLoca (Persona name resist friends bebidas) =  (Persona name (resist - 10) (map (disminuirResistencia 10) friends) (bebidas ++ [tomaJarraLoca]))

----- Toma Klusener -----
tomaKlusener gusto persona = (agregarKlusener gusto.disminuirResistencia (length gusto)) persona

agregarKlusener gusto (Persona name res amigos bebidas) = Persona name res amigos (bebidas ++ [tomaKlusener gusto])

----- Toma Tintico ------
tomaTintico persona = (agregarTintico.aumentarResistencia ((length.amigos) persona * 5)) persona

agregarTintico (Persona name res amigos bebidas) =  (Persona name res amigos (bebidas ++ [tomaTintico]))

----- Toma Soda -----
tomaSoda fuerza (Persona name resistencia amigos bebidas) = Persona (modificoNombre name fuerza) resistencia amigos (bebidas ++ [tomaSoda fuerza])

modificoNombre name cantidadErres = "e" ++ replicate cantidadErres 'r' ++ "p" ++ name

disminuirResistencia cant (Persona name resistencia amigos bebidas) = Persona name (resistencia - cant) amigos bebidas
aumentarResistencia cant (Persona name resistencia amigos bebidas) = Persona name (resistencia + cant) amigos bebidas

--- PUNTO 6 ---
-- seRescata :: Cliente -> Int -> Cliente
seRescata persona horas
	| horas > 3 = aumentarResistencia 200 persona
	| horas > 0 && horas <= 3 = aumentarResistencia 100 persona

----------------------------------------------------------
--- EMPIEZA LA SEGUNDA ENTREGA DE DEL TRABAJO PRACTICO ---
----------------------------------------------------------

---  PUNTO 1-a ---
-- Se realizaron las modificaciones en la abstracion "Cliente", agregando parámetro "bebidas" --
-- Se modificaron se agegaron las bebidas tomadas por cada cliente en su nuevo parametro "bebidas" --

--- Punto 1-b ---
-- C/u de las funciones donde toma una bebida, se modifico para agregar la bebida.

--- Punto 1-c ---
tomarTragos :: Cliente -> [Bebida] -> Cliente
tomarTragos persona tragos = foldl tomaTrago persona tragos

tomaTrago persona trago = trago persona

--- Punto 1-d ---
dameOtro persona = (last (bebidas persona)) persona

--- PUNTO 2-a ---
cualesPuedeTomar persona = map (resistenciaMayorACero persona) -- Aplicacion Parcial (una lista "tragos") --

resistenciaMayorACero persona trago = (resistencia.tomaTrago persona) trago > 0

--- PUNTO 2-b ---
cuantasPuedeTomar persona = (length.filter (== True).cualesPuedeTomar persona) -- Aplicacion Parcial (una lista "tragos") --

--- PUNTO 3 ---

