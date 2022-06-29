import 'dart:async';
import 'dart:io';

import 'package:carrosflutter/models/usuario.dart';
import 'package:carrosflutter/services/api_response.dart';
import 'package:carrosflutter/services/favorito_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:path/path.dart' as path;

String firebaseUserUid;

class FirebaseService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse> login(String email, String senha) async {
    try {
      // Login no Firebase
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      // Cria um usuario do app
      final user = Usuario(
        nome: fUser.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: fUser.photoUrl,
      );
      user.save();

      // Salva no Firestore
      saveUser(fUser);

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  Future<ApiResponse> loginGoogle() async {
    try {
      // Login com o Google
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google User: ${googleUser.email}");

      // Credenciais para o Firebase
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Login no Firebase
      AuthResult result = await _auth.signInWithCredential(credential);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      // Cria um usuario do app
      final user = Usuario(
        nome: fUser.displayName,
        login: fUser.email,
        email: fUser.email,
        urlFoto: fUser.photoUrl,
      );
      user.save();

      // Salva no Firestore
      saveUser(fUser);

      // Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print("Firebase error $error");
      return ApiResponse.error(msg: "Não foi possível fazer o login");
    }
  }

  // salva o usuario na collection de usuarios logados
  void saveUser(FirebaseUser fUser) async {
    if (fUser != null) {
      firebaseUserUid = fUser.uid;
      DocumentReference refUser =
          Firestore.instance.collection("users").document(firebaseUserUid);
      refUser.setData({
        'nome': fUser.displayName,
        'email': fUser.email,
        'login': fUser.email,
        'urlFoto': fUser.photoUrl,
      });
    }
  }

  Future<ApiResponse> cadastrar(String nome, String email, String senha, {File file}) async {
    try {
      // Usuario do Firebase
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      final FirebaseUser fUser = result.user;
      print("Firebase Nome: ${fUser.displayName}");
      print("Firebase Email: ${fUser.email}");
      print("Firebase Foto: ${fUser.photoUrl}");

      // Dados para atualizar o usuário
      final userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nome;

      if(file != null){
        String photoUrl = await FirebaseService.uploadFirebaseStorage(file);
        userUpdateInfo.photoUrl = photoUrl;
        print("Foto Url: ${photoUrl}");
        print("Foto: ${userUpdateInfo.photoUrl}");
      }else{
      userUpdateInfo.photoUrl = "https://s3-sa-east-1.amazonaws.com/livetouch-temp/livrows/foto.png";
       print("else Foto: ${userUpdateInfo.photoUrl}");
    }
      fUser.updateProfile(userUpdateInfo);

      // Resposta genérica
      return ApiResponse.ok(msg: "Usuário criado com sucesso");
    } catch (error) {
      print(error);

      if (error is PlatformException) {
        print("Error Code ${error.code}");

        return ApiResponse.error(
            msg: "Erro ao criar um usuário.\n\n${error.message}");
      }

      return ApiResponse.error(msg: "Não foi possível criar um usuário.");
    }
  }

  static Future<String> uploadFirebaseStorage(File file) async {
    print("Upload to Storage $file");
    String fileName = path.basename(file.path);
    final storageRef = FirebaseStorage.instance.ref().child(fileName);

    final StorageTaskSnapshot task = await storageRef.putFile(file).onComplete;
    final String urlFoto = await task.ref.getDownloadURL();
    print("Storage > $urlFoto");
    return urlFoto;
  }

  Future<void> logout() async {
    await FavoritoService().deleteCarros();

    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}