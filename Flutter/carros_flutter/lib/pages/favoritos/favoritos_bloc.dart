import 'package:carrosflutter/bloc/base_bloc.dart';
import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carros/carro_dao.dart';
import 'package:carrosflutter/services/carros_api.dart';
import 'package:carrosflutter/services/favorito_service.dart';
import 'package:carrosflutter/utils/netwok.dart';

class FavoritosBloc extends BaseBloc<List<Carro>> {
  Future<List<Carro>> fetch() async {
    try {
      List<Carro> carros = await FavoritoService.getCarros();

      add(carros);
      return carros;
    } catch (ex) {
      addError(ex);
    }
  }
}
