import wollok.game.*

class Pista {
    const esPistaPeligrosa
    var property position 
    method desaparecer() {
        game.removeVisual(self)
    }
    method esPistaPeligrosa() = esPistaPeligrosa 
    
}


class PistaOjo inherits Pista {
    method image() = "ojo.png"
    
}

class PistaSangre inherits Pista{
    method image() = "sangre.png"
    
}

class PistaCuchillo inherits Pista {
    method image() = "cuchillo.png"
    
}

class PistaDinamita inherits Pista{
    method image() = "dinamita.png"
}

class PistaVeneno inherits Pista{
    method image() = "veneno.png"
}

class PistaNota inherits Pista {
    method image() = "nota_1.png" //cambio de imagen de nota.png a nota_1.png
}

class PistaHuella inherits Pista {
    method image() = "huella_dactilar_1.png" //cambio de imagen de huella.png a huella_dactilar_1.png
}

class PistaFosforos inherits Pista {
    method image() = "fosforos.png"
    
}

class PistaKerosene inherits Pista{
    method image() = "kerosene.png"
}

class PistaMolotov inherits Pista{
    method image() = "molotov.png"
}
class PistaNafta inherits Pista{
    method image() = "bidonNafta.png"
}



