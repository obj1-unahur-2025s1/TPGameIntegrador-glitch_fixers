import pistas.*
import detective.*
import pantallaInstrucciones.*

object inicio {
  const property position = game.at(3,2)
  const property image = "ins.jpg"


  
  var estaActivada = false //variable bandera para que no se ejecute el metodo al apretar enter mientras corre el juego
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