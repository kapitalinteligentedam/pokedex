import "dart:io";
import "combate.dart";
import "habilidad.dart";
import "pokemon.dart";

class App {
  static inicioApp()async {
    int? seleccion = pedirOpcion();
    switch(seleccion){
      case 1:
        biblioteca();
        break;
      case 2:
        Combate.combate();
        break;
      default:
        inicioApp();   
    }
  }

  static String _pedirNombre(){
    stdout.writeln("Escribe el nombre del pokémon a consultar");
    return stdin.readLineSync() ?? "error";
  }
  
  
  
  static int? pedirOpcion() {
    int? opcion;
    do {
      stdout.writeln('''Selecciona una de las siguientes opciones:
        1 - Biblioteca Pokemon
        2 - Combate Pokemon''');
        opcion = int.tryParse(stdin.readLineSync() ?? 'e');
    } while(opcion == null);
    return opcion;
  }
  
  static biblioteca() async {
    String respuesta = _pedirNombre();
    Pokemon pokemon = await Pokemon().obtenerPokemon(respuesta);
    Pokemon.imprimirInfo(pokemon);
  }
}