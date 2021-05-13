import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(
      {this.title, this.content, this.callback, this.actionText = 'Reset'});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        content,
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: callback,
          child: Text(
            actionText,
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        )
      ],
    );
  }
}
