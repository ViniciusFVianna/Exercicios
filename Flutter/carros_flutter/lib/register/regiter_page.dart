import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrosflutter/pages/home/home_page.dart';
import 'package:carrosflutter/pages/login/login_page.dart';
import 'package:carrosflutter/services/firebase_service.dart';
import 'package:carrosflutter/utils/alert.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/widgets/app_button.dart';
import 'package:carrosflutter/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _tNome = TextEditingController();
  final _tEmail = TextEditingController();
  final _tSenha = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _progress = false;
  File _image;
  File _imaeTemp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cadastro"),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20,),
            _headerFoto(),
            SizedBox(height: 20,),
            AppText(
              "Nome",
              "Digite o seu nome",
              controller: _tNome,
              validator: _validateNome,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20,),
            AppText(
              "Email", 
              "Digite o seu email",
              controller: _tEmail,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20,),
              AppText(
                "Senha",
                 "Digite a sua senha",
                 controller: _tSenha,
                 validator: _validateSenha,
                 keyboardType: TextInputType.number,
                 obscure: true,
                 ),
                 SizedBox(height: 20,),
                 AppButton(
                   "Cadastrar",
                   showProgress: _progress,
                   onPressed: (){_onClickCadastrar(context);},
                 ),
                 SizedBox(height: 20,),
                 AppButton(
                   "Cancelar",
                   showProgress: false,
                   onPressed: () => _onClickCancelar(context),
                 )
          ],
        ),
      ),
    );
  }

_headerFoto() {
    return InkWell(
      onTap: _onClickCamera,
      child: _image != null
          ? Image.file(
              _image,
              height: 150,
            )
          : _image != null
              ? CachedNetworkImage(
                  imageUrl: _image.path,
                  height: 150,
                )
              : Image.asset(
                  "assets/images/camera.png",
                  height: 150,
                ),
    );
  }

  void _onClickCamera() async {
    _imaeTemp = await ImagePicker.pickImage(source: ImageSource.camera);
    print("File > $_imaeTemp");
    setState(() {
      _image = _imaeTemp;
    });
  }


   String _validateNome(String text) {
    if (text.isEmpty) {
      return "Informe o nome";
    }

    return null;
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Informe o email";
    }

    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Informe a senha";
    }
    if (text.length <= 2) {
      return "Senha precisa ter mais de 2 números";
    }

    return null;
  }

  _onClickCancelar(context) {
    push(context,LoginPage(), replase: true);
  }

_onClickCadastrar(context) async {
    print("Cadastrar!");

    String nome = _tNome.text;
    String email = _tEmail.text;
    String senha = _tSenha.text;

    print("Nome : $nome, \nEmail : $email, \nSenha : $senha \nFoto : $_image");

    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _progress = true;
    });

    final service = FirebaseService();
    final response = await service.cadastrar(nome, email, senha, file: _image);

    if (response.ok) {
      push(context, HomePage(),replase:true);
    } else {
      alert(context, response.msg);
    }

    setState(() {
      _progress = false;
    });
  }

}
