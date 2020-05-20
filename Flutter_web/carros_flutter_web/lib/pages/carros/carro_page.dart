import 'package:carrosflutterweb/app_model.dart';
import 'package:carrosflutterweb/pages/carros/carro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CarroPage extends StatefulWidget {

  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
            ),
            child: Image.network(
              widget.carro.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png",
            ),
          ),
          Text(
            widget.carro.nome ?? '',
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

   _onClickVoltar() {
     AppModel app = Provider.of<AppModel>(context, listen: false);
     app.pop();
  }
}
