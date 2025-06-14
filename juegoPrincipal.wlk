import pistas.*
import detective.*
import pantallaInicio.*
import pantallaInstrucciones.*
import wollok.game.*

object juego {
	
 	method iniciarJuego() {
		keyboard.g().onPressDo({detective.ponerseGuantes()})
		keyboard.l().onPressDo({detective.quitarseGuantes()})
		game.onCollideDo(detective, {pista => detective.encontrar(pista)})
		
		game.say(detective, "Debo usar guantes para las pistas peligrosas")
		const musicaFondo = game.sound("posible_musica_para_timer.mp3")
		musicaFondo.play()

		nivel1.iniciar()
	
	}

}



///LOS NIVELES COMO OBJETOS ///


object nivel1 {
	
	method image() =  "nivel1.jpeg" 
	const listaPistas =[]
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)


	method initialize(){
		const nivel1Pistas = [new PistaOjo(position = game.at(6, 2), esPistaPeligrosa = true), 
							new PistaSangre( position = game.at(9,0), esPistaPeligrosa = false), 
							new PistaCuchillo(position = game.at(1, 6), esPistaPeligrosa = true)]
		self.agregarPistas(nivel1Pistas)
		
		game.addVisual(self)
		game.addVisual(estado)
		

	}
	method agregarPistas(pistas){listaPistas.addAll(pistas)}

	method iniciar(){
	
		listaPistas.forEach({p=> game.addVisual(p)})
		detective.position(game.origin())
		game.addVisualCharacter(detective)
	
		game.onTick(100, "pasarNivel1", {if(detective.pistasEncontradas() == self.cantPistasNivel()) {self.terminar()}})

	}
	method terminar(){
		estado.reiniciar()
		game.removeVisual(self)
		game.removeVisual(detective)
		game.removeTickEvent("pasarNivel1")
		nivel2.iniciar()
	}
}

object nivel2 {
	
	method image() =  "nivel2.jpeg" 
	const listaPistas =[]
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)

	method initialize(){
		const nivel1Pistas = [new PistaDinamita(position = game.at(10, 4), esPistaPeligrosa = true), 
							new PistaFosforos( position = game.at(8,0), esPistaPeligrosa = false), 
							new PistaNafta(position = game.at(2, 2), esPistaPeligrosa = false),
							new PistaKerosene( position = game.at(6,0), esPistaPeligrosa = false), 
							new PistaMolotov(position = game.at(12, 6), esPistaPeligrosa = true)]
		self.agregarPistas(nivel1Pistas)
		
	}


	method agregarPistas(pistas){listaPistas.addAll(pistas)}
	method iniciar(){

		game.addVisual(self)
		game.removeVisual(estado)
		game.addVisual(estado)
		
		listaPistas.forEach({p=> game.addVisual(p)})

		detective.position(game.origin())
		game.addVisualCharacter(detective)
		
		game.onTick(100, "pasarNivel2", {if(detective.pistasEncontradas() == self.cantPistasNivel()) {self.terminar()}})

	}
	method terminar(){
		estado.reiniciar()
		game.removeVisual(self)
		game.removeTickEvent("PasarNivel2")
		game.stop()
		//nivel3.iniciar()
	}
}

object nivel3 {
	
	method image() =  "nivel3.png" 
	const listaPistas =[]
	method cantPistasNivel() = listaPistas.size()
	var property position = game.at(0,0)


	method initialize(){
		const nivel3Pistas = [new PistaDinamita(position = game.at(5, 4), esPistaPeligrosa = true),
							new PistaNafta(position = game.at(5, 2), esPistaPeligrosa = false),
							new PistaFosforos( position = game.at(8,0), esPistaPeligrosa = false),							
							new PistaMolotov(position = game.at(9,2), esPistaPeligrosa = true),
							new PistaKerosene(position = game.at(9,2), esPistaPeligrosa = false)]
		self.agregarPistas(nivel3Pistas)
		
	}

	method agregarPistas(pistas){listaPistas.addAll(pistas)}

	method iniciar(){
	
		game.addVisual(self)
		game.addVisual(estado)
		
		listaPistas.forEach({p=> game.addVisual(p)})
		detective.position(game.origin())
		game.addVisualCharacter(detective)
	
		game.onTick(100, "pasarNivel", {if(detective.pistasEncontradas() == self.cantPistasNivel()) {self.terminar()}})

	}
	method terminar(){
		game.stop()
	}
}