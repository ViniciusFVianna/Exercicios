import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _itemMenu(title: 'Home', icon: FontAwesomeIcons.home),
        _itemMenu(title: 'Carros', icon: FontAwesomeIcons.car),
        _itemMenu(title: 'Usuários', icon: FontAwesomeIcons.user),
      ],
    );
  }

  _itemMenu({String title, IconData icon}){
    return  Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){},
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
