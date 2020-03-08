import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File imagem;
  File imagemTemporaria;

  void pegarImagemGaleria() async {
    imagemTemporaria = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagem = imagemTemporaria;
    });
  }

  void pegarImagemCamera() async {
    imagemTemporaria = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imagem = imagemTemporaria;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: imagem != null
                    ? Image.file(imagem)
                    : Center(
                        child: Text("Selecione uma imagem."),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.camera_alt, size: 50,),
                    onPressed: () {
                      pegarImagemCamera();
                    },
                  ),
                  SizedBox(width: 60,),
                  IconButton(
                    icon: Icon(Icons.image, size: 50,),
                    onPressed: () {
                      pegarImagemGaleria();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
