import 'package:flutter/material.dart';

class StoryTile extends StatelessWidget {
  final String imgUrl;
  final String userName;

  StoryTile({@required this.imgUrl, @required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              imgUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            userName,
            style: TextStyle(
                color: Color(0xff78778a),
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
