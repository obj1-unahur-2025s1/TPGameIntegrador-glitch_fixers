import pantallaInicio.*
import pistas.*
import detective.*
import juegoPrincipal.*

object instrucciones {
  const property position = game.at(0,0)
  const property image = "insPrueba.png"
  var estaActivada = false //variable bandera para que no se ejecute el metodo al apretar enter mientras corre el juego
    method mostrarInstrucciones() {
      if (!estaActivada) {
        game.addVisual(self)
        estaActivada = true
        keyboard.space().onPressDo({
        self.cerrarInstrucciones()
        
     })
    }
  }

  method cerrarInstrucciones() {
    game.removeVisual(self)
    juego.iniciarJuego()
  }
}