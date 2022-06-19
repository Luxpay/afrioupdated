import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/functions.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/change_password.dart';
import 'package:luxpay/views/authPages/create_new_password.dart';
import 'package:luxpay/views/authPages/otp_verification_reset.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../models/errors/error.dart';
import '../../utils/validators.dart';
import 'forgetPassworkOtp.dart';

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
  String errors = "somthing went wrong";

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = false;
    });
  }

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
                      "Forgot Password",
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
                          "Reset Your Password",
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
                    PhoneNumberField(
                        controller: controller, hint: "Phone Number"),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 7,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        var phone = controller.text.trim();

                        var validators = [
                          Validators.isValidPhoneNumber(phone),
                          //Validators.isValidPhoneNumber(controllerB),
                        ];
                        if (validators.any((element) => element != null)) {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(validators.firstWhere(
                                      (element) => element != null) ??
                                  "")));
                          return;
                        }

                        var res = await sendCode(phone);
                        // create a scaffold messenger that displays res as text
                        if (!res) {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(errors)));
                        } else {
                          // ResetPasswordData.instance.modify(email: phone);
                          // await Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return OTPVerificationReset(
                          //       onVerified: () async {
                          //         await Navigator.of(context)
                          //             .pushNamed(ChangePassword.path);
                          //         Navigator.of(context).pop();
                          //       },
                          //       recipientAddress: obscureEmail(phone));
                          // }));
                          // Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPasswordOtp(
                                      onVerified: () {},
                                      recipientAddress: phone)));
                        }
                      },
                      child: _isLoading
                          ? luxButtonLoading(
                              HexColor("#D70A0A"), double.infinity)
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
      ),
    );
  }

  Future<bool> sendCode(String phone) async {
    final storage = new FlutterSecureStorage();
    Map<String, dynamic> body = {
      "phone": "$phone",
    };
    print(phone);
    await storage.write(key: 'phoneNumber', value: phone);
    try {
      var response = await unAuthDio.post(
        "/api/user/password/reset/",
        data: body,
      );
     // final storage = new FlutterSecureStorage();
      //await storage.write(key: "phone", value: "$phone");
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
