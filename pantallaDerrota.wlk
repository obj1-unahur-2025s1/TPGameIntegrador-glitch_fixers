import pistas.*
import detective.*
import juegoPrincipal.*
import pantallaInstrucciones.*
import pantallaInicio.*

object derrotaObjet {
  const property position = game.at(0,0)
  const property image = "derrota.jpg"
  method mostrarPantallaDerrota() {
    game.addVisual(self)
    keyboard.z().onPressDo({game.removeVisual(self)
                            inicio.mostrarInicio()}) //prueba de tecla para ir al menu inicial
  }
}