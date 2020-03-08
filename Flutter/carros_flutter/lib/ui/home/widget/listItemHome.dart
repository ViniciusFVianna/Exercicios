import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ListItemHome extends StatelessWidget {
  final int id;
  final String tipo;
  final String nome;
  final String desc;
  final String urlFoto;

  ListItemHome({
    this.id,
    this.tipo,
    this.nome,
    this.desc,
    this.urlFoto,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(urlFoto == null ? CircularProgressIndicator() : urlFoto),
        backgroundColor: Colors.transparent,
      ),
      title: Text(
        nome,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        nome,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
