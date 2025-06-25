import pistas.*
import detective.*
import juegoPrincipal.*
import pantallaInicio.*

object victoriaObjet {
  const sonidoVictoria = game.sound("level-win-6416.mp3")
  const property position = game.at(0,0)
  const property image = "pantalla_victoria_final.png"

  method mostrarPantallaVictoria() {
    sonidoVictoria.play()
    game.addVisual(self)
  }
}