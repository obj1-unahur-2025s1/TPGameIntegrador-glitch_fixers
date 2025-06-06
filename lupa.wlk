import wollok.game.*
import pistas.*

object lupa {
  var property position = game.origin()
  var pistasEncontradas = 0
  var estaConGuantes = false
  var aparienciaActual = "lupa_1.png"

  method image() = aparienciaActual

  method ponerseGuantes(){
    aparienciaActual = "guantes.png"
    estaConGuantes = true
  }
  method quitarseGuantes(){
    aparienciaActual = "lupa_1.png"
    estaConGuantes = false
  }
  method estaConGuantes() = estaConGuantes

  method encontrar(unaPista) {
    if(unaPista.esPistaPeligrosa() &&  not self.estaConGuantes()){
      self.perder()
    }
    unaPista.desaparecer()
    pistasEncontradas += 1
    if(pistasEncontradas == 5){
      self.ganar()
    }
  }
  method pistasEncontradas() = pistasEncontradas

  method perder(){
    return game.say(self, "Oh no! ")
    
    /*esta parte no se donde agregarla para que corra
    game.removeVisual(self)
    game.boardGround("fondoPerdiste.png")
    game.stop()*/
  }
  
  method ganar(){
    return game.say(self, "He encontrado todas las pistas")
    /*esta parte no se donde agregarla para que corra
    game.removeVisual(self)
    game.boardGround("fondoGanaste.png")
    game.stop()*/
  }



}

object estado {
  method text() = "Pistas encontradas :" + lupa.pistasEncontradas().toString() + ".       Para usar guantes presiona la g"
  const property position = game.at(5, 9)
  method textColor() = "FF0000FF"
}