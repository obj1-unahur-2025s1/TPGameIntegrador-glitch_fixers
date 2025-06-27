import detective.*

/* Todos los estados tienen los mismos metodos y variables por lo que podrian se instancias de la clase "EstadoDetective" pero al hacerlo no se actualizan las variables visuales en la pantalla (vida, pistas encontradas y restantes)
class EstadoDetective {
  const texto
  const x
  const y
  const property position = game.at(x, y)
  
  method textColor() = "rgb(92, 215, 224)"
  
  method text() = texto
}
*/

object hudPistasEncontradas {
	const property position = game.at(3, 9)
	
	method text() = ("Pistas encontradas : " + detective.pistasEncontradas().toString()) + " "
	
	method textColor() = "rgb(92, 215, 224)"
	
	method colision() {
		//Al estar en la misma position que los fondos del hud el detective al colisionar con el fondo tambien colisiona con este obejeto por eso necesitan conocer el metodo colision.
	}

	method reiniciar() {
	  	detective.reiniciarPistasEncontradas()
		game.removeVisual(self)
	}
}

object hudVidas {
	const property position = game.at(7, 9)
	
	method text() = ("Tienes " + detective.vidas().toString()) + " vidas."
	
	method textColor() = "rgb(92, 215, 224)"
	
	method colision() {
		//Al estar en la misma position que los fondos del hud el detective al colisionar con el fondo tambien colisiona con este obejeto por eso necesitan conocer el metodo colision.
	}

	method reiniciar() {
	    detective.reiniciarVidas()
		game.removeVisual(self)
	}
}

object hudPistasRestantes {
	const property position = game.at(12, 9)
	
	method text() = ("Te falta/n " + detective.pistasRestantes().toString()) + " pista/s por recolectar."
	
	method textColor() = "rgb(92, 215, 224)"
	
	method colision() {
		//Al estar en la misma position que los fondos del hud el detective al colisionar con el fondo tambien colisiona con este obejeto por eso necesitan conocer el metodo colision.
	}

	method reiniciar() {
	  	detective.reiniciarPistasRestantes()
		game.removeVisual(self)
	}
}

class FondoHud {
	var property position
	
	method image() = "fondo_hud.png"
	
	method colision() {
		detective.position(detective.position().down(1))
	}
	
	method iniciar() {
		game.addVisual(self)
	}
}