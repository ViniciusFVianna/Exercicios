import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carros/carro_form_page.dart';
import 'package:carrosflutter/services/favorito_service.dart';
import 'package:carrosflutter/services/loripsum_api.dart';
import 'package:carrosflutter/utils/nav.dart';
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

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();
    _loreipsumBloc.fetch();
    FavoritoService.isFavorito(carro).then((favorito){
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });
  }

  @override
  void dispose() {
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
                onSelected: _onClickPopupMenu,
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

  _onclickFavorito() async {
    bool favorito = await FavoritoService.favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  _onClickPopupMenu(String value) {
    switch (value) {
      case "Editar":
        push(context, CarroFormPage(carro: carro));
        break;
      case "Deletar":
        print("Deletar!!!");
        break;
      case "Share":
        print("Share!!!");
        break;
    }
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto,
          ),
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
                color: color,
                iconSize: 40,
                onPressed: () => _onclickFavorito()),
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
