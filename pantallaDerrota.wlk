import pistas.*
import detective.*
import juegoPrincipal.*
import pantallaInstrucciones.*
import pantallaInicio.*

object derrotaObject {
  const property position = game.at(0, 0)
  const property image = "derrota.jpg"
  
  method mostrarPantallaDerrota() {
    game.addVisual(self)
  } ////se borra la tecla para volver al inicio porque no anda, no hay solución////
}