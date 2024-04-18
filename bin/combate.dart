import 'dart:io';
import 'dart:math';
import 'pokemon.dart';

class Combate {
  Pokemon pokemon1 = Pokemon();
  Pokemon pokemon2 = Pokemon();

  Combate(pokemon1, pokemon2) {
    this.pokemon1 = pokemon1;
    this.pokemon2 = pokemon2;
  }

  static Future<Combate> iniciarCombate() async {
    stdout.writeln('********** COMBATE POKEMON **********');
    stdout.writeln('El pokemon 1 es:');
    int random = Random().nextInt(1024);
    Pokemon pokemon1 = await Pokemon().obtenerPokemon(random.toString());
    Pokemon.imprimirInfo(pokemon1);
    stdout.writeln('El pokemon 2 es:');
    random = Random().nextInt(1024);
    Pokemon pokemon2 = await Pokemon().obtenerPokemon(random.toString());
    Pokemon.imprimirInfo(pokemon2);
    return Combate(pokemon1, pokemon2);
  }

  int atacar(Pokemon atacante, Pokemon defensor) {
    stdout.writeln("${atacante.nombre} ataca a ${defensor.nombre}...");
    sleep(Duration(seconds: 1));
    if (esquiva(atacante.velocidad, defensor.velocidad)) {
      stdout.writeln("${defensor.nombre} es más rápido y esquiva el ataque");
      return 0;
    }
    if(defensor.coraza) {
      defensor.defensa *= 2;
      stdout.writeln("${defensor.nombre} tiene coraza!");  
    }
    int dano = atacante.ataque - defensor.defensa;
    if (dano < 20) dano = 20;
    stdout.writeln("${defensor.nombre} recibe $dano puntos de daño. Vida restante: ${defensor.vida - dano}");
    return dano;
  }

  bool esquiva(int velocidadAtacante, int velocidadDefensor) {
    return Random().nextInt(velocidadAtacante) <
        Random().nextInt(velocidadDefensor);
  }
}
