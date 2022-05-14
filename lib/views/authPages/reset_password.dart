import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/functions.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/change_password.dart';
import 'package:luxpay/views/authPages/otp_verification_reset.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

class ResetPasswordData {
  final String email;
  final String otp;
  final String newPassword;
  final String password;

  static ResetPasswordData instance =
      ResetPasswordData(email: "", otp: "", newPassword: "", password: "");

  ResetPasswordData(
      {required this.email,
      required this.otp,
      required this.newPassword,
      required this.password});

  ResetPasswordData copyWith({
    String? email,
    String? otp,
    String? newPassword,
    String? password,
  }) {
    return ResetPasswordData(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      password: password ?? this.password,
    );
  }

  void modify({
    String? email,
    String? otp,
    String? newPassword,
    String? password,
  }) {
    instance = ResetPasswordData(
      email: email ?? this.email,
      otp: otp ?? this.otp,
      newPassword: newPassword ?? this.newPassword,
      password: password ?? this.password,
    );
  }
}

class ResetPassword extends StatefulWidget {
  static const String path = "/reset_password";
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isLoading = false;
  var controller = TextEditingController();

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
                    "Forgot Password",
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
                        "Enter Your Email Number",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 1,
                  ),
                  Text(
                    "We would send a verification code to the e-mail address below.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  LuxTextField(
                    hint: "Email",
                    innerHint: "johndoe@gmail.com",
                    controller: controller,
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
                      var email = controller.text.trim();

                      var res = await sendCode(email);
                      // create a scaffold messenger that displays res as text
                      if (res != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(res)));
                      } else {
                        ResetPasswordData.instance.modify(email: email);
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OTPVerificationReset(
                              onVerified: () async {
                                await Navigator.of(context)
                                    .pushNamed(ChangePassword.path);
                                Navigator.of(context).pop();
                              },
                              recipientAddress: obscureEmail(email));
                        }));
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

  Future<String?> sendCode(String email) async {
    Map<String, dynamic> body = {"email": "$email", "type": "email"};
    try {
      await unAuthDio.post(
        "/api/auth/reset-password/request/",
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
