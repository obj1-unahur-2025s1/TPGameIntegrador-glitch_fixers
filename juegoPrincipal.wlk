import pistas.*
import detective.*
import pantallaInicio.*
import pantallaInstrucciones.*
import pantallaDerrota.*
import pantallaGanador.*
import wollok.game.*

object juego {
	
 	method iniciarJuego() {
		keyboard.g().onPressDo({detective.ponerseGuantes()})
		keyboard.l().onPressDo({detective.quitarseGuantes()})
		game.onCollideDo(detective, {pista => detective.encontrar(pista)})
		game.onCollideDo(detective, {unFondoEstado => detective.caerPor(unFondoEstado)})

		

		game.say(detective, "Debo usar guantes para las pistas peligrosas")
		const musicaFondo = game.sound("posible_musica_para_timer.mp3")
		musicaFondo.shouldLoop(true)
		musicaFondo.play()

		//manejo del sonido (bajar o mutear la música):
		keyboard.m().onPressDo({musicaFondo.volume(1)})
  		keyboard.n().onPressDo({musicaFondo.volume(0.5)})
		keyboard.b().onPressDo({musicaFondo.volume(0.25)})
		keyboard.v().onPressDo({musicaFondo.volume(0)})
		//iniciar el nivel:
		nivel1.iniciar()
	}

}

object randomnum{
	method obtener(num) = 1.randomUpTo(num).truncate(0)
}


///LOS NIVELES COMO OBJETOS ///

object nivel1 {
	
	method image() =  "nivel1.jpeg" 
	const listaPistas =[]
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)


	method initialize(){
		const nivel1Pistas = [
			new PistaVeneno(position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa = false), 
			new PistaOjo(position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa = true), 
			new PistaSangre( position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa=false), 
			new PistaSangre( position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa=false), 
			new PistaNota( position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa=false), 
			new PistaNota( position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa=false), 
			new PistaHuella( position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa=false), 
			new PistaCuchillo(position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa =true),
			new PistaCuchillo(position = game.at(randomnum.obtener(14), randomnum.obtener(9)), esPistaPeligrosa =true)]

		self.agregarPistas(nivel1Pistas)
		
		//fondos para el HUD:
		const fondo_0 = new FondoEstado(position = game.at(0,9))
		const fondo_1 = new FondoEstado(position = game.at(1,9))
		const fondo_2 = new FondoEstado(position = game.at(2,9))
		const fondo_3 = new FondoEstado(position = game.at(3,9))
		const fondo_4 = new FondoEstado(position = game.at(4,9))
		const fondo_5 = new FondoEstado(position = game.at(5,9))
		const fondo_6 = new FondoEstado(position = game.at(6,9))
		const fondo_7 = new FondoEstado(position = game.at(7,9))
		const fondo_8 = new FondoEstado(position = game.at(8,9))
		const fondo_9 = new FondoEstado(position = game.at(9,9))
		const fondo_10 = new FondoEstado(position = game.at(10,9))
		const fondo_11 = new FondoEstado(position = game.at(11,9))
		const fondo_12 = new FondoEstado(position = game.at(12,9))
		const fondo_13 = new FondoEstado(position = game.at(13,9))
		const fondo_14 = new FondoEstado(position = game.at(14,9))
		//agregado de dichos fondos:
		game.addVisual(self)
		game.addVisual(fondo_0)
		game.addVisual(fondo_1)
		game.addVisual(fondo_2)
		game.addVisual(fondo_3)
		game.addVisual(fondo_4)
		game.addVisual(fondo_5)
		game.addVisual(fondo_6)
		game.addVisual(fondo_7)
		game.addVisual(fondo_8)
		game.addVisual(fondo_9)
		game.addVisual(fondo_10)
		game.addVisual(fondo_11)
		game.addVisual(fondo_12)
		game.addVisual(fondo_13)
		game.addVisual(fondo_14)
		game.addVisual(estado)
		
	}
	method agregarPistas(pistas){listaPistas.addAll(pistas)}

	method iniciar(){
	
		listaPistas.forEach({p=> game.addVisual(p)})
		detective.position(game.origin())
		game.addVisualCharacter(detective)
	
		game.onTick(100, "pasarNivel1", {if(detective.pistasEncontradas() == self.cantPistasNivel()) {self.terminar()}
		                                 if (detective.vidas() < 1) self.mostrarPantallaDerrota()
		}) //tiene un if y luego otro if porque si no cumple con una condicion no se debe ejecutar la otra , debe preguntar de nuevo
		   //porque si se usa else directamente el nivel 1 arranca con la pantalla de derrota

	}
	method terminar(){
		estado.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeTickEvent("pasarNivel1")
		nivel2.iniciar()
	}

	method mostrarPantallaDerrota() {
		estado.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeTickEvent("pasarNivel1")
		derrotaObjet.mostrarPantallaDerrota()
		//keyboard.space().onPressDo({instrucciones.mostrarInstrucciones()}) no funciono :c
		game.stop()
	} 
}

object nivel2 {
	
	method image() =  "nivel2.jpeg" 
	const listaPistas =[]
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)

	method initialize(){
		const nivel1Pistas = [new PistaDinamita(position = game.at(10, 4), esPistaPeligrosa = true), 
							new PistaFosforos( position = game.at(2,6), esPistaPeligrosa = false), 
							new PistaFosforos( position = game.at(8,0), esPistaPeligrosa = false),
							new PistaNafta(position = game.at(2, 2), esPistaPeligrosa = false),
							new PistaNafta(position = game.at(4, 8), esPistaPeligrosa = false),
							new PistaKerosene( position = game.at(6,0), esPistaPeligrosa = false),
							new PistaHuella( position = game.at(8,6), esPistaPeligrosa = false), 
							new PistaMolotov(position = game.at(10, 6), esPistaPeligrosa = true),
							new PistaMolotov(position = game.at(12, 6), esPistaPeligrosa = true)]
		self.agregarPistas(nivel1Pistas)
		
	}


	method agregarPistas(pistas){listaPistas.addAll(pistas)}
	method iniciar(){

		game.addVisual(self)
		
		//creo de nuevo los fondos:
		const fondo_0 = new FondoEstado(position = game.at(0,9))
		const fondo_1 = new FondoEstado(position = game.at(1,9))
		const fondo_2 = new FondoEstado(position = game.at(2,9))
		const fondo_3 = new FondoEstado(position = game.at(3,9))
		const fondo_4 = new FondoEstado(position = game.at(4,9))
		const fondo_5 = new FondoEstado(position = game.at(5,9))
		const fondo_6 = new FondoEstado(position = game.at(6,9))
		const fondo_7 = new FondoEstado(position = game.at(7,9))
		const fondo_8 = new FondoEstado(position = game.at(8,9))
		const fondo_9 = new FondoEstado(position = game.at(9,9))
		const fondo_10 = new FondoEstado(position = game.at(10,9))
		const fondo_11 = new FondoEstado(position = game.at(11,9))
		const fondo_12 = new FondoEstado(position = game.at(12,9))
		const fondo_13 = new FondoEstado(position = game.at(13,9))
		const fondo_14 = new FondoEstado(position = game.at(14,9))

		//Los agrego de nuevo:
		game.addVisual(fondo_0)
		game.addVisual(fondo_1)
		game.addVisual(fondo_2)
		game.addVisual(fondo_3)
		game.addVisual(fondo_4)
		game.addVisual(fondo_5)
		game.addVisual(fondo_6)
		game.addVisual(fondo_7)
		game.addVisual(fondo_8)
		game.addVisual(fondo_9)
		game.addVisual(fondo_10)
		game.addVisual(fondo_11)
		game.addVisual(fondo_12)
		game.addVisual(fondo_13)
		game.addVisual(fondo_14)
		game.removeVisual(estado)
		game.addVisual(estado)
		//nota: he notado un error ya que, de alguna forma, los fondos del hud del nivel 1 siguen afectando al nivel 2, así q cuando el pj se acerca a los de este nivel, se cae y baja 2 espacios en vez de 1. Quizás agregarlos como una lista o objetos planteados dentro de otro archivo sea la solución.
		listaPistas.forEach({p=> game.addVisual(p)})

		detective.position(game.origin())
		game.addVisualCharacter(detective)
		game.onTick(100, "pasarNivel2", {if(detective.pistasEncontradas() == self.cantPistasNivel()){self.terminar()}
										 if (detective.vidas() < 1) self.mostrarPantallaDerrota()
		})

	}
	method terminar(){
		estado.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeVisual(estado)
		game.removeTickEvent("PasarNivel2")
		victoriaObjet.mostrarPantallaVictoria()
		game.stop()
	}

	method mostrarPantallaDerrota() {
		estado.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeTickEvent("PasarNivel2")
		derrotaObjet.mostrarPantallaDerrota()
		game.stop()
	} 
}