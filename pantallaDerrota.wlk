import pistas.*
import detective.*
import juegoPrincipal.*
import pantallaInstrucciones.*
import pantallaInicio.*

object derrotaObject {
  const sonidoDerrota = game.sound("sfx-defeat6.mp3")
  const property position = game.at(0, 0)
  const property image = "pantalla_derrota_final.png"
  
  method mostrarPantallaDerrota() {
    sonidoDerrota.play()
    game.addVisual(self)
  } ////se borra la tecla para volver al inicio porque no anda, no hay solución////
}