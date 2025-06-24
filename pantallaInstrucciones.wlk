import pantallaInicio.*
import pistas.*
import detective.*
import juegoPrincipal.*

object instrucciones {
  const property position = game.at(0,0)
  const property image = "instruccionesMejorado.png"

  var estaActivada = false //variable bandera para que no se ejecute el metodo al apretar espacio mientras corre el juego
  var juegoIniciado = false //solucionado el bug de la tecla espacio

  method mostrarInstrucciones() {
    if (!estaActivada) {
      game.addVisual(self)
      estaActivada = true
      keyboard.space().onPressDo({self.cerrarInstrucciones()})
    }
  }

  method cerrarInstrucciones() {
    estaActivada = false //agregado de valor false al cerrar instrucciones
    game.removeVisual(self)
    if(not juegoIniciado) { //solucionado el bug de la tecla espacio
      juegoIniciado = true
      juego.iniciarJuego()
    }
  }
}