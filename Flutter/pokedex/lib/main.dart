import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/stores/pokiapi_store.dart';
import 'package:pokedex/ui/home/home.page.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<PokeAPIStore>(PokeAPIStore());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      );
  }
}
