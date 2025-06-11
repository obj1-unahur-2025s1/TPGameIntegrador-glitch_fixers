import pistas.*
import detective.*
import pantallaInicio.*
import pantallaInstrucciones.*

object juego {
  method iniciarJuego() {
	game.boardGround("fondoSotano.jpeg")
    const pista1 = new PistaOjo(position = game.at(5, 2))
	const pista2 = new PistaSangre( position = game.at(8,0))
	const pista3 = new PistaCuchillo(position = game.at(1, 5))
	const pista4 = new PistaDinamita(position = game.at(5, 4))
	const pista5 = new PistaVeneno(position = game.at(13, 3))
	//game.boardGround("fondoSotano.jpeg")
	game.addVisual(pista1)
	game.addVisual(pista2)
	game.addVisual(pista3)
	game.addVisual(pista4)
	game.addVisual(pista5)
	game.addVisual(estado)
	game.addVisualCharacter(detective)

	game.onCollideDo(detective, {pista => detective.encontrar(pista)})

	game.say(detective, "Debo usar guantes para las pistas peligrosas")

	keyboard.g().onPressDo({detective.ponerseGuantes()})
	keyboard.l().onPressDo({detective.quitarseGuantes()})

	const musicaFondo = game.sound("posible_musica_para_timer.mp3")
	musicaFondo.play()
  }
}