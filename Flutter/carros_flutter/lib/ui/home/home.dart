import 'package:carros_flutter/constans/constantApp.dart';
import 'package:carros_flutter/models/carros.dart';
import 'package:carros_flutter/ui/home/widget/listItemHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final id = 1;
  final tipo = "classicos";
  final nome = "Tucker 1948";
  final desc = "Descrição Tucker 1948";
  final urlFoto =
      "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
      ),
      body: ListView(
        children: <Widget>[
          ListItemHome(
            id: id,
            tipo: tipo,
            desc: desc,
            nome: nome,
            urlFoto: urlFoto,
          ),
          
        ],
      ),
    );
  }
}
