import 'package:carrosflutter/bloc/base_bloc.dart';
import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carros/carro_dao.dart';
import 'package:carrosflutter/services/carros_api.dart';
import 'package:carrosflutter/utils/netwok.dart';

class CarrosBloc extends BaseBloc<List<Carro>> {
  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool networkON = await isNetworkOn();

      if (!networkON) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);

      if (carros.isNotEmpty) {
        final dao = CarroDAO();
        carros.forEach(dao.save);
      }

      add(carros);
      return carros;
    } catch (ex) {
      addError(ex);
    }
  }
}
