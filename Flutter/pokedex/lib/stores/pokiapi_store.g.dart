// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokiapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeAPIStore on _PokeAPIStoreBase, Store {
  final _$pokeAPIAtom = Atom(name: '_PokeAPIStoreBase.pokeAPI');

  @override
  PokeAPI get pokeAPI {
    _$pokeAPIAtom.context.enforceReadPolicy(_$pokeAPIAtom);
    _$pokeAPIAtom.reportObserved();
    return super.pokeAPI;
  }

  @override
  set pokeAPI(PokeAPI value) {
    _$pokeAPIAtom.context.conditionallyRunInAction(() {
      super.pokeAPI = value;
      _$pokeAPIAtom.reportChanged();
    }, _$pokeAPIAtom, name: '${_$pokeAPIAtom.name}_set');
  }

  final _$_PokeAPIStoreBaseActionController =
      ActionController(name: '_PokeAPIStoreBase');

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeAPIStoreBaseActionController.startAction();
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeAPIStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'pokeAPI: ${pokeAPI.toString()}';
    return '{$string}';
  }
}
