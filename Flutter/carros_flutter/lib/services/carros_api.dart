import 'dart:convert';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/pages/carros/carro_dao.dart';
import 'package:http/http.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario user = await Usuario.get();
    print("TOKEN >> ${user.token}");

//final url = 'http://carros-springboot.herokuapp.com/api/v1/carros';
    var url = "https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";

    print("GET > $url");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    final response = await http.get(url, headers: headers);
    final List dados = jsonDecode(response.body);

    List<Carro> carros = dados.map<Carro>((c) => Carro.fromMap(c)).toList();

    return carros;
  }
}