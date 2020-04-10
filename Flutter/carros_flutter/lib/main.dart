import 'package:carrosflutter/pages/splash/splash_page.dart';
import 'package:carrosflutter/utils/event_bus.dart';
import 'package:carrosflutter/utils/firebase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
runApp(MyApp());
initFcm();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<EventBus>(
          create: (context) => EventBus(),
          dispose: (context, bus) => bus.dispose(),
        ),
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
