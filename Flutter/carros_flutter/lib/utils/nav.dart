import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {replase = false}) {
  if (replase == true) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  } else {
    return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}

bool pop<T extends Object>(BuildContext context, [T result]){
  return Navigator.pop(context);
}
