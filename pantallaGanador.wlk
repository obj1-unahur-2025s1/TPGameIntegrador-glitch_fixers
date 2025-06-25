import pistas.*
import detective.*
import juegoPrincipal.*
import pantallaInicio.*

object victoriaObjet {
  const property position = game.at(0,0)
  const property image = "pantalla_victoria_final.png"

  method mostrarPantallaVictoria() {
    game.addVisual(self)
  }
}