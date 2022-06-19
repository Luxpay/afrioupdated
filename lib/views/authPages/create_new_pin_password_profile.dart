import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/addBvn_page.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/views/authPages/lux_tag.dart';
import 'package:luxpay/views/page_controller.dart';
import 'package:luxpay/widgets/camera_image.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:dio/dio.dart';
import '../../models/errors/error.dart';
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
  String selected_gender = 'F';
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerOtherName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLuxtag = TextEditingController();
  TextEditingController controllerGender = TextEditingController();

  bool _isLoading = false;
  var fileImage;
  var memoryImage;
  var errors;
  bool imagePicked = false;

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
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      ListTile(
                        onTap: () {
                          _openGallery();
                        },
                        title: Text("Gallery"),
                      ),
                      ListTile(
                        onTap: () {
                          _openCamera(context);
                        },
                        title: Text("Camera"),
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
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      ListTile(
                        onTap: () {
                          _openGallery();
                        },
                        title: Text("Gallery"),
                      ),
                      ListTile(
                        onTap: () {
                          _openCamera(context);
                        },
                        title: Text("Camera"),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    }

    Future<bool> _willPopCallback() async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      controllerFirstName.clear();
      controllerLastName.clear();
      controllerOtherName.clear();
      controllerEmail.clear();
      controllerLuxtag.clear();
      controllerGender.clear();
      String selected_gender = 'F';
      return true; // return true if the route to be popped
    }

    final color = Colors.blue;
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: SafeArea(
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
                            // IconButton(
                            //     onPressed: () => {Navigator.maybePop(context)},
                            //     icon: const Icon(Icons.arrow_back_ios_new)),
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
                          margin:
                              EdgeInsets.only(top: 100, left: 30, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("STEP 1 OF 2",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100)),
                              SizedBox(height: 20),
                              Text(
                                "Provide Personal Details",
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
                                      borderRadius:
                                          BorderRadius.circular(300.0),
                                      child: fileImage == null
                                          ? Icon(
                                              Icons.person,
                                              size: 100,
                                              color: grey2,
                                            )
                                          : Image.file(
                                              fileImage,
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
                              hint: "Last Name",
                              controller: controllerLastName,
                              innerHint: "eg blak",
                            ),
                            SizedBox(height: 15),
                            LuxTextField(
                              hint: "Other Name",
                              controller: controllerOtherName,
                              innerHint: "eg smith",
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: HexColor("#1E1E1E")),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 8),
                                  color: HexColor("#E8E8E8").withOpacity(0.35),
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text("Select Gender: "),
                                        ),
                                        DropdownButton<String>(
                                          value: selected_gender,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: HexColor("#1E1E1E"),
                                              fontWeight: FontWeight.w300),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selected_gender = newValue!;
                                              print(selected_gender);
                                            });
                                          },
                                          items: <String>[
                                            'F',
                                            'M',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
                                  var firstname =
                                      controllerFirstName.text.trim();
                                  var lastname = controllerLastName.text.trim();
                                  var othername =
                                      controllerOtherName.text.trim();
                                  var email = controllerEmail.text.trim();
                                  var username = controllerLuxtag.text.trim();

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
                                        : null,
                                    imagePicked == false
                                        ? "Upload your image"
                                        : null,
                                    username.isEmpty
                                        ? "Enter Your LuxTag (Username)"
                                        : null,
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
                                      image: fileImage,
                                      gender: selected_gender);

                                  setState(() {
                                    _isLoading = false;
                                  });

                                  debugPrint("Upadete: $response");
                                  if (!response) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(errors!)));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddBvnPage()));
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
          )),
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

  void _openGallery() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    setState(() {
      fileImage = file;
      imagePicked = true;
    });
    final bytes = await pickedFile.readAsBytes();
    setState(() {
      memoryImage = bytes;
    });
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    final file = File(pickedFile.path);
    setState(() {
      fileImage = file;
    });
    final bytes = await pickedFile.readAsBytes();
    setState(() {
      memoryImage = bytes;
    });

    Navigator.pop(context);
  }

  Future<bool> updateUserData({
    required String firstName,
    required String lastName,
    required String otherName,
    required String email,
    required String username,
    required File image,
    required gender,
  }) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      'email': email,
      'username': username,
      "other_name": otherName,
      "last_name": lastName,
      "first_name ": firstName,
      "avatar": await MultipartFile.fromFile(image.path, filename: fileName),
      "gender": gender
    });
    debugPrint("UserUpdate: ${formData.toString}");
    try {
      var response = await dio.put(
        "/api/user/",
        data: formData,
      );

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
        // var errorData = e.response?.data;
        // var errorMessage = await ErrorMessages.fromJson(errorData);
        errors = "Something went wrong";
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
