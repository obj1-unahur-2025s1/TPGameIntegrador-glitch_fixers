class Pista {
    var property position = game.center()
    method image() = "lupa.png"
}

class Pista1 inherits Pista {
    override method image() = "ojo.png"
    method desaparecer() {
        //agregar una acción que haga que el objeto cambie a una imagen vacía
    }
}

class Pista2 inherits Pista{
    override method position() = game.at(0,3)
    override method image() = "sangre.png"
    method desaparecer() {
        //agregar una acción que haga que el objeto cambie a una imagen vacía
    }
}

class Pista3 inherits Pista {
    override method position()= game.at(2, 1)
    override method image() = "cuchillo.png"
    method desaparecer() {
        //agregar una acción que haga que el objeto cambie a una imagen vacía
    }
}