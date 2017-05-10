import Text.Show.Functions

-- Parte A --

--- Punto 1 ---
type Enfermedad = String

data Socio = Socio {
	sexo :: String,
	peso :: Float,
	edad :: Int,
	preexistentes :: [Enfermedad]
} deriving(Eq, Show)

data Tratamiento = Tratamiento {
	costoBase :: Float,
	numSesiones :: Int,
	enfermedad :: String
} deriving(Eq, Show)

-- Modelo personas --
jose = Socio {
	sexo = "Hombre",
	peso = 78.9,
	edad = 22,
	preexistentes = ["zamorreaDistopica"]
}
analia = Socio {
	sexo = "Mujer",
	peso = 70,
	edad = 34,
	preexistentes = []
}

-- Modelo tratamientos --
x1 = Tratamiento {
	costoBase = 5000,
	numSesiones = 30,
	enfermedad = "zamorreaDistopica"
}
xfg23 = Tratamiento {
	costoBase = 10000,
	numSesiones = 2,
	enfermedad = "zamorreaDistopica"
}

--- PUNTO 2 ---
diagnosticarPreexistencia socio enfermedad = socio {preexistentes = enfermedad : preexistentes socio}

--- PUNTO 3 ---
estaEnRiesgo socio = esObeso socio && edadAvanzada socio && muchasEnfermedades socio
esObeso = (>150) . peso
edadAvanzada = (>75) . edad
muchasEnfermedades = (>8) . length . preexistentes

-- PARTE B --

--- PUNTO 4 ---

data Solicitud = Solicitud {
	socio :: Socio,
	tratamiento :: Tratamiento 
}

solicitud897 = Solicitud {
	socio = jose,
	tratamiento = x1
}

--- PUNTO 5 ---
--- Punto 5a ---
type Prestacion = Solicitud -> Float

prestacionTotal enfermedad solicitud
	| enfermedad == enfermedadSolicitud solicitud = costoTotal solicitud
	| otherwise = 0

enfermedadSolicitud :: Solicitud -> Enfermedad
enfermedadSolicitud = enfermedad . tratamiento

costoTotal :: Solicitud -> Float
costoTotal = costoBase . tratamiento

--- Punto 5b ---
prestacionSinPreexistencias solicitud
	| cantPreexistencias solicitud == 0 = costoTotal solicitud / 2
	| otherwise = 0

cantPreexistencias = length . preexistentes . socio

--- Punto 5c ---
prestacionHastaMaximo pesos solicitud = min pesos (costoTotal solicitud)

--- Punto 5d ---
nada _ = 0

--- PUNTO 6 ---
--- Punto 6a ---
sumaPrestaciones :: Prestacion -> Prestacion -> Prestacion
sumaPrestaciones p1 p2 solicitud = max (p1 solicitud) (p2 solicitud)

--- Punto 6b ---
plan prestaciones = foldr sumaPrestaciones nada prestaciones

-- PARTE C --

-- PARTE D --
-- tipo de la funcion:
f a y z h
	| (y . filter a) h = length h
	| otherwise = z a

-- f :: (a -> Bool) -> ([a] -> Bool) -> ((a -> Bool) -> Int) -> [a] -> Int
