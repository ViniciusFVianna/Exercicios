
import 'package:carrosflutter/bloc/base_bloc.dart';
import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/services/carros_api.dart';

class CarrosBloc extends BaseBloc<List<Carro>>{

  fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);
    } catch (ex) {
      addError(ex);
    }
  }

}
