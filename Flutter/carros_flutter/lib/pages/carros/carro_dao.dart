import 'dart:async';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/utils/sql/base_dao.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) {
    return query('select * from carro where tipo =? ', [tipo]);
  }

}
