import pantallaInicio.*
import pistas.*
import detective.*
import juegoPrincipal.*

object instrucciones {
  const property position = game.at(0,0)
  const property image = "ins.jpg"
  var estaActivada = false
    method mostrarInstrucciones() {
      if (!estaActivada) {
        game.addVisual(self)
        estaActivada = true
        keyboard.space().onPressDo({
        self.cerrarInstrucciones()
        juego.iniciarJuego()
     })
    }
  }

  method cerrarInstrucciones() {
    game.removeVisual(self)
  }
}