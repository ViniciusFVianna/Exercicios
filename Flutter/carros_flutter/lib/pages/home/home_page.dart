import 'package:carrosflutter/pages/carros/carros_page.dart';
import 'package:carrosflutter/services/carros_api.dart';
import 'package:carrosflutter/utils/prefs.dart';
import 'package:carrosflutter/widgets/drawer_list.dart';
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
    // TODO: implement initState
    super.initState();

_initTabs();
  }
  _initTabs() async{
int tabIdx = await Prefs.getInt("tabIdx");

_tabController = TabController(length: 3, vsync: this);

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
        ? null : TabBar(controller: _tabController, tabs: [
          Tab(
            text: "Clássicos",
          ),
          Tab(
            text: "Esportivos",
          ),
          Tab(
            text: "Luxo",
          ),
        ]),
      ),
      drawer: DrawerList(),
      body: _tabController == null ? Center( child: CircularProgressIndicator(),) : TabBarView(controller: _tabController, children: [
        CarrosPage(TipoCarro.classicos),
        CarrosPage(TipoCarro.esportivos),
        CarrosPage(TipoCarro.luxo),
      ]),
    );
  }
}
