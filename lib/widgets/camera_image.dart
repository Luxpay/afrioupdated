import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/widgets/touchUp.dart';

class CameraWidget extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return CameraWidgetState();
  }
}

class CameraWidgetState extends State {
  PickedFile? imageFile = null;

  Future<void> _showChoiceDialog(BuildContext context) async {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Choose option",
                style: TextStyle(color: Colors.red),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                    ListTile(
                      onTap: () {
                        _openGallery(context);
                      },
                      title: Text("Gallery"),
                      leading: Icon(
                        Icons.account_box,
                        color: Colors.red,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                    ListTile(
                      onTap: () {
                        _openCamera(context);
                      },
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Choose option",
                style: TextStyle(color: Colors.red),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                    ListTile(
                      onTap: () {
                        _openGallery(context);
                      },
                      title: Text("Gallery"),
                      leading: Icon(
                        Icons.account_box,
                        color: Colors.red,
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                    ListTile(
                      onTap: () {
                        _openCamera(context);
                      },
                      title: Text("Camera"),
                      leading: Icon(
                        Icons.camera_alt,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final color = Colors.blue;
    return Container(
        child: Stack(
      children: [
        Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              color: grey4,
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(300.0),
              child: imageFile == null
                  ? Icon(Icons.person,size: 100,color: grey2,)
                  : Image.file(
                      File(imageFile!.path),
                      fit: BoxFit.cover,
                    ),
            )),
        Positioned(
          bottom: 0,
          right: 4,
          child: InkWell(
              onTap: () {
                _showChoiceDialog(context);
              },
              child: buildEditIcon(color)),
        ),
      ],
    ));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  void _openGallery(BuildContext context) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }
}
