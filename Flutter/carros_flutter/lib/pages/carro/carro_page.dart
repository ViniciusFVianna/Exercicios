import 'package:carrosflutter/models/carro.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatelessWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(carro.nome),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.place), onPressed: _onClickMapa,),
            IconButton(icon: Icon(Icons.videocam), onPressed: _onClickVideo,),
            PopupMenuButton<String>(
              onSelected: (value) => _onClickPopupMenu,
              itemBuilder: (context){
              return [
                PopupMenuItem(value: "Editar",child: Text("Editar"),),
                PopupMenuItem(value: "Deletar",child: Text("Deletar"),),
                PopupMenuItem(value: "Share",child: Text("Share"),),
              ];
            }),
          ],
        ),
        body: _body());
  }

  _onClickVideo(){}

  _onClickMapa(){}

  _onClickPopupMenu(String value){
    switch(value){
      case "Editar":
      break;
      case "Deletar":
      break;
      case "Share":
      break;
    }
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Image.network(carro.urlFoto),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(carro.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
              Text(carro.tipo, style: TextStyle(fontSize: 16,),),
            ],),
            Row(
              children: <Widget>[
              IconButton(icon: Icon(Icons.favorite), color: Colors.red, iconSize: 40, onPressed: (){}),
              IconButton(icon: Icon(Icons.share), color: Colors.grey, iconSize: 40, onPressed: (){},)
            ],),
          ],),
        ],
      ),
    );
  }
}
