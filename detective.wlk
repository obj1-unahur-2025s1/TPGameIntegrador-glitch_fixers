import wollok.game.*
import pistas.*
import juegoPrincipal.*

object detective {
  var property position = game.origin()
  var pistasEncontradas = 0
  var aparienciaActual = lupa
  var vidas = 3
  //var pistasRestantes
  var nivelActual = nivel1
  var pistasRestantes = nivelActual.cantPistasNivel()
  
  method image() = aparienciaActual.image()
  method vidas() = vidas
  method reiniciarVidas(){vidas = 3}
  method perderUnaVida(){ vidas = (vidas - 1).max(0)}
  method ponerseGuantes(){aparienciaActual = guantes}
  method quitarseGuantes(){aparienciaActual = lupa}
  method encontrar(unaPista) {aparienciaActual.encontrar(unaPista)}
  //method sumarUnaPista(){ pistasEncontradas += 1}
  method sumarUnaPista() {
    pistasEncontradas += 1
    pistasRestantes = (pistasRestantes - 1).max(0)
  }
  method pistasEncontradas() = pistasEncontradas
  method reiniciarPistasEncontradas() {pistasEncontradas = 0}
  method caerPor(unFondo) {unFondo.restringirEspacio()} //este método, junto al de encontrar(unaPista) generan un error dentro de la terminal, consultando a cada objeto del nivel si es que entiende dicho método, aún no descubro netamente el porque, revisar esto más tarde.
  method pasarDeNivel() { nivelActual = nivel2} //mantiene dicho nivel cada que se le reste un punto al encontrar pistas en el nivel 2.
  method reiniciarPistasRestantes() {pistasRestantes = nivel2.cantPistasNivel()} //no se reiniciaba bien al sólo "pasarDeNivel", pero al igualarlo a la cantidad de pistas del nivel 2, entonces si se reinició correctamente
  //method pistasRestantes(unNivel) = unNivel.cantPistasNivel()
  method pistasRestantes() = pistasRestantes
  method nivelActual() = nivelActual //auxiliar para testeos
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
  //method text() = "Pistas encontradas :" + detective.pistasEncontradas().toString() + ".Tienes "+ detective.vidas().toString() + " vidas. Te faltan: " + detective.pistasRestantes().toString() + " pistas."
  method text() = "Pistas encontradas : " + detective.pistasEncontradas().toString() + " "
  //const property position = game.at(5, 9)
  const property position = game.at(3, 9)
  //method textColor() = "FF0000FF"
  method textColor() ="rgb(92, 215, 224)" //modifico el texto de las pistas para que se note más
  method reiniciar(){
    detective.reiniciarPistasEncontradas()
    //detective.reiniciarVidas()
    //detective.reiniciarPistasRestantes()
  }
}

object estado2 {
  method text() = "Tienes " + detective.vidas().toString() + " vidas."
  const property position = game.at(7, 9)
  method textColor() ="rgb(92, 215, 224)"
  method reiniciar() {
    detective.reiniciarVidas()
  }
}

object estado3 {
  method text() = "Te falta/n " + detective.pistasRestantes().toString() + " pista/s por recolectar."
  const property position = game.at(12, 9)
  method textColor() ="rgb(92, 215, 224)"
  method reiniciar() {
    detective.reiniciarPistasRestantes()
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