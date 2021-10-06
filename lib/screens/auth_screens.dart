import 'dart:io';

import 'package:chat_app/widgets/auth_widget/authwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var isloading = false;
  Future<void> _submitAuthForm(String email, String password, String username,
      bool isLogin, BuildContext ctx, File? image) async {
    final auth = FirebaseAuth.instance;

    try {
      if (isLogin == true) {
        print("mappiy");
        setState(() {
          isloading = !isloading;
        });
        print("logout");
        final userlogindata = await auth.signInWithEmailAndPassword(
            email: email.trim(), password: password.trim());
        //print(userlogindata.user!.email);
      } else {
        setState(() {
          isloading = !isloading;
        });

        final newuserdata = await auth.createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim());

        final Path = await FirebaseStorage.instance
            .ref()
            .child("user_profie_photo")
            .child(newuserdata.user!.uid + ".jpg");
        Path.putFile(image!).then((e) {
          Path.getDownloadURL().then((url) => FirebaseFirestore.instance
                  .collection("users")
                  .doc(newuserdata.user!.uid)
                  .set({
                "username": username,
                "email-id": email,
                "userprofile": url
              }));
        });
      }
    } catch (e) {
      var message = e.toString();
     // print(message);
      setState(() {
        isloading = !isloading;
      });

      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, isloading),
    );
  }
}
