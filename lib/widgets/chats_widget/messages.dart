import 'package:chat_app/widgets/chats_widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chat")
          .orderBy("created", descending: true)
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final chatdocs = chatsnapshot.data?.docs;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              reverse: true,
              itemCount: chatdocs?.length,
              itemBuilder: (BuildContext context, int i) {
                return Messagebubble(
                  
                    chatdocs?[i]["text"],
                    chatdocs?[i]["uid"] ==
                        FirebaseAuth.instance.currentUser!.uid,
                        
                        chatdocs?[i]["username"],
                        chatdocs?[i]["userprofile"]);
              },
            ),
          );
        }
      },
    );
  }
}
