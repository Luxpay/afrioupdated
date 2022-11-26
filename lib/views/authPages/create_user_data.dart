import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/touchUp.dart';
import '../page_controller.dart';

class CreateUserProfileData extends StatefulWidget {
  const CreateUserProfileData({Key? key}) : super(key: key);

  @override
  State<CreateUserProfileData> createState() => _CreateUserProfileDataState();
}

class _CreateUserProfileDataState extends State<CreateUserProfileData> {
  bool _isLoading = false;
  var fileImage;
  var memoryImage;
  var errors;
  bool imagePicked = false;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerLuxtag = TextEditingController();
  final color = Colors.blue;

  String? checkPin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 50,
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
                        width: SizeConfig.safeBlockHorizontal! * 5,
                      ),
                      const Text(
                        "Create your Account",
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
                    margin: EdgeInsets.only(top: 60, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("STEP 3 OF 3",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w100)),
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
                      SizedBox(height: 50),
                      InkWell(
                          onTap: () async {
                            var validators = [
                              imagePicked == false ? "Upload your image" : null,
                            ];
                            if (validators.any((element) => element != null)) {
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

                            var resultAvatar = await updateUserAvatar(
                              image: fileImage,
                            );

                            setState(() {
                              _isLoading = false;
                            });

                            if (!resultAvatar) {
                              setState(() {
                                _isLoading = false;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errors!)));
                            } else {
                              setState(() {
                                _isLoading = false;
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppPageController()));
                            }
                          },
                          child: Container(
                              child: _isLoading
                                  ? luxButtonLoading(HexColor("#D70A0A"), 360)
                                  : luxButton(HexColor("#D70A0A"), Colors.white,
                                      "Create account", 360,
                                      fontSize: 16))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

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

  Future<bool> updateUserAvatar({
    required File? image,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    String fileName = image!.path.split('/').last;
    FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(image.path, filename: fileName),
    });
    //debugPrint("UserUpdate: ${formData.toString}");

    try {
      var response = await dio.patch(
        "/user/profile/avatar/",
        data: formData,
      );

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');

        await prefs.setString(completeSignUp, 'done');

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      handleStatusCode(e.response?.statusCode, context);
      if (e.response != null) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(' Error Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await AuthError.fromJson(errorData);
        errors = errorMessage.message;
        return false;
      } else {
        errors = errorMessage;
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

// void _luxTagBottomSheet(context) {
//   showModalBottomSheet<dynamic>(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(8.0),
//           topRight: Radius.circular(8.0),
//         ),
//       ),
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return LuxTag();
//       });
// }
