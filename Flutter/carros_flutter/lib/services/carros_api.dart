import 'dart:convert';
import 'dart:io';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/services/api_response.dart';
import 'package:carrosflutter/services/upload_service.dart';
import 'package:carrosflutter/utils/carros_contants.dart';
import 'package:carrosflutter/utils/http_helper.dart' as http;

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

//final url = 'http://carros-springboot.herokuapp.com/api/v1/carros';
    var url = '$BASE_URL/carros/tipo/$tipo';

    print("GET > $url");

    final response = await http.get(url);
    final List dados = jsonDecode(response.body);

    List<Carro> carros = dados.map<Carro>((c) => Carro.fromMap(c)).toList();

    return carros;
  }

  static Future<ApiResponse<bool>> save(Carro c, File file) async {

    if(file != null){
      ApiResponse<String> response = await UploadService.upload(file);
      if(response.ok){
        String urlFoto = response.result;
        c.urlFoto = urlFoto;
      }
    }

    var url = '$BASE_URL/carros';

    if (c.id != null) {
      url += "/${c.id}";
    }

    print("POST > $url");
    String json = c.toJson();

    var response = await (c.id == null
        ? http.post(url, body: json)
        : http.put(url, body: json));

    try {
      print("RESPONSE STATUS: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map mapResponse = jsonDecode(response.body);
        Carro carro = Carro.fromMap(mapResponse);
        print("Novo carro: ${carro.id}");
        return ApiResponse.ok();
      }

      if (response.body == null || response.body.isEmpty) {
        return ApiResponse.error(msg: "Não foi possível salva o carro");
      }
    } catch (e) {
      Map mapResponse = jsonDecode(response.body);
      return ApiResponse.error(msg: mapResponse["error"]);
    }
  }

  static Future<ApiResponse<bool>> delete(Carro c) async {
    var url = '$BASE_URL/carros';

    if (c.id != null) {
      url += "/${c.id}";
    }

    print("DELETE > $url");
    String json = c.toJson();

    var response = await http.delete(url);

    try {
      print("RESPONSE STATUS: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      if (response.statusCode == 200) {
        return ApiResponse.ok();
      }
    } catch (e) {
      return ApiResponse.error(msg: "Não foi possível salvar o carro");
    }
  }
}
