import 'package:carrosflutter/models/carro.dart';
import 'package:flutter/material.dart';

class MapaPage extends StatelessWidget {
Carro carro;
MapaPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: Text(carro.nome),
    ),
    body: Container()
    );
  }
}