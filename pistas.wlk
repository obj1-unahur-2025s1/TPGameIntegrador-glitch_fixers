import wollok.game.*
import detective.*

class Pista {
	var property position
	var property image = ""
	const tipoPista
	const imagenes
	
	method elegirImagen() {
		image = imagenes.randomized().head()
	}
	
	method desaparecer() {
		game.removeVisual(self)
	}
	
	method colision() {
		tipoPista.reaccionar(self)
	}
	
	method iniciar() {
		self.elegirImagen()
		game.addVisual(self)
	}
}

object peligrosa {
	const aparienciaNecesaria = guantes
	
	method reaccionar(pista) {
		if (detective.aparienciaActual() == aparienciaNecesaria) {
			pista.desaparecer()
			detective.sumarUnaPista()
			game.say(detective, "Pista encontrada!")
		} else {
			detective.perderUnaVida()
			game.say(detective, "Debes colocarte los guantes!")
		}
	}
}

object noPeligrosa {
	const aparienciaNecesaria = lupa
	
	method reaccionar(pista) {
		if (detective.aparienciaActual() == aparienciaNecesaria) {
			pista.desaparecer()
			detective.sumarUnaPista()
			game.say(detective, "Pista encontrada!")
		} else {
			game.say(detective, "Necesitas la lupa!")
		}
	}
}