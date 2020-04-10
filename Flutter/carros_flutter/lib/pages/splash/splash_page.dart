import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/pages/home/home_page.dart';
import 'package:carrosflutter/pages/login/login_page.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/utils/sql/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future futureA = DatabaseHelper.getInstance().db;
    Future futureB = Future.delayed(Duration(seconds: 3));

    Future<FirebaseUser> futureC = FirebaseAuth.instance.currentUser();

    Future.wait([futureA, futureB, futureC]).then((List values) {
      FirebaseUser fUser = values[2];
      if (fUser != null) {
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
