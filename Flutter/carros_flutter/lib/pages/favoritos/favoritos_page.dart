import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/favoritos/favoritos_bloc.dart';
import 'package:carrosflutter/widgets/carros_listview.dart';
import 'package:carrosflutter/widgets/text_error.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  final _bloc = FavoritosBloc();

  @override
  void initState() {
    super.initState();
    _bloc.fetch();
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

  _body() {
    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError(
            "Não foi possível buscar os caros",
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
    return _bloc.fetch();
  }
}