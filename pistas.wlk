class Pista {
    var esPistaPeligrosa = false
    var property position 
    method desaparecer() {
        game.removeVisual(self)
    }
    method esPistaPeligrosa() = esPistaPeligrosa 
    
}


class PistaOjo inherits Pista(esPistaPeligrosa = true) {
    method image() = "ojo.png"
    
}

class PistaSangre inherits Pista{
    method image() = "sangre.png"
    
}

class PistaCuchillo inherits Pista(esPistaPeligrosa = true) {
    method image() = "cuchillo.png"
    
}

class PistaDinamita inherits Pista(esPistaPeligrosa = true){
    method image() = "dinamita.png"
}

class PistaVeneno inherits Pista(esPistaPeligrosa = true){
    method image() = "veneno.png"
}

class PistaNota inherits Pista {
    method image() = null // agregrar imagen de una nota
}

class PistaHuellaDactilar inherits Pista {
    method image() = null // agregrar imagen de una nota
}