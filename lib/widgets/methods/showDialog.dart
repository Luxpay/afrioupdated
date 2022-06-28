
  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showChoiceDialog(BuildContext context, content,title) async {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                title,
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK")),
              ],
              content: Text(content));
        });
  }