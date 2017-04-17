--Parcialito 1 Resuelto--
import Text.Show.Functions

data Sexo = Femenino | Masculino deriving (Eq,Show)
type Criterio = Persona -> Persona -> Bool

data Persona = Persona {
	nombre :: String,
	edad :: Int,
	sexo :: Sexo,
	personaConQuienSaldria :: Criterio, 
	personaQueLeGusta :: [Persona]
} deriving (Show)

-- ***DEFINO ALGUNAS PERSONAS*** ---
lucas = Persona {
	nombre = "lucas",
	edad = 28,
	sexo = Masculino,
	personaConQuienSaldria = cualquiera,
	personaQueLeGusta = [macarena]
}

macarena = Persona {
	nombre = "macarena",
	edad = 20,
	sexo = Femenino,
	personaConQuienSaldria = esExigente,
	personaQueLeGusta = [lucas]
}

--Saber si una persona se llama Laura
seLlamaLaura = ((=="Laura").nombre) -- "APLICACION PARCIAL"

--Saber si una persona es misógina: no le gusta nadie
esMisogina = (null.personaQueLeGusta) -- "APLICACION PARCIAL"

--Saber si una persona es Mujer
esMujer = ((== Femenino).sexo) -- "APLICACION PARCIAL"

--Saber si una persona saldría con otra
saldriaCon p1 p2 = (personaConQuienSaldria p1) p1 p2

--- 1er Criterio ---
cualquiera :: Criterio
cualquiera _ _ = True

---2do Criterio ---
esExigente :: Criterio
esExigente p1 p2 = sexoDistinto p1 p2 && edadParecida p1 p2

sexoDistinto p1 p2 = sexo p1 /= sexo p2

edadParecida p1 p2 = ((<=5).diferenciaEdad p1) p2 --APLICACION PARCIAL con p2

diferenciaEdad p1 p2 = abs $ edad p1 - edad p2

--- 3er Criterio ---
siLeGusta :: Criterio
siLeGusta p1 p2 = (elem (nombre p2).map nombre.personaQueLeGusta) p1

