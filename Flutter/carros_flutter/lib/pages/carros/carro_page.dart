import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/services/loripsum_api.dart';
import 'package:carrosflutter/widgets/text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loreipsumBloc = LoreipsumBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loreipsumBloc.fetch();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loreipsumBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.carro.nome),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.place),
              onPressed: _onClickMapa,
            ),
            IconButton(
              icon: Icon(Icons.videocam),
              onPressed: _onClickVideo,
            ),
            PopupMenuButton<String>(
                onSelected: (value) => _onClickPopupMenu,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: "Editar",
                      child: Text("Editar"),
                    ),
                    PopupMenuItem(
                      value: "Deletar",
                      child: Text("Deletar"),
                    ),
                    PopupMenuItem(
                      value: "Share",
                      child: Text("Share"),
                    ),
                  ];
                }),
          ],
        ),
        body: _body());
  }

  _onClickVideo() {}

  _onClickMapa() {}

  _onClickPopupMenu(String value) {
    switch (value) {
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
          Image.network(widget.carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, bold: true, fontsize: 20),
            text(widget.carro.tipo, bold: false, fontsize: 16),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.red,
                iconSize: 40,
                onPressed: () {}),
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.grey,
              iconSize: 40,
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        text(widget.carro.descricao, fontsize: 16),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<String>(
            stream: _loreipsumBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return text(
                snapshot.data,
                fontsize: 11,
              );
            }),
      ],
    );
  }
}
