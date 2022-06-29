import 'package:flutter/material.dart';
import 'package:messages/data/data.dart';
import 'package:messages/models/message_model.dart';
import 'package:messages/widgets/chatting_tile.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<MessageModel> messages = List();

  @override
  void initState() {
    super.initState();
    messages = getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      bottomSheet: _formText(),
    );
  }

  _body(){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 90,),
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 14,),
          Text(
            "Sanskar Tiwari",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 4,
          ),
          Text("5 minutes ago"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChattingTile(
                    isByMe: messages[index].isByme,
                    message: messages[index].message,
                  );
                }),
          ),
        ],
      ),
    );
  }

  _formText(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            color: Color(0xffF4F5FA),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xffe7e7ef),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.asset(
                "assets/images/more.png",
                width: 30,
                height: 30,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration.collapsed(
                    hintText: "Aa",
                    hintStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Color(0xffe7e7ef),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Image.asset(
                "assets/images/smile.png",
                width: 30,
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
