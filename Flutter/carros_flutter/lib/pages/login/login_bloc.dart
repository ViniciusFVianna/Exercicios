import 'dart:async';

import 'package:carrosflutter/bloc/base_bloc.dart';
import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/services/api_response.dart';
import 'package:carrosflutter/services/firebase_service.dart';
import 'package:carrosflutter/services/login_api.dart';

class LoginBloc extends BaseBloc<bool> {
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);
    // ApiResponse response = await LoginApi.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha);
    add(false);
    return response;
  }
}
