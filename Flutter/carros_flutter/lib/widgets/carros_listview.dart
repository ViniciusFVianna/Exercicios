import 'dart:async';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carro/carro_page.dart';
import 'package:carrosflutter/pages/carro/carros_bloc.dart';
import 'package:carrosflutter/services/carros_api.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosListView extends StatefulWidget {
  String tipo;

  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView>
    with AutomaticKeepAliveClientMixin<CarrosListView> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  List<Carro> carros;
  String get tipo => widget.tipo;
  final _bloc = CarrosBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch(tipo);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  void _fetch() {
    _bloc.fetch(tipo);
  }

  _body() {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(
            "Não foi possível buscar os caros \n\n Clique para tentar novamente",
            onPressed: _fetch,
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      c.urlFoto ??
                          "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    c.descricao,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: ButtonBarTheme.of(context),
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onclickCarro(c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onclickCarro(Carro c) {
    push(context, CarroPage(c));
  }
}
