import pantallaInicio.*
import pistas.*
import detective.*
import juegoPrincipal.*

object instrucciones {
  const property position = game.at(0,0)
  const property image = "inicio.jpg"
  var estaActivada = false //variable bandera para que no se ejecute el metodo al apretar enter mientras corre el juego
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