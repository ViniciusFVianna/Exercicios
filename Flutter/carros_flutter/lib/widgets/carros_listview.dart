import 'package:cached_network_image/cached_network_image.dart';
import 'package:carrosflutter/models/carro.dart';
import 'package:carrosflutter/pages/carros/carro_page.dart';
import 'package:carrosflutter/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro c = carros[index];

          return Container(
            child: InkWell(
              onTap: () => _onclickCarro(context, c),
              onLongPress: () => _onLongClickCarro(context, c),
              child: Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: c.urlFoto ??
                              "http://www.livroandroid.com.br/livro/carros/classicos/Cadillac_Deville_Convertible.png",
                          width: 250,
                          height: 150,
                        ),
                      ),
                      Text(
                        c.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        c.descricao,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarTheme.of(context),
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DETALHES'),
                              onPressed: () => _onclickCarro(context, c),
                            ),
                            FlatButton(
                              child: const Text('SHARE'),
                              onPressed: () => _onClickShare(context, c),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onclickCarro(context, Carro c) {
    push(context, CarroPage(c));
  }

  _onClickShare(context, Carro c) {
    print("Share > ${c.nome}");
    Share.share(c.urlFoto);
  }

  _onLongClickCarro(context, Carro c) {
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(12),
            child: Text(c.nome, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),),
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("Detalhes"),
            onTap: (){
              pop(context);
              _onclickCarro(context, c);
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text("Share"),
             onTap: (){
              pop(context);
              _onClickShare(context, c);
            },
          ),
        ],
      );
    });
  }
}
