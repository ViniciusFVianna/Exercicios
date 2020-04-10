import 'package:carrosflutter/pages/carros/carro_form_page.dart';
import 'package:carrosflutter/pages/carros/carros_page.dart';
import 'package:carrosflutter/pages/favoritos/favoritos_page.dart';
import 'package:carrosflutter/services/carros_api.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:carrosflutter/utils/prefs.dart';
import 'package:carrosflutter/widgets/drawer_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    int tabIdx = await Prefs.getInt("tabIdx");

    _tabController = TabController(length: 4, vsync: this);

    setState(() {
      _tabController.index = tabIdx;
    });

    _tabController.addListener(() {
      print("Tab >> ${_tabController.index}");
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: _tabController == null
            ? null
            : TabBar(controller: _tabController, tabs: [
                Tab(
                  text: "Clássicos",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Esportivos",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Luxo",
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: "Favoritos",
                  icon: Icon(Icons.favorite),
                ),
              ]),
      ),
      drawer: DrawerList(),
      body: _tabController == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(controller: _tabController, children: [
              CarrosPage(TipoCarro.classicos),
              CarrosPage(TipoCarro.esportivos),
              CarrosPage(TipoCarro.luxo),
              FavoritosPage(),
            ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _onClickAdicionarCarro,
      ),
    );
  }

  void _onClickAdicionarCarro() {
    push(context, CarroFormPage(), replase: false);
  }
}
