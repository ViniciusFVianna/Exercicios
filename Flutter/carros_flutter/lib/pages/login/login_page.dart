import 'package:carrosflutter/pages/home/home_page.dart';
import 'package:carrosflutter/pages/login/login_api.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/widgets/app_button.dart';
import 'package:carrosflutter/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _tLogin = TextEditingController();
  var _tSenha = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Carros"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            AppText(
              "Login",
              "Digite o login",
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "senha",
              "Digite a senha",
              obscure: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton(
              "Login",
              onPressed: _onClickLogin,
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogin() async{
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;
    print("login >> $login \nsenha >> $senha");

   bool ok = await LoginApi.login(login, senha);
   if(ok){
     push(context, HomePage());
   }else{
     print("Login incorreto");
   }
  }

  String _validateLogin(String value) {
    if (value.isEmpty) {
      return "Inform o login.";
    }
    return null;
  }

  String _validateSenha(String value) {
    if (value.isEmpty) {
      return "Informe a senha.";
    }
    if (value.length < 3) {
      return "A senha deve ser maior de 3 digitos.";
    }
    return null;
  }
}
