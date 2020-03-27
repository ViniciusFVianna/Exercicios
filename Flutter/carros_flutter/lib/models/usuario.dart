import 'dart:convert';

import 'package:carrosflutter/utils/prefs.dart';

class Usuario {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map) : 
    this.id = map['id'],
    this.login = map['login'],
    this.nome = map['nome'],
    this.email = map['email'],
    this.urlFoto = map['urlFoto'],
    this.token = map['token'],
    this.roles =  map['roles'] != null ? map['roles'].map<String>((role) => role.toString()).toList() : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, token:$token, role: $roles }';
  }

  void save() {
    Map map = toJson();
    String json = jsonEncode(map);
    Prefs.setString('user.prefs', json);

  }  

  static Future<Usuario> get() async {
    String json = await Prefs.getString('user.prefs');
    if(json.isEmpty) { return null; }
    Map map = jsonDecode(json);
    Usuario user = Usuario.fromJson(map);
    return user;
  }

  static void clear() {
    Prefs.setString('user.prefs', '');
  }

}