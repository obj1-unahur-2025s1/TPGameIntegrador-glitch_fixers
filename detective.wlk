import wollok.game.*
import pistas.*

object detective {
  var property position = game.origin()
  var pistasEncontradas = 0
  var aparienciaActual = lupa
  var vidas = 3

  method image() = aparienciaActual.image()
  method vidas() = vidas
  method perderUnaVida(){ vidas = (vidas - 1).max(0)}
  method ponerseGuantes(){aparienciaActual = guantes}
  method quitarseGuantes(){aparienciaActual = lupa}
  method encontrar(unaPista) {aparienciaActual.encontrar(unaPista)}
  method sumarUnaPista(){ pistasEncontradas += 1}
  method pistasEncontradas() = pistasEncontradas

  /*method perder(){
    return game.say(self, "Oh no! ")
    game.removeVisual(self)
    game.boardGround("fondoPerdiste.png")
    game.stop()
  }
  method ganar(){
    return game.say(self, "He encontrado todas las pistas")
    game.removeVisual(self)
    game.boardGround("fondoGanaste.png")
    game.stop()
  }*/

}

//Apariencias

object lupa {
  method image()= "lupa_1.png"

  method encontrar(unaPista) {
    if(unaPista.esPistaPeligrosa()){
      detective.perderUnaVida()
      return game.say(detective, "¡Debo colocarme los guantes!")
    }else{
      unaPista.desaparecer()
      detective.sumarUnaPista()
      return game.say(detective, "He encontrado una pista")
      }
  }
}

object guantes {
  method image() = "guantes.png"
   method encontrar(unaPista) {
    if( not unaPista.esPistaPeligrosa()){
      return game.say(detective, "¡Necesito mi lupa!")
    }else{
      unaPista.desaparecer()
      detective.sumarUnaPista()
      return game.say(detective, "He encontrado una pista")
      }
  }
}

object estado {
  method text() = "Pistas encontradas :" + detective.pistasEncontradas().toString() + ".       Tienes "+ detective.vidas().toString() + " vidas."
  const property position = game.at(5, 9)
  method textColor() = "000000"
}