import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/pages/login/login_page.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var url = 'http://0.gravatar.com/avatar/b5a78dcf43e642a99aed4ec83cfa36aa';

    // Future<Usuario> futureUser = Usuario.get();

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
                // future: futureUser,
                builder: (ctx, snap) {
              Usuario user = snap.data;
              return user != null ? _header(user) : Container();
            }),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("mais informações..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("Item 1");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome),
      accountEmail: Text(user.email),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    // Usuario.clear();
    Navigator.pop(context);
    push(context, LoginPage(), replase: true);
    // Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
}
