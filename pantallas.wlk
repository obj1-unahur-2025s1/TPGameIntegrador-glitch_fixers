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

object pantallaVictoria {
	const sonidoVictoria = game.sound("victoria.mp3")
	const property position = game.at(0, 0)
	const property image = "victoria.png"
	
	method mostrar() {
		sonidoVictoria.play()
		game.addVisual(self)

		keyboard.r().onPressDo(
			{ 
				sonidoVictoria.stop()
				game.allVisuals().forEach({ visual => game.removeVisual(visual) })
				nivel1.iniciar()
			}
		)
	}
}

object pantallaDerrota {
	const sonidoDerrota = game.sound("derrota.mp3")
	const property position = game.at(0, 0)
	const property image = "derrota.png"
	
	method mostrar() {
		sonidoDerrota.play()
		game.addVisual(self)
		keyboard.t().onPressDo(
			{ 
				game.allVisuals().forEach({ visual => game.removeVisual(visual) })
				sonidoDerrota.stop()
				nivel1.iniciar()
			}
		)
	}
}