import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex/conts/consts_api.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokeapi.dart';
part 'pokiapi_store.g.dart';

class PokeAPIStore = _PokeAPIStoreBase with _$PokeAPIStore;

abstract class _PokeAPIStoreBase with Store {
  @observable
  PokeAPI pokeAPI;

  @action
  fetchPokemonList() {
    pokeAPI = null;
    loadPokeAPI().then((pokeList) {
      pokeAPI = pokeList;
    });
  }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista");
      return null;
    }
  }
}
