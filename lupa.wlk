object lupa {
  var property position = game.origin()
  var pistasEncontradas = 0
  method image() = "lupa_1.png" // remplazar la imagen en assets
  method encontrar() {
    self.aumentarCantidadDePistas() //aumenta desproporcionadamente, cuando sólo debería aumentar de a 1. Posible causa: el mantenerse en el mismo lugar funciona como un repeater?.
    return("Encontraste una pista")
  }
  method aumentarCantidadDePistas() {
    pistasEncontradas = pistasEncontradas + 1
  }
  method cuantasPistas() = "He encontrado " + pistasEncontradas.toString() + " pistas."
}