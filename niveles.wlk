import detective.*
import pistas.*
import hud.*
import decodificadores.*
import pantallas.*
import juego.*

object randomnum {
	method obtener(num) = 1.randomUpTo(num).truncate(0)
	
	method obtenerPar(num) {
		const cantidadDePares = (num / 2).truncate(0) + 1
		const parRandom = 1.randomUpTo(cantidadDePares).truncate(0)
		return parRandom * 2
	}
}

class Nivel {
	var property position = game.at(0, 0)
	var property image = ""
	const img
	const pistas
	const fondos = [f, f, f, f, f, f, f, f, f, f, f, f, f, f, f]
	const property siguienteNivel
	
	method dibujarFondoHud() {
		var x = 0
		fondos.forEach({ fondo =>	fondo.decode(x, 9)x += 1})
	}
	
	method dibujarPistas() {
		pistas.forEach(
			{ pista => pista.decode(randomnum.obtener(14), randomnum.obtener(9)) }
		)
	}
	
	method cambiarImage() {
		image = img
	}
	
	method cantPistas() = pistas.size()
	
	method colision() {
		
		//El nivel es un objeto por lo que al empezar el juego el detective colisiona con el nivel, debe tener este metodo como lo tienen las pistas para que no tire error en consola
	}
	
	method iniciar() {
		self.cambiarImage()
		detective.position(game.origin())
		game.addVisual(self)
		detective.setearPistasRestantes(self)
		game.addVisual(detective)
		detective.iniciarMovimientos()
		self.dibujarPistas()
		self.dibujarFondoHud()
		game.addVisual(hudPistasEncontradas)
		game.addVisual(hudVidas)
		game.addVisual(hudPistasRestantes)
	}
	
	method clear() {
		hudPistasEncontradas.reiniciar()
		hudVidas.reiniciar()
		hudPistasRestantes.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		detective.reiniciarMovimientos()
	}
	
	method mostrarPantallaDerrota() {
		juego.clear()
		pantallaDerrota.iniciar()
	}
}

const nivel1 = new Nivel(
	pistas = [p1, p1, p1, p1, p1, pp1, pp1],
	img = "nivel1.jpeg",
	siguienteNivel = nivel2
)

const nivel2 = new Nivel(
	pistas = [p2, p2, p2, p2, p2, pp2, pp2],
	img = "nivel2.jpeg",
	siguienteNivel = pantallaVictoria
)