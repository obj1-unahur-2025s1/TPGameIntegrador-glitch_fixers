class Pista {
    var esPistaPeligrosa = false
    method desaparecer() {
        game.removeVisual(self)
    }
    method esPistaPeligrosa() = esPistaPeligrosa 
    
}


class PistaOjo inherits Pista {
    method position()= game.at(1, 7)
    method image() = "ojo.png"
    
}

class PistaSangre inherits Pista{
    method position() = game.at(0,3)
    method image() = "sangre.png"
    
}

class PistaCuchillo inherits Pista {
    method position()= game.at(2, 1)
    method image() = "cuchillo.png"
    
}

class PistaDinamita inherits Pista(esPistaPeligrosa = true){
    method position()= game.at(5, 5)
    method image() = "dinamita.png"
}

class PistaVeneno inherits Pista(esPistaPeligrosa = true){
    method position()= game.at(9, 1)
    method image() = "veneno.png"
}