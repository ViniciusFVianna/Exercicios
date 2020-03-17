import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  User({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory User.createUser(Map<String, dynamic> object) {
    return User(
        id: object["id"].toString(),
        email: object["email"],
        firstName: object["firstName"],
        lastName: object["lastName"],
        avatar: object["avatar"]);
  }

  static Future<User> getFromAPI(int id) async {
    String apiURL = "https://reques.in/api/users" + id.toString();

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];

    return User.createUser(userData);
  }
}

class UninitializedUser extends User{}