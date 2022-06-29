import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/pages/home/home_page.dart';
import 'package:carrosflutter/pages/login/login_bloc.dart';
import 'package:carrosflutter/register/regiter_page.dart';
import 'package:carrosflutter/services/api_response.dart';
import 'package:carrosflutter/services/firebase_service.dart';
import 'package:carrosflutter/utils/alert.dart';
import 'package:carrosflutter/utils/finger_print.dart';
import 'package:carrosflutter/utils/firebase.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/widgets/app_button.dart';
import 'package:carrosflutter/widgets/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _tLogin = TextEditingController();
  var _tSenha = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  var _focusSenha = FocusNode();

  final _bloc = LoginBloc();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser fUser;
  var showFrom = false;

  @override
  void initState() {
    super.initState();
    // initFcm();
    FirebaseAuth.instance.currentUser().then((fUser) {
      setState(() {
        this.fUser = fUser;
        if (fUser != null) {
          showFrom = true;
        } else {
          showFrom = false;
        }
      });
    });

    RemoteConfig.instance.then((remoteConfig) {
      remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));

      try {
        remoteConfig.fetch(expiration: const Duration(minutes: 1));
        remoteConfig.activateFetched();
      } catch (error) {
        print("Remote Config: $error");
      }

      final mensagem = remoteConfig.getString("mensagem");
      print('Mensagem: $mensagem');
    });
  }

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
            StreamBuilder<bool>(
                stream: _bloc.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    "Login",
                    onPressed: _onClickLogin,
                    showProgress: snapshot.data,
                  );
                }),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: GoogleSignInButton(
                onPressed: _onClickGoogle,
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                      color: Colors.deepPurple,
                      decoration: TextDecoration.underline,
                      fontSize: 22,
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () => push(context, RegisterPage(), replase: false),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Opacity(
              opacity: fUser != null ? 1 : 0,
              child: Container(
                child: InkWell(
                  child: Icon(
                    Icons.fingerprint,
                    color: Colors.deepPurple,
                    size: 50,
                  ),
                  onTap: () => _onClickFinger(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClickFinger(context) async {
    final ok = await FingerPrint.verify();
    if (ok) {
      push(context, HomePage(), replase: true);
    }
  }

  void _onClickGoogle() async {
    final service = FirebaseService();
    ApiResponse response = await service.loginGoogle();
    if (response.ok) {
      push(context, HomePage(), replase: true);
    } else {
      alert(context, response.msg);
    }
  }

  void _onClickLogin() async {
    bool formOk = _formKey.currentState.validate();
    if (!formOk) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;
    print("login >> $login \nsenha >> $senha");

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;

      print(">> $user");

      push(context, HomePage(), replase: true);
    } else {
      print(response.msg);
      alert(context, response.msg);
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

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
