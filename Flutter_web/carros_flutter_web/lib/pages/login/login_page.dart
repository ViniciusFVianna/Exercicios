import 'package:carrosflutterweb/colors.dart';
import 'package:carrosflutterweb/pages/login/login_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/images/favo.png', fit: BoxFit.fill, width: double.infinity,),
        ),
        Center(
          child: Container(
            width: 460,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.cinza_606060,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  height: 76,
                  child: Center(
                    child: Text(
                      "Carros",
                      style: TextStyle(color: Colors.white,fontSize: 22),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
