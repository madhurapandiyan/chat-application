import 'package:chat_app/size.dart';
import 'package:flutter/material.dart';

class Messagebubble extends StatelessWidget {
  final String message;
  final bool isme;
  final String username;
  final String imageurl;

  Messagebubble(this.message, this.isme, this.username, this.imageurl);
  @override
  Widget build(BuildContext context) {
    print(isme);
    SizeConfig().init(context);
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: isme ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          //padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          width: SizeConfig.width! * 50,
          height: SizeConfig.height! * 7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: isme ? Radius.circular(30) : Radius.circular(0),
                  bottomRight: isme ? Radius.circular(0) : Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30)),
              color: isme ? Colors.redAccent[400] : theme.accentColor),
          child: Column(
            children: [
             
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  username,
                  style:
                      TextStyle(color: theme.accentTextTheme.bodyText1!.color),
                  textAlign: isme ? TextAlign.right : TextAlign.left,
                ),
              ),
              Text(
                message,
                style: TextStyle(color: theme.accentTextTheme.bodyText1!.color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
