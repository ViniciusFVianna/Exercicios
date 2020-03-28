import 'dart:async';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carros/carro_page.dart';
import 'package:carrosflutter/pages/carros/carros_bloc.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/widgets/carros_listview.dart';
import 'package:carrosflutter/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
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
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros));
      },
    );
  }
  
  Future<void> _onRefresh(){
    return _bloc.fetch(tipo);
  }
}
