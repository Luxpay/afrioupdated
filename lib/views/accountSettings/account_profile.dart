import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../networking/dio.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../utils/validators.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';
import '../authPages/addBvn_page.dart';
import '../authPages/lux_tag.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({Key? key}) : super(key: key);

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  String selected_gender = 'F';
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerOtherName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLuxtag = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  var fileImage;
  var memoryImage;
  var errors;
  bool imagePicked = false;
  final color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
            //margin: EdgeInsets.only(left: 30, right: 30),
            width: double.infinity,
            height: MediaQuery.of(context).size.height + 100,
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
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => {Navigator.maybePop(context)},
                              icon: const Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 25,
                          ),
                          const Text(
                            "Profile Details",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 100, left: 30, right: 30),
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
                        SizedBox(height: 15),
                        PasswordTextField(
                          hint: "Password",
                          controller: passwordController,
                        ),
                        SizedBox(height: 50),
                        InkWell(
                            onTap: () async {
                              var firstname = controllerFirstName.text.trim();

                              var password = passwordController.text.trim();
                              var email = controllerEmail.text.trim();
                              var username = controllerLuxtag.text.trim();

                              var validators = [
                                Validators.isValidEmail(email),
                                firstname.isEmpty
                                    ? "Please Enter your first name"
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
                                Validators.isValidPassword(password),
                              ];
                              if (validators
                                  .any((element) => element != null)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(validators.firstWhere(
                                                (element) => element != null) ??
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
                                password: password,
                                firstName: firstname,
                                image: fileImage,
                              );

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
                                        builder: (context) => AddBvnPage()));
                              }
                            },
                            child: Container(
                                child: _isLoading
                                    ? luxButtonLoading(HexColor("#D70A0A"), 360)
                                    : luxButton(HexColor("#D70A0A"),
                                        Colors.white, "Save changes", 360,
                                        fontSize: 16))),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }

  Future<void> _showChoiceDialog(BuildContext context) async {
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
    required String password,
    required String email,
    required String username,
    required File image,
  }) async {
    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      'email': email,
      'username': username,
      "password": password,
      "first_name ": firstName,
      "avatar": await MultipartFile.fromFile(image.path, filename: fileName),
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
