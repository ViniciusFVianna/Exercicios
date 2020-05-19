import 'package:flutter/material.dart';
import 'package:messages/data/data.dart';
import 'package:messages/models/chat_model.dart';
import 'package:messages/models/story_model.dart';
import 'package:messages/pages/chat/chat_page.dart';
import 'package:messages/widgets/chat_tile.dart';
import 'package:messages/widgets/story_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StoryModel> stories = List();
  List<ChatModel> chats = List();

  @override
  void initState() {
    super.initState();

    stories = getStories();
    chats = getChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171719),
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 70),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: <Widget>[
                  Text(
                    'Messages',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Color(0xff444446),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            //stories
            SizedBox(
              height: 50,
            ),
            _stories(),
            //chats
            _listChat(),
          ],
        ),
      ),
    );
  }

  _stories() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      height: 120,
      child: ListView.builder(
        itemCount: stories.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return StoryTile(
            imgUrl: stories[index].imgUrl,
            userName: stories[index].username,
          );
        },
      ),
    );
  }

  _listChat() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: <Widget>[
                Text(
                  'Recent',
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Icon(
                  Icons.more_vert,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
          ListView.builder(
              itemCount: chats.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return ChatTile(
                  imgUrl: chats[index].imgUrl,
                  name: chats[index].name,
                  lastMessage: chats[index].lastMessage,
                  haveunreadmessages: chats[index].haveunreadmessages,
                  unreadmessages: chats[index].unreadmessages,
                  lastSeenTime: chats[index].lastSeenTime,
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPage())),
                );
              }),
        ],
      ),
    );
  }
}
