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
		game.onCollideDo(detective, {pista => detective.encontrar(pista)}) //usar polimorfismo, hacer que el espacio sepa responder a encontrar una pista
		game.onCollideDo(detective, {unFondoEstado => detective.caerPor(unFondoEstado)})

		game.say(detective, "Debo usar guantes para las pistas peligrosas")

		//musica se activa para que comience en el nivel 1
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
	const listaTilesDeFondo = []
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)
	const musicaFondo = game.sound("musica_para_timer_1.mp3")

	method initialize(){
		musicaFondo.volume(0.3)
		const nivel1Pistas = [
			new PistaVeneno(position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa = false), 
			new PistaOjo(position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa = true), 
			new PistaSangre( position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa=false), 
			new PistaSangre( position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa=false), 
			new PistaNota( position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa=false), 
			new PistaNota( position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa=false), 
			new PistaHuella( position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa=false), 
			new PistaCuchillo(position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa =true),
			new PistaCuchillo(position = game.at(randomnum.obtener(14), randomnum.obtener(8)), esPistaPeligrosa =true)]

		self.agregarPistas(nivel1Pistas)
		
		game.addVisual(self)

		const listaTilesDeFondoNivel1 = [
			new FondoEstado(position = game.at(0,9)) ,
			new FondoEstado(position = game.at(1,9)) ,
			new FondoEstado(position = game.at(2,9)) ,
			new FondoEstado(position = game.at(3,9)) ,
			new FondoEstado(position = game.at(4,9)) ,
			new FondoEstado(position = game.at(5,9)) ,
			new FondoEstado(position = game.at(6,9)) ,
			new FondoEstado(position = game.at(7,9)) ,
			new FondoEstado(position = game.at(8,9)) ,
			new FondoEstado(position = game.at(9,9)) ,
			new FondoEstado(position = game.at(10,9)) ,
			new FondoEstado(position = game.at(11,9)) ,
			new FondoEstado(position = game.at(12,9)) ,
			new FondoEstado(position = game.at(13,9)) ,
			new FondoEstado(position = game.at(14,9))
		]
		self.agregarFondo(listaTilesDeFondoNivel1)

		//game.addVisual(estado)

	}

	method agregarPistas(pistas){listaPistas.addAll(pistas)}

	method agregarFondo(tilesDeFondo) { //método que agrega todos los tiles del fondo de forma más sencilla
		listaTilesDeFondo.addAll(tilesDeFondo)
	}

	method iniciar(){
		listaTilesDeFondo.forEach({tile => game.addVisual(tile)}) //ahora cada tile se agrega en el fondo de una manera más sencilla!
		//agrego los estados por separado:
		game.addVisual(estado)
		game.addVisual(estado2)
		game.addVisual(estado3)

		listaPistas.forEach({p=> game.addVisual(p)})
		detective.position(game.origin())
		game.addVisualCharacter(detective)
	
		game.onTick(100, "pasarNivel1", {if(detective.pistasEncontradas() == self.cantPistasNivel()) {self.terminar()}})
	
		game.onTick(100, "perder", {if (detective.vidas() < 1) {self.mostrarPantallaDerrota()}})

			//tiene un if y luego otro if porque si no cumple con una condicion no se debe ejecutar la otra , debe preguntar de nuevo
		   //porque si se usa else directamente el nivel 1 arranca con la pantalla de derrota
		   //Se mejoro :D

		musicaFondo.shouldLoop(true)
	  	musicaFondo.play()
		keyboard.m().onPressDo({musicaFondo.volume(1)})
  		keyboard.n().onPressDo({musicaFondo.volume(0.5)})
	    keyboard.b().onPressDo({musicaFondo.volume(0.25)})
	    keyboard.v().onPressDo({musicaFondo.volume(0)})

	}

	method terminar(){
		estado.reiniciar()
		estado2.reiniciar()
		estado3.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeTickEvent("pasarNivel1") //division del evento original a dos eventos por separado
		game.removeTickEvent("perder")
		game.removeVisual(estado)
		game.removeVisual(estado2)
		game.removeVisual(estado3)
		musicaFondo.stop() // se detiene la música fondo del nivel 1 ya que se inicia otra vez en el nivel 2.
		listaTilesDeFondo.forEach({tile => game.removeVisual(tile)})
		nivel2.iniciar()
		detective.pasarDeNivel() //al pasar al nivel 2, el detective "reinicia" su cantidad de pistas por la cantidad de pistas que tenga el nivel 2 luego de ser iniciado.
	}

	method mostrarPantallaDerrota() {
		estado.reiniciar()
		estado2.reiniciar()
		estado3.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective) 
		game.removeTickEvent("perder") //division del evento original a dos eventos por separado
		game.removeTickEvent("pasarNivel1")
		musicaFondo.stop()
		game.removeVisual(estado)
		game.removeVisual(estado2)
		game.removeVisual(estado3)
		listaTilesDeFondo.forEach({tile => game.removeVisual(tile)})
		derrotaObject.mostrarPantallaDerrota()
		//descomentar este comando para que funcione, lo comente porque estaba probando para que vuelva
		//a la pantalla de inicio una vez pierde, funciona bien pero la musica falla.
	}
}

object nivel2 {
	method image() =  "nivel2.jpeg"
	const listaPistas =[]
	const listaTilesDeFondo = []
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)
	const musicaFondo = game.sound("musica_para_timer_1.mp3")
	

	method initialize(){
		musicaFondo.volume(0.3)
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
		
		const listaTilesDeFondoNivel2 = [
			new FondoEstado(position = game.at(0,9)) ,
			new FondoEstado(position = game.at(1,9)) ,
			new FondoEstado(position = game.at(2,9)) ,
			new FondoEstado(position = game.at(3,9)) ,
			new FondoEstado(position = game.at(4,9)) ,
			new FondoEstado(position = game.at(5,9)) ,
			new FondoEstado(position = game.at(6,9)) ,
			new FondoEstado(position = game.at(7,9)) ,
			new FondoEstado(position = game.at(8,9)) ,
			new FondoEstado(position = game.at(9,9)) ,
			new FondoEstado(position = game.at(10,9)) ,
			new FondoEstado(position = game.at(11,9)) ,
			new FondoEstado(position = game.at(12,9)) ,
			new FondoEstado(position = game.at(13,9)) ,
			new FondoEstado(position = game.at(14,9))
		]
		self.agregarFondo(listaTilesDeFondoNivel2)
	}


	method agregarPistas(pistas){listaPistas.addAll(pistas)}

	method agregarFondo(tilesDeFondo) { //método que agrega todos los tiles del fondo de forma más sencilla
		listaTilesDeFondo.addAll(tilesDeFondo)
	}
	method iniciar(){
		musicaFondo.play()
		game.addVisual(self)
		listaTilesDeFondo.forEach({tile => game.addVisual(tile)}) //agrega todos los tiles de la lista, en vez de tener que agregarlo 1 por 1.
		//game.removeVisual(estado)
		//agrego los estados por separado:
		game.addVisual(estado)
		game.addVisual(estado2)
		game.addVisual(estado3)

		//nota: he notado un error ya que, de alguna forma, los fondos del hud del nivel 1 siguen afectando al nivel 2, así q cuando el pj se acerca a los de este nivel, se cae y baja 2 espacios en vez de 1. Quizás agregarlos como una lista o objetos planteados dentro de otro archivo sea la solución.
		//este error ya fue corregido.

		listaPistas.forEach({p=> game.addVisual(p)})

		detective.position(game.origin())
		game.addVisualCharacter(detective)
		
		game.onTick(100, "pasarNivel2", {if(detective.pistasEncontradas() == self.cantPistasNivel()) {self.terminar()}})
		game.onTick(100, "cortarMusica", {if (detective.vidas() < 1) self.cortarMusica()})
		game.onTick(100, "perder", {if (detective.vidas() < 1) self.mostrarPantallaDerrota()})
	  	
		keyboard.m().onPressDo({musicaFondo.volume(1)})
  		keyboard.n().onPressDo({musicaFondo.volume(0.5)}) //agregarlos al juego, pero en este caso como subir/bajar volumen
	    keyboard.b().onPressDo({musicaFondo.volume(0.25)})
	    keyboard.v().onPressDo({musicaFondo.volume(0)})

	}

	method cortarMusica() {
		musicaFondo.stop()
	} 

	method terminar(){
		estado.reiniciar()
		estado2.reiniciar()
		estado3.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeVisual(estado)
		game.removeVisual(estado2)
		game.removeVisual(estado3)
		game.removeTickEvent("perder") //division del evento original a dos eventos por separado
		game.removeTickEvent("pasarNivel2")
		game.removeTickEvent("cortarMusica")
		listaTilesDeFondo.forEach({tile => game.removeVisual(tile)})
		musicaFondo.stop()
		victoriaObjet.mostrarPantallaVictoria()
	}

	method mostrarPantallaDerrota() {
		estado.reiniciar()
		estado2.reiniciar()
		estado3.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeVisual(estado)
		game.removeVisual(estado2)
		game.removeVisual(estado3)
		game.removeTickEvent("perder") //division del evento original a dos eventos por separado
		game.removeTickEvent("pasarNivel2")
		game.removeTickEvent("cortarMusica")
		musicaFondo.stop() //se intenta arreglar el bug poniendo esto pero tampoco anda
		listaTilesDeFondo.forEach({tile => game.removeVisual(tile)})
		derrotaObject.mostrarPantallaDerrota()
	} 
}