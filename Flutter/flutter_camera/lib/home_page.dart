import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/upload_service.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File imagem;
  File imagemTemporaria;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.file_upload, color: Colors.white,), onPressed: _onClickUpload)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Tire uma foto",
              style: TextStyle(fontSize: 25),
            ),
             SizedBox(
              height: 20,
            ),
            imagem != null ? Image.file(imagem, height: 250,) : Image.asset(
              "assets/images/camera.png",
              width: 150,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Camera",
        child: Icon(Icons.camera),
        onPressed: pegarImagemCamera,
      ),
    );
  }

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

  void _onClickUpload(){
    if(imagem != null){
      UploadService.upload(imagem);
    }
  }

}
