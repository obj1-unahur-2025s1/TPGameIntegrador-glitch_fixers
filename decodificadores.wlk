import pistas.*
import hud.*

//Decode para fondos
object f {
	method decode(x, y) {
		const fondo = new FondoHud(position = game.at(x, y))
		fondo.iniciar()
	}
} 

//Decode para pistas no peligrosas para nivel 1
object p1 {
	method decode(x, y) {
		const pista = new Pista(
			position = game.at(x, y),
			tipoPista = noPeligrosa,
			imagenes = ["nota.png", "ojo.png", "sangre.png", "huella.png"]
		)
		pista.iniciar()
	}
} 

//Decode para pistas peligrosas para nivel 1
object pp1 {
	method decode(x, y) {
		const pista = new Pista(
			position = game.at(x, y),
			tipoPista = peligrosa,
			imagenes = ["cuchillo.png", "veneno.png"]
		)
		pista.iniciar()
	}
}

//Decode para pistas no peligrosas para nivel 2
object p2 {
	method decode(x, y) {
		const pista = new Pista(
			position = game.at(x, y),
			tipoPista = noPeligrosa,
			imagenes = ["fosforos.png", "nafta.png", "kerosene.png", "huella.png"]
		)
		pista.iniciar()
	}
} 

//Decode para pistas peligrosas para nivel 2
object pp2 {
	method decode(x, y) {
		const pista = new Pista(
			position = game.at(x, y),
			tipoPista = peligrosa,
			imagenes = ["dinamita.png", "molotov.png"]
		)
		pista.iniciar()
	}
}