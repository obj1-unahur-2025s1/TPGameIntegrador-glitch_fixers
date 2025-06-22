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
    keyboard.z().onPressDo(
      { 
        game.removeVisual(self)
        juego.iniciarJuego()
        game.start()
      }
    ) //prueba de tecla para ir al menu inicial
  }
}