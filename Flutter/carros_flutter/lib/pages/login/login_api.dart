import 'package:http/http.dart' as http;

class LoginApi {
  static Future<bool> login(String login, String senha) async {
    var url = "http://livrowebservices.com.br/rest/login";

    final params = {
      'login': login,
      'senha': senha,
    };

    var response = await http.post(url, body: params);
    print(response.body);

    return true;
  }
}