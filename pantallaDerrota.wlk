import pistas.*
import detective.*
import juegoPrincipal.*

object derrotaObjet {
  const property position = game.at(0,0)
  const property image = "derrota.jpg"
  method mostrarPantallaDerrota() {
    game.addVisual(self)
  } 
}