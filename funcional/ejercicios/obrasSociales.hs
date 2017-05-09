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
esObeso socio = peso socio > 150
edadAvanzada socio = edad socio > 75
muchasEnfermedades socio = length (preexistentes socio) > 8

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
type Prestacion = Solicitud -> Float

--prestacionTotal enfermedad solicitud = 



