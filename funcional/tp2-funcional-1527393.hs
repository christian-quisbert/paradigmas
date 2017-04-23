module TP where

import Text.Show.Functions
import Data.List

--- PUNTO 2.2 ---
data Cliente = Persona {
	nombre :: String,
	resistencia :: Int,
	amigos :: [Cliente],
	bebidas :: [Bebida]
} deriving(Show)


type Bebida = Cliente -> Cliente
type Accion = Cliente -> Cliente

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
reconocerAmigo :: Cliente -> Cliente -> Cliente 
reconocerAmigo friendToAdd uno
	| (esMismaPersona uno friendToAdd || amigoExistente uno friendToAdd) = uno --error ("Error, es la misma persona o un amigo existente")
	| not (amigoExistente uno friendToAdd) = agregarAmigo friendToAdd uno

esMismaPersona pers1 pers2 = nombre pers1 == nombre pers2
amigoExistente pers1 amigoABuscar = (elem (nombre amigoABuscar).map nombre.amigos) pers1

agregarAmigo friendToAdd (Persona name res amigos bebidas) = Persona name res (friendToAdd : amigos) bebidas

--- PUNTO 5 ---

----- Grog -----
tomaGrog :: Bebida
tomaGrog (Persona name res amigos bebidas) =  Persona name 0 amigos (bebidas ++ [tomaGrog])

------ Jarra loca -----
tomaJarraLoca :: Bebida
tomaJarraLoca (Persona name res friends bebidas) =  (Persona name (res - 10) (map (disminuirResistencia 10) friends) (bebidas ++ [tomaJarraLoca]))

----- Toma Klusener -----
tomaKlusener :: String -> Bebida
tomaKlusener gusto persona = (agregarKlusener gusto.disminuirResistencia (length gusto)) persona

agregarKlusener gusto (Persona name res amigos bebidas) = Persona name res amigos (bebidas ++ [tomaKlusener gusto])

----- Toma Tintico ------
tomaTintico :: Bebida
tomaTintico persona = (agregarTintico.aumentarResistencia ((length.amigos) persona * 5)) persona

agregarTintico (Persona name res amigos bebidas) =  (Persona name res amigos (bebidas ++ [tomaTintico]))

----- Toma Soda -----
tomaSoda :: Int -> Bebida
tomaSoda fuerza (Persona name resistencia amigos bebidas) = Persona (modificoNombre name fuerza) resistencia amigos (bebidas ++ [tomaSoda fuerza])

modificoNombre name cantidadErres = "e" ++ replicate cantidadErres 'r' ++ "p" ++ name

disminuirResistencia cant (Persona name resistencia amigos bebidas) = Persona name (resistencia - cant) amigos bebidas
aumentarResistencia cant (Persona name resistencia amigos bebidas) = Persona name (resistencia + cant) amigos bebidas

--- PUNTO 6 ---
-- seRescata :: Int -> Cliente -> Cliente
seRescata horas persona
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
tomarTragos :: [Bebida] -> Cliente -> Cliente
tomarTragos tragos persona = foldl (\pers trago -> trago pers) persona tragos

tomaTrago trago persona = trago persona

--- Punto 1-d ---
dameOtro persona = (last (bebidas persona)) persona

--- PUNTO 2-a ---
cualesPuedeTomar persona = map (resistenciaMayorACero persona)  -- Aplicacion Parcial (una lista "tragos") --

resistenciaMayorACero persona trago = ((>0).resistencia.tomaTrago trago) persona

--- PUNTO 2-b ---
cuantasPuedeTomar persona = (length.filter (== True).cualesPuedeTomar persona) -- Aplicacion Parcial (una lista "tragos") --

--- PUNTO 3 ---
data Itinerario = Itinerario {
	nombreItinerario :: String,
	duracion :: Float,
	acciones :: [Accion]
} deriving (Show)
--- PUNTO 3-a ---

-- Defino algunos Itinerarios --
mezclaExplosiva = Itinerario {
	nombreItinerario = "mezclaExplosiva",
	duracion = 2.5,
	acciones = [tomaGrog, tomaGrog, tomaKlusener "Huevo", tomaKlusener "Frutilla"]
}
itinerarioBasico = Itinerario {
	nombreItinerario = "itinerarioBasico",
	duracion = 5,
	acciones = [tomaJarraLoca, tomaKlusener "chocolate", seRescata 2, tomaKlusener "huevo"]
}
salidaDeAmigos = Itinerario {
	nombreItinerario = "Salida de amigos",
	duracion = 1,
	acciones = [tomaSoda 1, tomaTintico, reconocerAmigo robertoCarlos, tomaJarraLoca]
}

-- Modelo a Roberto Carlos --
robertoCarlos = Persona {
	nombre = "Roberto Carlos",
	resistencia = 165,
	amigos = [],
	bebidas = []
}

--- PUNTO 3-b ---
realizarItinerario persona itinerario = tomarTragos (acciones itinerario) persona  -- Aplicacion Parcial --

-- rodri y marcos aplican la funcion --
-- *TP> realizarItinerario rodri salidaDeAmigos
-- *TP> realizarItinerario marcos mezclaExplosiva

--- PUNTO 4 ---
intensidadDeItinerario itinerario = (genericLength (acciones itinerario)) / (duracion itinerario)

-- Modelo una lista de itinerarios --
conjuntoItinerarios = [salidaDeAmigos, mezclaExplosiva, itinerarioBasico]

-- Funcion: Me devuelve el itinerario MAS intenso --
itinerarioMasIntenso (itinerario:itinerarios) = foldl (\i1 i2 -> if(intensidadDeItinerario i1 > intensidadDeItinerario i2) then i1 else i2) itinerario itinerarios

--- PUNTO 5 ---
fuerzas_soda = [0..]

chuckNorris = Persona {
	nombre = "Chuck",
	resistencia = 1000,
	amigos = [ana],
	bebidas = []
}
--- PUNTO 5 A ---
-- Funcion para que chuckNorris tome todas las sodas existentes --
-- Al parametro "fuerzas", le paso una lista infinita [0..] 
tomaTodasLasSodas persona fuerzas = foldl (\pers fuerza -> (tomaSoda fuerza pers)) persona fuerzas


--- PUNTO 5 B ---
-- *TP> dameOtro (tomaTodasSodas chuckNorris [0..])

--- PUNTO 5 C ---
-- *TP> resistencia (realizarItinerario (tomaTodasSodas chuckNorris [0..]) itinerarioBasico)

--- PUNTO 6 ---
tomaJarraPopular nivel persona = foldl (\persona amigo ->reconocerAmigo amigo persona) persona (amigos persona)


