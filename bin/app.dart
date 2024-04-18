import "dart:io";
import "combate.dart";
import "pokemon.dart";

class App {
  static inicioApp() async {
    int? seleccion = pedirOpcion();
    switch (seleccion) {
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

  static String _pedirNombre() {
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
    } while (opcion == null);
    return opcion;
  }

  static biblioteca() async {
    String respuesta = _pedirNombre();
    Pokemon pokemon = await Pokemon().obtenerPokemon(respuesta);
    Pokemon.imprimirInfo(pokemon);
  }

  static int? turno(Pokemon pokemon) {
    int? opcion;
    do {
      stdout.writeln('''Turno de ${pokemon.nombre}:
        1 - Atacar
        2 - Defender''');
      opcion = int.tryParse(stdin.readLineSync() ?? 'e');
    } while (opcion == null);
    return opcion;
  }

  static combate() async {
    Combate combate = await Combate.iniciarCombate();
    while (true) {
      int? opcion1 = turno(combate.pokemon1);
      switch (opcion1) {
        case 1:
          combate.pokemon1.coraza = false;
          int dano = combate.atacar(combate.pokemon1, combate.pokemon2);
          combate.pokemon2.vida -= dano;
          break;
        case 2:
          stdout.writeln("${combate.pokemon1.nombre} se protege!");
          combate.pokemon1.coraza = true;
          break;
      }
      if (combate.pokemon2.vida <= 0) {
        print("${combate.pokemon2.nombre} ha sido derrotado!");
        break;
      }
      int? opcion2 = turno(combate.pokemon2);
      switch (opcion2) {
        case 1:
          combate.pokemon2.coraza = false;
          int dano = combate.atacar(combate.pokemon2, combate.pokemon1);
          combate.pokemon1.vida -= dano;
          break;
        case 2:
          stdout.writeln("${combate.pokemon2.nombre} se protege!");
          combate.pokemon2.coraza = true;
          break;
      }
      if (combate.pokemon1.vida <= 0) {
        print("${combate.pokemon1.nombre} ha sido derrotado!");
        break;
      }
    }
  }
}
