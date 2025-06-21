import wollok.game.*
import pistas.*
import juegoPrincipal.*

object detective {
  var property position = game.origin()
  var pistasEncontradas = 0
  var aparienciaActual = lupa
  var vidas = 3

  method image() = aparienciaActual.image()
  method vidas() = vidas
  method reiniciarVidas(){vidas = 3}
  method perderUnaVida(){ vidas = (vidas - 1).max(0)}
  method ponerseGuantes(){aparienciaActual = guantes}
  method quitarseGuantes(){aparienciaActual = lupa}
  method encontrar(unaPista) {aparienciaActual.encontrar(unaPista)}
  method sumarUnaPista(){ pistasEncontradas += 1}
  method pistasEncontradas() = pistasEncontradas
  method reiniciarPistasEncontradas() {pistasEncontradas = 0}
  method caerPor(unFondo) {unFondo.restringirEspacio()} //este método, junto al de encontrar(unaPista) generan un error dentro de la terminal, consultando a cada objeto del nivel si es que entiende dicho método, aún no descubro netamente el porque, revisar esto más tarde.
}

//Apariencias

object lupa {
  method image()= "lupa_1.png"

  var mensajeAMostrar = null
  method encontrar(unaPista) {
    if(unaPista.esPistaPeligrosa()){
      detective.perderUnaVida()
      mensajeAMostrar = new Mensaje(texto = "¡Debo colocarme los guantes!")
    }else{
      unaPista.desaparecer()
      detective.sumarUnaPista()
      mensajeAMostrar = new Mensaje(texto = "He encontrado una pista")
      }
    return game.say(detective, mensajeAMostrar.text())
  }
}

class Mensaje {
  const texto
  method text() = texto
}


object guantes {
  method image() = "guante1.png"
  var mensajeAMostrar = null
   method encontrar(unaPista) {
    if( not unaPista.esPistaPeligrosa()){
      mensajeAMostrar = new Mensaje(texto = "¡Necesito mi lupa!")
    }else{
      unaPista.desaparecer()
      detective.sumarUnaPista()
      mensajeAMostrar = new Mensaje(texto = "He encontrado una pista")
      }
    return game.say(detective, mensajeAMostrar.text())
  }
}



object estado {
  method text() = "Pistas encontradas :" + detective.pistasEncontradas().toString() + ".Tienes "+ detective.vidas().toString() + " vidas."
  const property position = game.at(5, 9)
  //method textColor() = "FF0000FF"
  method textColor() ="rgb(92, 215, 224)" //modifico el texto de las pistas para que se note más
  method reiniciar(){
    detective.reiniciarPistasEncontradas()
    detective.reiniciarVidas()
    }
}

/*
object fondo_estado {
  const property position = game.at(5, 9)
  method image() = "posible_fondo_2.png"
}

*/

class FondoEstado { //clase generadora de fondos para el hud.
  var property position
  method image() = "posible_fondo_2.png"
  method restringirEspacio() {
    game.schedule(0.01, {detective.position(detective.position().down(1))})
  }
}