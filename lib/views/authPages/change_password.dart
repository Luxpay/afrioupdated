import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

class ChangePassword extends StatefulWidget {
  static const String path = "/change_password";
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isLoading = false;
  var controller = TextEditingController();
  var controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1,
                  ),
                  Text(
                    "Create a new password. Password should be different from previous.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  LuxTextField(
                    hint: "New Password",
                    innerHint: "password",
                    controller: controller,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  LuxTextField(
                    hint: "Confirm Password",
                    innerHint: "password",
                    controller: controller2,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 7,
                  ),
                  InkWell(
                    onTap: () async {
                      _isLoading = true;
                      if (mounted) {
                        setState(() {});
                      }
                      var res = await changePassword(
                        controller.text.trim(),
                        controller2.text.trim(),
                      );
                      // create a scaffold messenger that displays res as text
                      if (res != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(res)));
                      } else {
                        Navigator.of(context).pop();
                      }
                      _isLoading = false;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: _isLoading
                        ? luxButtonLoading(HexColor("#D70A0A"), double.infinity)
                        : luxButton(HexColor("#D70A0A"), Colors.white,
                            "Continue", double.infinity,
                            fontSize: 16),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> changePassword(
      String password, String confirmPassword) async {
    if ([password, confirmPassword]
        .any((element) => element.length < 6 || element.isEmpty)) {
      return "Please enter passwords";
    }

    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    Map<String, dynamic> body = {
      "new_password": confirmPassword,
      "otp_code": ResetPasswordData.instance.otp.replaceAll("\u200B", ""),
      "type": "email",
      "email": ResetPasswordData.instance.email,
    };
    try {
      await unAuthDio.post(
        "/api/auth/reset-password/",
        data: body,
      );
      return null;
    } on DioError catch (e) {
      if (e.response != null) {
        return e.response?.data['message'] ?? "An error occurred";
      } else {
        return "An error occurred";
      }
    } catch (e) {
      return "An error occurred";
    }
  }
}
