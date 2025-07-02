import niveles.*
import juego.*

object inicio {
	const property position = game.at(0, 0)
	const property image = "inicio.png"
	var estaActivada = false
	//variable bandera para que no se ejecute el metodo al apretar enter mientras corre el juego
	var instruccionesEnPantalla = false //solucionado el bug de la tecla enter
	
	method mostrar() {
		if (!estaActivada) {
			game.addVisual(self)
			estaActivada = true
			keyboard.enter().onPressDo({ self.cerrar() })
		}
	}
	
	method cerrar() {
		estaActivada = false //agregado de valor false al cerrar inicio
		game.removeVisual(self)
		if (not instruccionesEnPantalla) {
			//solucionado el bug de la tecla enter
			instruccionesEnPantalla = true
			instrucciones.mostrar()
		}
	}
}

object instrucciones {
	const property position = game.at(0, 0)
	const property image = "instrucciones.png"
	var estaActivada = false
	//variable bandera para que no se ejecute el metodo al apretar espacio mientras corre el juego
	var juegoIniciado = false //solucionado el bug de la tecla espacio
	
	method mostrar() {
		if (!estaActivada) {
			game.addVisual(self)
			estaActivada = true
			keyboard.space().onPressDo({ self.cerrar() })
		}
	}
	
	method cerrar() {
		estaActivada = false //agregado de valor false al cerrar instrucciones
		game.removeVisual(self)
		if (not juegoIniciado) {
			//solucionado el bug de la tecla espacio
			juegoIniciado = true
			juego.iniciar()
		}
	}
}

class Pantalla {
	const sonido 
	const img
	const property position = game.at(0, 0)
	var property image = ""
	var property sound = ""
	
	method cambiarImage() {
		image = img
	}

	method cambiarSound() {
		sound =  game.sound(sonido)
	}

	method clear (){
		//Debe conocerlo por polimorfismo
	}
	
	method iniciar() {
		self.cambiarImage()
		self.cambiarSound()
		sound.play()
		game.addVisual(self)
	}
}

const pantallaVictoria = new Pantalla(
	sonido = "victoria.mp3",
	img = "victoria.png"
)

const pantallaDerrota = new Pantalla(
	sonido = "derrota.mp3",
	img = "derrota.png"
)