import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carrosflutter/services/api_response.dart';
import 'package:carrosflutter/utils/carros_contants.dart';
import 'package:carrosflutter/utils/http_helper.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart' as path;

class UploadService {
  static Future<ApiResponse<String>> upload(File file) async {
    try {
      String url = "$BASE_URL/upload";

      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      String fileName = path.basename(file.path);

      var params = {
        "fileName": fileName,
        "mimeType": "image/jpeg",
        "base64": base64Image
      };

      String json = jsonEncode(params);

      print("http.upload: " + url);
      print("params: " + json);

      final response = await http
          .post(
            url,
            body: jsonEncode(params),
          )
          .timeout(
            Duration(seconds: 120),
            onTimeout: _onTimeOut,
          );

      print("http.upload << " + response.body);

      Map<String, dynamic> map = jsonDecode(response.body);

      String urlFoto = map["url"];

      return ApiResponse.ok(result: urlFoto);
    } catch (error, exception) {
      print("Erro ao fazer upload $error - $exception");
      return ApiResponse.error(msg: "Não foi possível fazer o upload");
    }
  }

  static FutureOr<Response> _onTimeOut() {
    print("timeout!");
    throw SocketException("Não foi possível se comunicar com o servidor.");
  }
}