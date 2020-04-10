import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String msg;
  Function onPressed;

  TextError(this.msg, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          this.msg,
          style: TextStyle(
            color: Colors.red,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
