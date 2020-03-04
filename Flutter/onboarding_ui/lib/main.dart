import 'package:flutter/material.dart';
import 'package:onboarding_ui/ui/onboarding/onboarding.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Onboarding UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Onboarding(),
    );
  }
}