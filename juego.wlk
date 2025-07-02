import detective.*
import niveles.*

object juego {
	var property nivelActual = nivel1
	const musicaFondo = game.sound("musica_fondo.mp3")
	
	method iniciar() {
		keyboard.g().onPressDo({ detective.ponerseGuantes() })
		keyboard.l().onPressDo({ detective.quitarseGuantes() })
		keyboard.r().onPressDo({ self.reiniciar() })
		game.onCollideDo(detective, { objeto => 
			detective.colisionar(objeto) 
			detective.puedePasarNivel() 
			detective.puedePerder()
		})
		musicaFondo.shouldLoop(true)
		musicaFondo.play()
		keyboard.m().onPressDo(
			{ musicaFondo.volume((musicaFondo.volume() + 0.1).min(1)) }
		)
		keyboard.n().onPressDo(
			{ musicaFondo.volume((musicaFondo.volume() - 0.1).max(0)) }
		)
		nivelActual.iniciar()
	}
	
	method clear() {
		game.allVisuals().forEach({ visual => game.removeVisual(visual) })
	}
	
	method siguienteNivel() {
		self.clear()
		nivelActual.clear()
		nivelActual = nivelActual.siguienteNivel()
		nivelActual.iniciar()
	}
	
	method reiniciar() {
		self.clear()
		nivelActual.clear()
		nivelActual = nivel1
		nivel1.iniciar()
	}
}