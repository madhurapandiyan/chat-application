import 'package:chat_app/size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Messagefield extends StatefulWidget {
  @override
  _MessagefieldState createState() => _MessagefieldState();
}

class _MessagefieldState extends State<Messagefield> {
  var editedtext = "";
  var text = TextEditingController();
  Future<void> sentmsg() async {
    FocusScope.of(context).unfocus();
    final username = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // print(username.data());
    //print("123");
    
    FirebaseFirestore.instance.collection("chat").add({
      "text": editedtext,
      "created": Timestamp.now(),
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "username": username["username"],
      "userprofile": username["userprofile"]
    });
    text.clear();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: SizeConfig.width! * 70,
            height: SizeConfig.height! * 5,
            child: TextField(
              onSubmitted: (value) {
                if (value.isEmpty) {
                  return;
                }
                sentmsg();
              },
              controller: text,
              decoration: InputDecoration(
                  hintText: "send a message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
              onChanged: (value) {
                setState(() {
                  editedtext = value;
                });
              },
            ),
          ),
          SizedBox(
            width: SizeConfig.width! * 3,
          ),
          IconButton(
              onPressed: editedtext.trim().isEmpty ? null : sentmsg,
              icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
