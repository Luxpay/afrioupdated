import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/lux_tag.dart';

import 'package:luxpay/views/page_controller.dart';
import 'package:luxpay/widgets/camera_image.dart';

import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

import 'package:dio/dio.dart';

import '../../models/error.dart';
import '../../networking/dio.dart';
import '../../utils/colors.dart';
import '../../utils/validators.dart';

class CreateNewPassword2Profile extends StatefulWidget {
  const CreateNewPassword2Profile({Key? key}) : super(key: key);

  @override
  State<CreateNewPassword2Profile> createState() =>
      _CreateNewPassword2ProfileState();
}

class _CreateNewPassword2ProfileState extends State<CreateNewPassword2Profile> {
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerOtherName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLuxtag = TextEditingController();
  bool _isLoading = false;
  PickedFile? imageFile = null;
  String? errors;

  @override
  Widget build(BuildContext context) {
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

    final color = Colors.blue;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
              //margin: EdgeInsets.only(left: 30, right: 30),
              width: double.infinity,
              height: MediaQuery.of(context).size.height + 200,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: HexColor("#333333").withOpacity(0.3),
                          width: 0.5,
                        ),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => {Navigator.maybePop(context)},
                              icon: const Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 18,
                          ),
                          const Text(
                            "Verify your Account",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        margin: EdgeInsets.only(top: 100, left: 30, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("STEP 2 OF 2",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w100)),
                            SizedBox(height: 20),
                            Text(
                              "Provide Prosenal Details",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 15),
                            Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                          "We will require a few details about you to set up your Luxpay account")),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 220, left: 30, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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
                                        ? Icon(
                                            Icons.person,
                                            size: 100,
                                            color: grey2,
                                          )
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
                          )),
                          SizedBox(height: 1),
                          InkWell(
                              onTap: () {},
                              child: Text(
                                "Tap to take a selfie",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w100),
                              )),
                          LuxTextField(
                            hint: "First Name",
                            controller: controllerFirstName,
                            innerHint: "eg john",
                          ),
                          SizedBox(height: 15),
                          LuxTextField(
                            hint: "Lsat Name",
                            controller: controllerLastName,
                            innerHint: "eg blak",
                          ),
                          SizedBox(height: 15),
                          LuxTextField(
                            hint: "Other Name",
                            controller: controllerOtherName,
                            innerHint: "eg smith",
                          ),
                          SizedBox(height: 15),
                          LuxTextField(
                            hint: "Email Address",
                            controller: controllerEmail,
                            innerHint: "eg johnson@gmail.com",
                          ),
                          SizedBox(height: 15),
                          Container(
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  margin: EdgeInsets.only(left: 90),
                                  child: InkWell(
                                    onTap: () {
                                      _luxTagBottomSheet(context);
                                    },
                                    child: Image.asset(
                                      "assets/exclamation.png",
                                    ),
                                  ),
                                ),
                              ),
                              LuxTextField(
                                hint: "Luxpay Tag",
                                controller: controllerLuxtag,
                                innerHint: "@johnson",
                              ),
                            ]),
                          ),
                          SizedBox(height: 50),
                          InkWell(
                              onTap: () async {
                                var firstname = controllerFirstName.text.trim();
                                var lastname = controllerLastName.text.trim();
                                var othername = controllerOtherName.text.trim();
                                var email = controllerEmail.text.trim();
                                var username = controllerLuxtag.text.trim();
                                //var lastname = controllerLastName.text.trim();

                                var validators = [
                                  Validators.isValidEmail(email),
                                  firstname.isEmpty
                                      ? "Please Enter your first name"
                                      : null,
                                  lastname.isEmpty
                                      ? "Please Enter your last name"
                                      : null,
                                  username.isEmpty
                                      ? "Please Enter your last name"
                                      : null
                                ];
                                if (validators
                                    .any((element) => element != null)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(validators.firstWhere(
                                                  (element) =>
                                                      element != null) ??
                                              "")));
                                  return;
                                }

                                setState(() {
                                  _isLoading = true;
                                });
                                if (mounted) {
                                  setState(() {});
                                }

                                var response = await updateUserData(
                                    
                                    email: email,
                                    username: username,
                                    otherName: othername,
                                    lastName: lastname,
                                    firstName: firstname,
                                    image: ""
                                    );

                                setState(() {
                                  _isLoading = false;
                                });

                                setState(() {
                                  _isLoading = false;
                                });
                                if (!response) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(errors!)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AppPageController()));
                                }
                              },
                              child: Container(
                                  child: _isLoading
                                      ? luxButtonLoading(
                                          HexColor("#D70A0A"), 360)
                                      : luxButton(HexColor("#D70A0A"),
                                          Colors.white, "Create account", 360,
                                          fontSize: 16))),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        )));
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

  Future<bool> updateUserData(
      {required String firstName,
      required String lastName,
      required String otherName,
      required String email,
      required String username,
      required var image}) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'username': username,
      "other_name": otherName,
      "last_name": lastName,
      "first_name ": firstName,
      "avatar": image,
      "gender":""
    });
    try {
      var response = await dio.put(
        "/api/user/profile/",
        data: formData,
      );

      print(formData.toString());

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await ErrorMessages.fromJson(errorData);
        errors = errorMessage.errors.message;
        return false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

void _luxTagBottomSheet(context) {
  showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return LuxTag();
      });
}
