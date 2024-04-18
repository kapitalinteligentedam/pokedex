import "app.dart";
import 'habilidad.dart';
import "dart:convert";
import "package:http/http.dart" as http;
import "dart:io";

class Pokemon {
  String? nombre = 'John Doe';
  List<String> tipos = [];
  List<Habilidad> habilidades = [];
  int vida = 0;
  int ataque = 0;
  int defensa = 0;
  int ataqueEspecial = 0;
  int defensaEspecial = 0;
  int velocidad = 0;

  Pokemon();
  Pokemon.fromAPI(datos, listaHabilidades) {
    nombre = datos['name'];
    for (var elemento in datos['types']) {
      tipos.add(elemento['type']['name']);
    }
    for (var elemento in listaHabilidades) {
      habilidades.add(elemento);
    }
    for (var elemento in datos['stats']) {
      switch (elemento['stat']['name']) {
        case 'hp':
          vida = elemento['base_stat'] ?? 0;
          break;
        case 'attack':
          ataque = elemento['base_stat'];
          break;
        case 'defense':
          defensa = elemento['base_stat'];
          break;
        case 'special-attack':
          ataqueEspecial = elemento['base_stat'];
          break;
        case 'special-defense':
          defensaEspecial = elemento['base_stat'];
          break;
        case 'speed':
          velocidad = elemento['base_stat'];
          break;
      }
    }
  }

  listaDeHabilidades(datos) async {
    List<Habilidad> lista = [];
    for (var elemento in datos['abilities']) {
      lista
          .add(await Habilidad().obtenerHabilidad(elemento['ability']['name']));
    }
    return lista;
  }

  obtenerPokemon(String nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");
    var respuesta = await http.get(url);
    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        List lista = await listaDeHabilidades(body);
        Pokemon pokemon = Pokemon.fromAPI(body, lista);
        return pokemon;
      } else if (respuesta.statusCode == 404) {
        throw ("El pokemon que buscas no existe!");
      } else
        throw ("Ha habido un error de conexión");
    } catch (e) {
      stdout.writeln(e);
      App.inicioApp();
    }
  }

  static imprimirInfo(Pokemon pokemon) {
    stdout.writeln("Nombre: ${pokemon.nombre}");
    stdout.writeln(
        "Nivel: ${pokemon.vida + pokemon.ataque + pokemon.defensa + pokemon.ataqueEspecial + pokemon.defensaEspecial + pokemon.velocidad}");
    stdout.writeln("Estadísticas:");
    stdout.writeln("    Vida:             ${pokemon.vida}");
    stdout.writeln("    Ataque:           ${pokemon.ataque}");
    stdout.writeln("    Defensa:          ${pokemon.defensa}");
    stdout.writeln("    Ataque especial:  ${pokemon.ataqueEspecial}");
    stdout.writeln("    Defensa especial: ${pokemon.defensaEspecial}");
    stdout.writeln("    Velocidad:        ${pokemon.velocidad}");
    // stdout.writeln("Tipos:");
    // for(var elemento in pokemon.tipos){
    //   stdout.writeln("    $elemento");
    // }
    // stdout.writeln("Habilidades:");
    // for(Habilidad elemento in pokemon.habilidades){
    //   stdout.writeln("    ${elemento.nombre?.toUpperCase()}");
    // }
  }
}
