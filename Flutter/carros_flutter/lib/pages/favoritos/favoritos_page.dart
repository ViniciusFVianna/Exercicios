import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/favoritos/favoritos_bloc.dart';
import 'package:carrosflutter/widgets/carros_listview.dart';
import 'package:carrosflutter/widgets/text_error.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context, listen: false);
    favoritosBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
    FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context);
    return StreamBuilder(
      stream: favoritosBloc.stream,
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
    FavoritosBloc favoritosBloc = Provider.of<FavoritosBloc>(context, listen: false);
    return favoritosBloc.fetch();
  }
}