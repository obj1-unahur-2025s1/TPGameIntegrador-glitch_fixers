import detective.*
import niveles.*

object juego {
	method iniciar() {
		keyboard.g().onPressDo({ detective.ponerseGuantes() })
		keyboard.l().onPressDo({ detective.quitarseGuantes() })
		game.onCollideDo(detective, { objeto => detective.colisionar(objeto) })
		nivel1.iniciar()
	}
}