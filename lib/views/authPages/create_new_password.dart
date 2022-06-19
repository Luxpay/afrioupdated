import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/password_change_congratulation.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/otfields.dart';
import 'package:luxpay/widgets/touchUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/errors/error.dart';
import '../../networking/dio.dart';
import '../../utils/validators.dart';

class CreateNewPassword extends StatefulWidget {
  String? newOtp;
  CreateNewPassword({Key? key, required this.newOtp}) : super(key: key);

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  var controllerPassword = TextEditingController();
  var controllerConfirmPassword = TextEditingController();

  String errors = "Something went wrong";

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
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
                      width: SizeConfig.safeBlockHorizontal! * 23,
                    ),
                    const Text(
                      "New Password",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical! * 4,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enter Your Mobile Number",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 1,
                    ),
                    Text(
                      "Create a new password. Password should be different from previous..",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3,
                    ),
                    PasswordTextField(
                        hint: "New Password", controller: controllerPassword),
                    SizedBox(height: 40),
                    PasswordTextField(
                        hint: "Confirm Password",
                        controller: controllerConfirmPassword),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 8,
                    ),
                    InkWell(
                      onTap: () async {
                        var newpassword = controllerPassword.text.trim();
                        var confirmpassword =
                            controllerConfirmPassword.text.trim();
                        setState(() {
                          _isLoading = true;
                        });
                        var validators = [
                          Validators.validateTwoPassword(
                              newpassword, confirmpassword),
                        ];
                        if (validators.any((element) => element != null)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(validators.firstWhere(
                                      (element) => element != null) ??
                                  "")));
                          setState(() {
                            _isLoading = false;
                          });
                          return;
                        }
                        var response = await updatePassword(confirmpassword);

                        setState(() {
                          _isLoading = false;
                        });

                        if (response) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PasswordChangeCongratulation()));
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(errors)));
                        }
                      },
                      child: _isLoading
                          ? luxButtonLoading(
                              HexColor("#D70A0A"), double.infinity)
                          : luxButton(HexColor("#D70A0A"), Colors.white,
                              "Continue", double.infinity,
                              fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> updatePassword(String password) async {
    final storage = new FlutterSecureStorage();
    Map<String, dynamic> body = {
      "otp": "${widget.newOtp}",
      "password": "$password",
      'phone': await storage.read(key: 'phoneNumber')
    };
    debugPrint("DataB4send:${body}");
    try {
      var response = await unAuthDio.put(
        "/api/user/password/reset/confirm/",
        data: body,
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
        debugPrint(' Error: ${e.response?.data}');
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
