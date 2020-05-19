import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context,
        FadeRoute(builder: (BuildContext context) {
          return page;
        }));
  }

   pop<T extends Object>(BuildContext context, [T result]) {
    return Navigator.pop(context);
  }

  return Navigator.push(context, FadeRoute(builder: (BuildContext context) {
    return page;
  }));
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
//    if (settings.isInitialRoute) {
//      return child;
//    }
    return FadeTransition(opacity: animation, child: child);
  }
}