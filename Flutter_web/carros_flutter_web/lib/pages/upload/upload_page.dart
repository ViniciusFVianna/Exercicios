import 'dart:async';

import 'package:carrosflutterweb/colors.dart';
import 'package:carrosflutterweb/pages/upload/upload_api.dart';
import 'package:carrosflutterweb/pages/upload/upload_helper.dart';
import 'package:carrosflutterweb/utlis/api_response.dart';
import 'package:carrosflutterweb/web/utils/web.dart';
import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String url;
  bool showProgress = false;

  final uploadHelper = UploadHelper();

  StreamSubscription<UploadState> subscription;

  @override
  void initState() {
    super.initState();

    subscription = uploadHelper.stream.listen((UploadState state){
      _setUploadState(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: RaisedButton(
            color: AppColors.blue,
            child: Text("Upload",style: TextStyle(color: Colors.white),),
            onPressed: _onClickUpload,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: Container(
            color: Colors.grey[100],
            child: Center(
              child: url == null || showProgress
                  ? showProgress
                  ? CircularProgressIndicator()
                  : FlutterLogo(
                size: 100,
              )
                  : InkWell(
                onTap: () {
                  launch(url);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.network(url),
                    Text(url),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onClickUpload() {
    uploadHelper.upload();
  }

  void _setUploadState(UploadState state) {
    if (state.started) {
      print("Upload iniciado...");
      setState(() {
        showProgress = true;
      });
    } else {
      upload(state.fileUpload);
    }
  }

  upload(FileUpload file) async {
    print("Upload: $file");

    ApiResponse<String> response =
    await UploadApi.upload(file.fileName, file.mimeType, file.base64);

    print("Upload fim");

    if (response.ok) {
      String url = response.result;
      print(url);

      setState(() {
        this.url = url;
        this.showProgress = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
    uploadHelper.dispose();
  }
}
