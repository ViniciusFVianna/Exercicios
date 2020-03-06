// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokiapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeAPIStore on _PokeAPIStoreBase, Store {
  Computed<PokeAPI> _$pokeAPIComputed;

  @override
  PokeAPI get pokeAPI =>
      (_$pokeAPIComputed ??= Computed<PokeAPI>(() => super.pokeAPI)).value;

  final _$_pokeAPIAtom = Atom(name: '_PokeAPIStoreBase._pokeAPI');

  @override
  PokeAPI get _pokeAPI {
    _$_pokeAPIAtom.context.enforceReadPolicy(_$_pokeAPIAtom);
    _$_pokeAPIAtom.reportObserved();
    return super._pokeAPI;
  }

  @override
  set _pokeAPI(PokeAPI value) {
    _$_pokeAPIAtom.context.conditionallyRunInAction(() {
      super._pokeAPI = value;
      _$_pokeAPIAtom.reportChanged();
    }, _$_pokeAPIAtom, name: '${_$_pokeAPIAtom.name}_set');
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
  dynamic getPokemon(int index) {
    final _$actionInfo = _$_PokeAPIStoreBaseActionController.startAction();
    try {
      return super.getPokemon(index);
    } finally {
      _$_PokeAPIStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({String numero}) {
    final _$actionInfo = _$_PokeAPIStoreBaseActionController.startAction();
    try {
      return super.getImage(numero: numero);
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
