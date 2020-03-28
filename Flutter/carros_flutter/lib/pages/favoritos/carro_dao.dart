import 'dart:async';

import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/favoritos/base_dao.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tablename => "carro";

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from carro where tipo =? ', [tipo]);

    return list.map<Carro>((json) => fromMap(json)).toList();
  }
}
