import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/pages/favoritos/db_helper.dart';
import 'package:carrosflutter/pages/home/home_page.dart';
import 'package:carrosflutter/pages/login/login_page.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 3), () {
    //   push(context, LoginPage());
    // });

    Future futureA = DatabaseHelper.getInstance().db;

    Future futureB = Future.delayed(Duration(seconds: 3));

    Future<Usuario> futureC = Usuario.get();
    // futureUsuario.then((Usuario user) {
    //  if(user != null){
    //    push(context, HomePage(), replase: true);
    //  }
    // });

    Future.wait([futureA, futureB, futureC]).then((List values) {
      Usuario user = values[2];
      if (user != null) {
        push(context, HomePage(), replase: true);
      } else {
        push(context, LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
