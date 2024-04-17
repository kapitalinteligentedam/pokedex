import "dart:io";
import "dart:math";
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
        combate();
        break;
      default:
        inicioApp();
        
    }
    
    
    
  }

  static String _pedirNombre(){
    stdout.writeln("Escribe el nombre del pokémon a consultar");
    return stdin.readLineSync() ?? "error";
  }
  
  static imprimirInfo(Pokemon pokemon) {
    stdout.writeln("Nombre: ${pokemon.nombre}");
    stdout.writeln("Estadísticas:");
    stdout.writeln("    Vida:             ${pokemon.vida}");
    stdout.writeln("    Ataque:           ${pokemon.ataque}");
    stdout.writeln("    Defensa:          ${pokemon.defensa}");
    stdout.writeln("    Ataque especial:  ${pokemon.ataqueEspecial}");
    stdout.writeln("    Defensa especial: ${pokemon.defensaEspecial}");
    stdout.writeln("    Velocidad:        ${pokemon.velocidad}");
    stdout.writeln("Tipos:");
    for(var elemento in pokemon.tipos){
      stdout.writeln("    $elemento");
    }
    stdout.writeln("Habilidades:");
    for(Habilidad elemento in pokemon.habilidades){
      stdout.writeln("    ${elemento.nombre?.toUpperCase()}");
    }
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
    imprimirInfo(pokemon);
  }
  
  static combate() async {
    stdout.writeln('********** COMBATE POKEMON **********');
    stdout.writeln('El pokemon 1 es:');
    int random = Random().nextInt(1301);
    Pokemon pokemon = await Pokemon().obtenerPokemon(random.toString());
    imprimirInfo(pokemon);
    stdout.writeln('El pokemon 2 es:');
    random = Random().nextInt(1301);
    Pokemon pokemon2 = await Pokemon().obtenerPokemon(random.toString());
    imprimirInfo(pokemon2);
  }
}