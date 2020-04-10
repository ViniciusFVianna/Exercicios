import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carros/carro_form_page.dart';
import 'package:carrosflutter/pages/video_page.dart';
import 'package:carrosflutter/services/api_response.dart';
import 'package:carrosflutter/services/carros_api.dart';
import 'package:carrosflutter/services/favorito_service.dart';
import 'package:carrosflutter/services/loripsum_api.dart';
import 'package:carrosflutter/utils/alert.dart';
import 'package:carrosflutter/utils/event_bus.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    FavoritoService.isFavorito(carro).then((favorito) {
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
              onPressed: () {_onClickVideo(context);},
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

  _onClickVideo(context) {
    if (carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
      // launch(carro.urlVideo);
      push(context, VideoPage(carro));
    } else {
      alert(
        context,
        "Este carro não possiu nenhum vídeo",
        title: "Erro",
      );
    }
  }

  _onClickMapa() {}

  _onclickFavorito() async {
    bool favorito = await FavoritoService.favoritar(context, carro);

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
        _deletar();
        break;
      case "Share":
        print("Share!!!");
        break;
    }
  }

  void _deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);
    if (response.ok) {
      alert(context, "Carro excluído com sucesso!", callback: () {
        EventBus.get(context)
            .sendEvent(CarroEvent("carro_deletado", carro.tipo));
        pop(context);
      });
    }
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            height: 150,
            imageUrl: widget.carro.urlFoto ??
                "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png",
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
