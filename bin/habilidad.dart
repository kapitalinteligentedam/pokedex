import "dart:convert";
import "package:http/http.dart" as http;

class Habilidad {
  String? nombre;
  List<String> pokemons = [];

  Habilidad();
  Habilidad.fromAPI(datos){
    nombre = datos['name'];
    for(var elemento in datos['pokemon']){
      pokemons.add(elemento['pokemon']['name']);
    }
  }

  obtenerHabilidad(String nombre) async {
    Uri url2 = Uri.parse("https://pokeapi.co/api/v2/ability/$nombre");
    var respuesta = await http.get(url2);
    if(respuesta.statusCode == 200){
      Habilidad habilidad = Habilidad.fromAPI(json.decode(respuesta.body));
      return habilidad;
    } else return;
  }
}