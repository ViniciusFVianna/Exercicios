import 'package:flutter/material.dart';

class ChattingTile extends StatelessWidget {
  final bool isByMe;
  final String message;

  ChattingTile({@required this.isByMe, @required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      alignment: isByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isByMe ? Color(0xffff410f) : Color(0xfffff3f1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: isByMe ? Radius.circular(30) : Radius.circular(0),
                bottomRight:
                    isByMe ? Radius.circular(0) : Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 2 / 3),
          child: Text(
            message,
            style: TextStyle(
                color: isByMe ? Colors.white : Color(0xff650000),
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
