import 'dart:io';

import 'package:chat_app/size.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum userpick { camera, gallery }

class Profilephoto extends StatefulWidget {
  final Function transferfile;
  Profilephoto(this.transferfile);

  @override
  _ProfilephotoState createState() => _ProfilephotoState();
}

class _ProfilephotoState extends State<Profilephoto> {
  File? pickedimage;
  Future<void> upload(userpick picker) async {
    final picking = await ImagePicker().pickImage(imageQuality: 1,maxWidth: 200,
        source: picker == userpick.camera
            ? ImageSource.camera
            : ImageSource.gallery);

    setState(() {
      pickedimage = File(picking!.path);

      Navigator.pop(context);
    });
    widget.transferfile(pickedimage);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        CircleAvatar(
            radius: SizeConfig.width! * 15,
            backgroundImage:
                pickedimage == null ? null : FileImage(pickedimage!)),
        FlatButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Container(
                          width: SizeConfig.width! * 70,
                          height: SizeConfig.height! * 10,
                          child: Row(
                            children: [
                              FlatButton.icon(
                                  onPressed: () {
                                    upload(userpick.camera);
                                  },
                                  icon: Icon(Icons.camera),
                                  label: Text("camera")),
                              SizedBox(
                                width: SizeConfig.width! * 4,
                              ),
                              FlatButton.icon(
                                  onPressed: () {
                                    upload(userpick.gallery);
                                  },
                                  icon: Icon(Icons.photo_album),
                                  label: Text("gallery")),
                            ],
                          ),
                        ),
                      ));
            },
            icon: Icon(Icons.camera),
            label: Text("Upload profile picture")),
      ],
    );
  }
}
