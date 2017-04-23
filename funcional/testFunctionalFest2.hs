import Test.Hspec
import Test.QuickCheck
import Data.List
import Control.Exception (evaluate)
import TP

-- Cosas que le pediremos a los alumnos
-- 1) Que el archivo hs tenga una definicion de modulo
-- module TP where

-- 2) Que instalen Windows Haskell Platform y desde la consola del sistema operativo hagan
-- cabal update && cabal install hspec 
-- eso nos asegura que tengan las dependencias bajadas

-- 3) Que nombren a los clientes rodri, marcos, ana, cristian (para no volvernos locos)

-- 4) De aca en mas cada docente deberia renombrar las funciones como las haya escrito cada alumno
-- y obviamente hacer ajustes en base a lo que hayan definido

-- Funciones que aplican sobre cliente
nombreRodri = "Rodri"
nombreMarcos = "Marcos"
nombreAna = "Ana"
nombreCristian = "Cristian"
nombreRobertoCarlos = "Roberto Carlos"
descripcionSalidaAmigos = "Salida de amigos"

--"bebibas"--
grogXD = tomaGrog
tintico = tomaTintico
klusener = tomaKlusener
jarraLoca = tomaJarraLoca
soda = tomaSoda

rescatarse = seRescata
tomarBebida = tomaTrago 


losAmigotes = amigos

-- Funciones auxiliares de Test
buscarAmigo nombreAmigo = head . filter ((== nombreAmigo) . nombre) . amigos

-- Punto 3
estadoCliente = comoEsta
-- Punto 4
--seHaceAmigoteDe = hacerseAmigoDe
--seAmigaCon = flip seHaceAmigoteDe
seHaceAmigoteDe = flip reconocerAmigo
seAmigaCon = seHaceAmigoteDe

-- Entrega 2

-- 1c
tomarse = tomarTragos
-- 1d
pidoOtro = dameOtro
-- 3b
cumplirItinerario = realizarItinerario
-- itinerarios
salidaAmigos = salidaDeAmigos
laMezclaExplosiva = mezclaExplosiva
itinerarioEstandar = itinerarioBasico
-- 4
laIntensidad = intensidadDeItinerario
nombreDeUnItinerario = nombreItinerario

-- Tests
runTests = hspec $ do
   describe "Test Punto 3 - Como esta" $ do
      it "Cristian esta duro" $ do
         (estadoCliente cristian) `shouldBe` "duro"

      it "Rodri esta fresco" $ do
         (estadoCliente rodri) `shouldBe` "fresco"

      it "Marcos esta duro" $ do
         (estadoCliente marcos) `shouldBe` "duro"

      it "Marcos se hace amigo de Ana, esta piola" $ do
         ((estadoCliente . seAmigaCon ana . seAmigaCon rodri) marcos) `shouldBe` "piola"

   describe "Test Punto 4 - Hacerse amigo de" $ do
      it "Rodri no puede hacerse amigo de Rodri" $ do
         --evaluate (rodri `seHaceAmigoteDe` rodri) `shouldThrow` anyException
         (rodri `seHaceAmigoteDe` rodri) `shouldSatisfy` (null . losAmigotes)

      it "Rodri ya es amigo de Marcos asi que no tiene efecto hacerse nuevamente amigo" $ do
         (marcos `seHaceAmigoteDe` marcos) `shouldSatisfy` ((== 1) . length . losAmigotes)

      it "Rodri reconoce a Marcos como amigo, ahora tiene un amigo" $ do
         (marcos `seHaceAmigoteDe` marcos) `shouldSatisfy` ((== 1) . length . losAmigotes)

   describe "Test Punto 5 - Tomar bebidas" $ do
      it "Ana toma GrogXD y queda sin resistencia" $ do
         ((resistencia . grogXD) ana) `shouldBe` 0
 
      it "Ana toma Jarra Loca y queda con 110 resistencia" $ do
         ((resistencia . jarraLoca) ana) `shouldBe` 110

      it "Ana toma Jarra Loca y Rodri queda con 45 resistencia" $ do
         ((resistencia . buscarAmigo nombreRodri . jarraLoca) ana) `shouldBe` 45

      it "Ana toma Jarra Loca y Marcos queda con 30 resistencia" $ do
         ((resistencia . buscarAmigo nombreMarcos . jarraLoca) ana) `shouldBe` 30

      it "Ana toma un Klusener de Huevo y queda con 115 resistencia" $ do
         ((resistencia . klusener "huevo") ana) `shouldBe` 115

      it "Ana toma un Klusener de Chocolate y queda con 111 resistencia" $ do
         ((resistencia . klusener "chocolate") ana) `shouldBe` 111

      it "Cristian toma un Tintico y queda con 2 de resistencia por no tener amigos" $ do
         ((resistencia . tintico) cristian) `shouldBe` 2

      it "Ana toma un Tintico y queda con 130 de resistencia porque tiene 2 amigos" $ do
         ((resistencia . tintico) ana) `shouldBe` 130

      it "Rodri toma una soda de fuerza 2, queda con nombre errpRodri" $ do
         ((nombre . soda 2) rodri) `shouldBe` "errp" ++ nombreRodri

      it "Ana toma una soda de fuerza 10, queda con nombre errrrrrrrrrpAna" $ do
         ((nombre . soda 10) ana) `shouldBe` "errrrrrrrrrp" ++ nombreAna

      it "Ana toma una soda de fuerza 0, queda con nombre epAna" $ do
         ((nombre . soda 0) ana) `shouldBe` "ep" ++ nombreAna

   describe "Test Punto 6 - Rescatarse" $ do
      it "Rodri se rescata 5 horas, queda con 255 de resistencia" $ do
         ((resistencia . rescatarse 5) rodri) `shouldBe` 255

      it "Rodri se rescata 1 hora, queda con 155 de resistencia" $ do
         ((resistencia . rescatarse 1) rodri) `shouldBe` 155

   {-
      ***************
      Tests entrega 2
      ***************
   -}

   --Test punto 1
   describe "II- Tests punto 1" $ do
      -- b
      it "Marcos toma una soda de nivel 3 y queda con 2 bebidas" $ do
         (length . bebidas . tomarse (soda 3)) marcos `shouldBe` 2

      it "Marcos toma una soda de nivel 3 y queda con 40 de resistencia" $ do
         (resistencia . tomarse (soda 3)) marcos `shouldBe` 40

      -- c
      it "Rodri toma una soda de nivel 1 y una soda de nivel 2 y queda con nombre errperpRodri" $ do
         (nombre . tomarse (soda 2) . tomarBebida (soda 1)) rodri `shouldBe` "errperp" ++ nombreRodri

      it "Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 30 de resistencia" $ do
         (resistencia . tomarse jarraLoca . tomarBebida tintico . tomarBebida (klusener "huevo")) marcos `shouldBe` 30

      it "Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 4 bebidas en el historial" $ do
         (resistencia . tomarse jarraLoca . tomarBebida tintico . tomarBebida (klusener "huevo")) marcos `shouldBe` 30

      -- d
      it "Ana pide 'dame otro' y debe dar error" $ do
         evaluate (pidoOtro ana) `shouldThrow` anyException

      it "Marcos pide 'dame otro' y tiene 2 bebidas en el historial" $ do
         (length . bebidas . pidoOtro) marcos `shouldBe` 2

      it "Marcos pide 'dame otro' y lo deja con 34 de resistencia" $ do
         (resistencia . pidoOtro) marcos `shouldBe` 34

      it "Rodri toma una soda de nivel 1, y 'dameOtro' da como resultado que tiene 3 bebidas" $ do
         (length . bebidas . pidoOtro . tomarse (soda 1)) rodri `shouldBe` 3

      it "Rodri toma una soda de nivel 1, y 'dameOtro' da como resultado que su nombre queda 'erperpRodri'" $ do   
         (nombre . pidoOtro . tomarse (soda 1)) rodri `shouldBe` "erperp" ++ nombreRodri

   --Test punto 2b
   describe "II- Tests punto 2" $ do

      it "Rodri puede tomar dos bebidas, entre un grog XD, un tintico y un klusener de frutilla" $ do
         cuantasPuedeTomar rodri [grogXD, tintico, klusener "frutilla"] `shouldBe` 2

      it "pero si el klustener tiene nombre largo, solo puede tomar 1 " $ do
         cuantasPuedeTomar rodri [grogXD, tintico, klusener "fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla"] `shouldBe` 1

   --Test punto 3b
   describe "II- Tests punto 3" $ do
      it "Rodri hace una salida de amigos y debe quedar con un amigo" $ do
         (length . amigos . cumplirItinerario rodri) salidaAmigos `shouldBe` 1

      it "Rodri hace una salida de amigos y se debe llamar 'erpRodri'" $ do
         (nombre . cumplirItinerario rodri) salidaAmigos `shouldBe` "erp" ++ nombreRodri

      it "Rodri hace una salida de amigos y debe quedar con 45 de resistencia" $ do
         (resistencia . cumplirItinerario rodri) salidaAmigos `shouldBe` 45

      it "Rodri hace una salida de amigos y su primer y único amigo Roberto Carlos debe quedar con 155 de resistencia" $ do
         (resistencia . head . amigos . cumplirItinerario rodri) salidaAmigos `shouldBe` 155

      it "Rodri hace una salida de amigos y debe quedar con 5 bebidas en su historial" $ do
         (length . bebidas . cumplirItinerario rodri) salidaAmigos `shouldBe` 5

   --Test punto 4
   describe "II- Tests punto 4" $ do
      -- 4a
      it "la intensidad de la mezcla explosiva es 2.0" $ do
         laIntensidad laMezclaExplosiva `shouldBe` 2.0

      it "la intensidad de la salidaDeAmigos es 4.0" $ do
         laIntensidad salidaAmigos `shouldBe` 4.0

      it "la intensidad del itinerario basico es 0.8" $ do
         laIntensidad itinerarioEstandar `shouldBe` 0.8 

      -- 4b
      it "Entre la salida de amigos, la mezcla explosiva y el itinerario básico, el itinerario más intenso es la salida de amigos (tip: se puede reconocer por el nombre)" $ do
         (nombreDeUnItinerario . itinerarioMasIntenso) [salidaAmigos, laMezclaExplosiva, itinerarioEstandar] `shouldBe` descripcionSalidaAmigos

      it "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con el nombre 'erpRodri'" $ do
         (nombre . cumplirItinerario rodri . itinerarioMasIntenso) [salidaAmigos, laMezclaExplosiva, itinerarioEstandar] `shouldBe` "erp" ++ nombreRodri

      it "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con resistencia 45" $ do
         (resistencia . cumplirItinerario rodri . itinerarioMasIntenso) [salidaAmigos, laMezclaExplosiva, itinerarioEstandar] `shouldBe` 45

      it "Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con un amigo Roberto Carlos" $ do
         (nombre . head . amigos . cumplirItinerario rodri . itinerarioMasIntenso) [salidaAmigos, laMezclaExplosiva, itinerarioEstandar] `shouldBe` nombreRobertoCarlos

   --Test punto 6 Jarra Popular
   describe "II- Tests punto 6 Jarra Popular" $ do
      it "Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 0, sigue quedando con una sola amiga (Ana)" $ do
         (nombre . head . amigos . tomarse (jarraPopular 0) . seAmigaCon ana) robertoCarlos `shouldBe` nombreAna

      it "Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 3, queda con 3 amigos (Ana, Marcos y Rodri)" $ do
         (sort . map nombre . amigos . tomarse (jarraPopular 3) . seAmigaCon ana) robertoCarlos `shouldBe` [nombreAna, nombreMarcos, nombreRodri]

      it "Cristian se hace amigo de Ana. Roberto Carlos se hace amigo de Cristian, toma una jarra popular de espirituosidad 4, queda con 4 amigos (Cristian, Ana, Marcos y Rodri)" $ do
         (sort . map nombre . amigos . tomarse (jarraPopular 4) . seHaceAmigoteDe robertoCarlos . seAmigaCon ana) cristian `shouldBe` [nombreAna, nombreCristian, nombreMarcos, nombreRodri]
