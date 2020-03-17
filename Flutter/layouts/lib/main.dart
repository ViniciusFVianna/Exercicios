import 'package:flutter/material.dart';

import 'ui/login/login2.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'Layouts',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginPage2(),
    );
  }
}