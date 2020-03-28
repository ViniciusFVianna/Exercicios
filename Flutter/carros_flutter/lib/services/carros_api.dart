import 'dart:convert';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/services/api_response.dart';
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
    var url =
        'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

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

  static Future<ApiResponse<bool>> save(Carro c) async {
    Usuario user = await Usuario.get();
    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

    if (c.id != null) {
      url += "/${c.id}";
    }

    print("POST > $url");
    String json = c.toJson();

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var response = await (c.id == null
        ? http.post(url, body: json, headers: headers)
        : http.put(url, body: json, headers: headers));

    try {
      print("RESPONSE STATUS: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = jsonDecode(response.body);
        Carro carro = Carro.fromMap(mapResponse);
        print("Novo carro: ${carro.id}");
        return ApiResponse.ok(true);
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error("Não foi possível salva o carro");
      }
    } catch (e) {
      Map mapResponse = jsonDecode(response.body);
      return ApiResponse.error(mapResponse["error"]);
    }
  }

  static Future<ApiResponse<bool>> updadte(Carro c) async {
    Usuario user = await Usuario.get();
    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros';

    print("POST > $url");
    String json = c.toJson();

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token}"
    };

    var response = await http.post(url, body: json, headers: headers);

    print("RESPONSE STATUS: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

    if (response.statusCode == 201) {
      Map mapResponse = jsonDecode(response.body);
      Carro carro = Carro.fromMap(mapResponse);
      print("Novo carro: ${carro.id}");
      return ApiResponse.ok(true);
    }

    Map mapResponse = jsonDecode(response.body);
    return ApiResponse.error(mapResponse["error"]);
  }
}
