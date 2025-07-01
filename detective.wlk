import wollok.game.*
import pistas.*
import juego.*
import niveles.*

object detective {
	var property position = game.origin()
	var property vidas = 3
	var property pistasEncontradas = 0
	//var property pistasRestantes = nivelActual.cantPistas()
	var pistasRestantes = nivelActual.cantPistas()
	var property aparienciaActual = lupa
	var property nivelActual = nivel1
	
	method pistasRestantes() = pistasRestantes

	method image() = aparienciaActual.image()
	
	method ponerseGuantes() {
		aparienciaActual = guantes
	}
	
	method quitarseGuantes() {
		aparienciaActual = lupa
	}
	
	method perderUnaVida() {
		vidas = (vidas - 1).max(0)
	}
	
	method sumarUnaPista() {
		pistasEncontradas += 1
		pistasRestantes = (pistasRestantes - 1).max(0)
	}
	
	method colisionar(objeto) {
		objeto.colision()
	}
	
	method pasarDeNivel() {
		nivelActual = nivel2
	}
	
	method reiniciarPistasEncontradas() {
		pistasEncontradas = 0
	}
	
	method reiniciarVidas() {
		vidas = 3
	}
	
	method reiniciarPistasRestantes() {
		pistasRestantes = nivelActual.cantPistas()
	}
	
	method iniciarMovimientos() {
		keyboard.up().onPressDo({ self.position(self.position().up(1)) })
		keyboard.down().onPressDo({ self.position(self.position().down(1)) })
		keyboard.left().onPressDo({ self.position(self.position().left(1)) })
		keyboard.right().onPressDo({ self.position(self.position().right(1)) })
	}

	method reiniciarMovimientos() {
		keyboard.up().onPressDo({ self.position(self.position().up(-1)) })
		keyboard.down().onPressDo({ self.position(self.position().down(-1)) })
		keyboard.left().onPressDo({ self.position(self.position().left(-1)) })
		keyboard.right().onPressDo({ self.position(self.position().right(-1)) })
	}
}

object lupa {
	method image() = "lupa.png"
}

object guantes {
	method image() = "guante.png"
}