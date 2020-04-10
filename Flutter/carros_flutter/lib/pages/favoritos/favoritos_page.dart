import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/services/favorito_service.dart';
import 'package:carrosflutter/widgets/carros_listview.dart';
import 'package:carrosflutter/widgets/text_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritosPage extends StatefulWidget {
  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage>
    with AutomaticKeepAliveClientMixin<FavoritosPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _body();
  }

  _body() {
     return StreamBuilder<QuerySnapshot>(
     stream: FavoritoService().stream,
     builder: (context, snapshot) {
       if(snapshot.hasError){
         return TextError("Não foi possível buscar os carros");
       }
         if(!snapshot.hasData){
         return Center(child: CircularProgressIndicator(),);
         }

         List<Carro> carros = snapshot.data.documents.map((DocumentSnapshot document) {
               return Carro.fromMap(document.data);
              }).toList();
         return CarrosListView(carros);
       }
     );
  }
}