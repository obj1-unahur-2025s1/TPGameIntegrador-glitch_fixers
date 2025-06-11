import pistas.*
import detective.*
import pantallaInstrucciones.*

object inicio {
  const property position = game.at(0,0)
  const property image = "ins.jpg"
  var estaActivada = false //variable bandera para evitar que se active la pantalla aun con el juego iniciado
    method mostrarInicio() {
      if(!estaActivada) {
        game.addVisual(self)
        estaActivada = true
        keyboard.enter().onPressDo({
        self.cerrarInicio()
      })
    }
  }


  method cerrarInicio() {
    game.removeVisual(self)
    instrucciones.mostrarInstrucciones()
  } 
}