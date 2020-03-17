import 'dart:convert';

import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/services/api_response.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    var url = "https://carros-springboot.herokuapp.com/api/v2/login";

    final params = {
      'username': login,
      'password': senha,
    };

    final headers = {
      "Content-Type" : "application/json",
    };


    try {
      var response = await http.post(url, body: jsonEncode(params), headers: headers);

      final dados = jsonDecode(response.body);

      if(response.statusCode == 200){
        final user = Usuario.fromJson(dados);
        return ApiResponse.ok(user);
      } else {
        return ApiResponse.error(response.statusCode, dados['error']);
      }

    } catch (error, exception){
      print('Erro na chamada login $error > $exception');
      return(ApiResponse.error(-1, 'Erro na chamada login'));

    }
  }
}
