import 'dart:io';
import 'dart:math';
import 'pokemon.dart';

class Combate {
  Pokemon? pokemon1;
  Pokemon? pokemon2;

  Combate(pokemon1,pokemon2);

  static combate() async { 
    stdout.writeln('********** COMBATE POKEMON **********');
    stdout.writeln('El pokemon 1 es:');
    int random = Random().nextInt(1024);
    Pokemon pokemon1 = await Pokemon().obtenerPokemon(random.toString());
    Pokemon.imprimirInfo(pokemon1);
    stdout.writeln('El pokemon 2 es:');
    random = Random().nextInt(1024);
    Pokemon pokemon2 = await Pokemon().obtenerPokemon(random.toString());
    Pokemon.imprimirInfo(pokemon2);
  }
}