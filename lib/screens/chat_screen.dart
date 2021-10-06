import 'package:chat_app/screens/auth_screens.dart';
import 'package:chat_app/widgets/chats_widget/messagefield.dart';
import 'package:chat_app/widgets/chats_widget/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Chatscreen extends StatefulWidget {
  @override
  _ChatscreenState createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  // @override
  // void initState() {

  //   FirebaseMessaging.instance;
  // }
  @override
  void initState() {
    super.initState();
    final fcm = FirebaseMessaging.instance;
    fcm.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Chat app"),
            actions: [
              PopupMenuButton(
                  onSelected: (val) {
                    if (val == "logout") FirebaseAuth.instance.signOut();
                  },
                  itemBuilder: (ctx) => [
                        PopupMenuItem(
                            value: "logout",
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(Icons.logout),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Logout")
                                ],
                              ),
                            ))
                      ])
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Expanded(child: Messages()), Messagefield()],
          )),
    );
  }
}
