import 'package:carrosflutter/bloc/base_bloc.dart';
import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> getLoripsum() async {
    var url = 'https://loripsum.net/api';

    print("GET > $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }
}

class LoreipsumBloc extends BaseBloc<String>{

  static String lorim;

  fetch() async{
    String s = lorim ?? await LoripsumApi.getLoripsum();

    lorim = s;
    add(s);
  }
}
