import detective.*
import pistas.*
import hud.*
import decodificadores.*
import pantallas.*

object randomnum {
	method obtener(num) = 1.randomUpTo(num).truncate(0)
	
	method obtenerPar(num) {
		const cantidadDePares = (num / 2).truncate(0) + 1
		const parRandom = 1.randomUpTo(cantidadDePares).truncate(0)
		return parRandom * 2
	}
}

object nivel1 {
	var property position = game.at(0, 0)
	const pistas = [p1, p1, p1, p1, p1, pp1, pp1]
	const fondos = [f, f, f, f, f, f, f, f, f, f, f, f, f, f, f]
	const musicaFondo = game.sound("musica_fondo.mp3")
	
	method dibujarFondoHud() {
		var x = 0
		fondos.forEach({ fondo =>	fondo.decode(x, 9)x += 1})
	}
	
	method dibujarPistas() {
		pistas.forEach(
			{ pista => pista.decode(randomnum.obtener(14), randomnum.obtener(9)) }
		)
	}
	
	method image() = "nivel1.jpeg"
	
	method cantPistas() = pistas.size()
	
	method colision() {
		
		//El nivel es un objeto por lo que al empezar el juego el detective colisiona con el nivel, debe tener este metodo como lo tienen las pistas para que no tire error en consola
	}
	
	method iniciar() {
		detective.position(game.origin())
		game.addVisual(self)
		game.addVisual(detective)
		detective.iniciarMovimientos()
		self.dibujarPistas()
		self.dibujarFondoHud()
		game.addVisual(hudPistasEncontradas)
		game.addVisual(hudVidas)
		game.addVisual(hudPistasRestantes)
		game.onTick(
			100,
			"pasarNivel1",
			{ if (detective.pistasEncontradas() == self.cantPistas())
				 	self.siguienteNivel() }
		)
		
		game.onTick(
			100,
			"perder",
			{ if (detective.vidas() < 1) self.mostrarPantallaDerrota() }
		)
		musicaFondo.shouldLoop(true)
		musicaFondo.play()
		keyboard.m().onPressDo(
			{ musicaFondo.volume((musicaFondo.volume() + 0.1).min(1)) }
		)
		keyboard.n().onPressDo(
			{ musicaFondo.volume((musicaFondo.volume() - 0.1).max(0)) }
		)
	}
	
	method siguienteNivel() {
		hudPistasEncontradas.reiniciar()
		hudVidas.reiniciar()
		hudPistasRestantes.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		detective.reiniciarMovimientos()
		game.removeTickEvent("pasarNivel1")
		game.removeTickEvent("perder")
		musicaFondo.stop()
		nivel2.iniciar()
		detective.pasarDeNivel()
	}
	
	method mostrarPantallaDerrota() {
		hudPistasEncontradas.reiniciar()
		hudVidas.reiniciar()
		hudPistasRestantes.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		detective.reiniciarMovimientos()
		game.removeTickEvent("pasarNivel1")
		game.removeTickEvent("perder")
		musicaFondo.stop()
		pantallaDerrota.mostrar()
	}
}

object nivel2 {
	var property position = game.at(0, 0)
	const pistas = [p2, p2, p2, p2, p2, pp2, pp2]
	const fondos = [f, f, f, f, f, f, f, f, f, f, f, f, f, f, f]
	const musicaFondo = game.sound("musica_fondo.mp3")
	
	method dibujarFondoHud() {
		var x = 0
		fondos.forEach({ fondo =>	fondo.decode(x, 9)x += 1})
	}
	
	method dibujarPistas() {
		pistas.forEach(
			{ pista => pista.decode(randomnum.obtener(14), randomnum.obtener(9)) }
		)
	}
	
	method image() = "nivel2.jpeg"
	
	method cantPistas() = pistas.size()
	
	method colision() {
		
		//El nivel es un objeto por lo que al empezar el juego el detective colisiona con el nivel, debe tener este metodo como lo tienen las pistas para que no tire error en consola
	}
	
	method iniciar() {
		detective.position(game.origin())
		game.addVisual(self)
		game.addVisual(detective)
		detective.iniciarMovimientos()
		self.dibujarPistas()
		self.dibujarFondoHud()
		game.addVisual(hudPistasEncontradas)
		game.addVisual(hudVidas)
		game.addVisual(hudPistasRestantes)
		game.onTick(
			100,
			"pasarNivel2",
			{ if (detective.pistasEncontradas() == self.cantPistas()) self.terminar(pantallaVictoria) }
		)
		game.onTick(
			100,
			"perder",
			{ if (detective.vidas() < 1) self.terminar(pantallaDerrota) }
		)
		musicaFondo.shouldLoop(true)
		musicaFondo.play()
		keyboard.m().onPressDo(
			{ musicaFondo.volume((musicaFondo.volume() + 0.1).min(1)) }
		)
		keyboard.n().onPressDo(
			{ musicaFondo.volume((musicaFondo.volume() - 0.1).max(0)) }
		)
	}
	
	method terminar(pantallaX) {
		hudPistasEncontradas.reiniciar()
		hudVidas.reiniciar()
		hudPistasRestantes.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		detective.reiniciarMovimientos()
		game.removeTickEvent("perder")
		game.removeTickEvent("pasarNivel2")
		game.allVisuals().forEach({ visual => game.removeVisual(visual) })
		musicaFondo.stop()
		pantallaX.mostrar()
		//para evitar repeticion de metodos se pasa por parametro la pantalla dependiendo el resultado del evento
	}
}