import 'package:carrosflutter/pages/splash/splash_page.dart';
import 'package:carrosflutter/utils/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/favoritos/favoritos_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          create: (context) => EventBus(),
          dispose: (context, bus) => bus.dispose(),
        ),
        Provider<FavoritosBloc>(
          create: (context) => FavoritosBloc(),
          dispose: (context, bloc) => bloc.dispose(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(),
      ),
    );
  }
}
