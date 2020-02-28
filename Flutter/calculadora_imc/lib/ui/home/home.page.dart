import 'package:calculadora_imc/blocs/imc.bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
var bloc = new ImcBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo do IMC"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: bloc.heightCtrl,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: bloc.weightCtrl,
              decoration: InputDecoration(
                labelText: "Peso (kg)",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              bloc.result,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                "Calucular",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  bloc.calculate();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
