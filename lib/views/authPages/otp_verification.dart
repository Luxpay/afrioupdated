import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/colors.dart';

import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/otfields.dart';

import 'package:pin_code_fields/pin_code_fields.dart';


import '../../models/error.dart';
import '../../utils/functions.dart';


class OTPVerification extends StatefulWidget {
  final VoidCallback onVerified;
  final String recipientAddress;
  const OTPVerification(
      {Key? key, required this.onVerified, required this.recipientAddress})
      : super(key: key);

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  int time = 120;
  bool _isLoading = false;
  String otp = "";
  late Timer timer;
  String? errors;
  late String showPhone;
  TextEditingController textEditingController = TextEditingController();

  void startCountdown() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (time == 0) {
        t.cancel();
        time = 120;
      } else {
        if (mounted) {
          setState(() {
            time--;
          });
        }
      }
    });
  }

  @override
  void initState() {
    startCountdown();
    super.initState();
    showPhone = widget.recipientAddress
        .replaceRange(2, widget.recipientAddress.length - 5, "****");
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      width: SizeConfig.safeBlockHorizontal! * 28,
                    ),
                    const Text(
                      "Verification",
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
                          "Verify your account",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    Row(
                      children: [
                        Text(
                          "Enter the 6 digits verification code we sent to \n$showPhone",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Code",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2,
                        ),

                        PinCodeTextField(
                          appContext: context,

                          keyboardType: TextInputType.number,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          autoDisposeControllers: true,
                          autoFocus: true,
                          cursorColor: Colors.red,
                          showCursor: true,
                          autoDismissKeyboard: true,
                          boxShadows: const [
                            BoxShadow(
                              color: Colors.black12,
                            ),
                          ],
                          pinTheme: PinTheme(
                            activeColor: Colors.green,
                            selectedColor: Colors.red,
                            inactiveColor: white,
                            inactiveFillColor:
                                HexColor("#E8E8E8").withOpacity(0.35),
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.grey,
                          ),
                          animationDuration: Duration(milliseconds: 300),
                          controller: textEditingController,
                          onCompleted: (v) async {
                            //  v = controllerOtp.text;
                            otp = v;
                            print("Otp: $otp");
                            setState(() {
                              _isLoading = true;
                            });
                            print(otp);
                            var validators = [
                              otp.isEmpty ? "Please Enter Otp" : null,
                              otp.length < 6 ? "Please Enter Otp" : null
                            ];
                            if (validators.any((element) => element != null)) {
                              setState(() {
                                _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(validators.firstWhere(
                                              (element) => element != null) ??
                                          "")));
                              return;
                            }

                            var response = await verifyOTP(otp);
                            setState(() {
                              _isLoading = false;
                            });

                            if (response) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreatePinPage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          errors ?? "something went wrong")));
                            }
                          },
                          onChanged: (value) {
                            print(value);
                            setState(() {
                              //currentText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            print("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )
                        //OTPFields(
                        //     count: 6,
                        //     onVerified: (v) async {
                        //       if (!controllerOtp.text.isEmpty) {
                        //         v = controllerOtp.text;
                        //       } else {
                        //         otp = v;
                        //       }
                        //       print("Otp: $otp");
                        //       setState(() {
                        //         _isLoading = true;
                        //       });
                        //       print(otp);
                        //       var validators = [
                        //         otp.isEmpty ? "Please Enter Otp" : null,
                        //         otp.length < 6 ? "Please Enter Otp" : null
                        //       ];
                        //       if (validators
                        //           .any((element) => element != null)) {
                        //         setState(() {
                        //           _isLoading = false;
                        //         });
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(
                        //                 content: Text(validators.firstWhere(
                        //                         (element) => element != null) ??
                        //                     "")));
                        //         return;
                        //       }
                        //       var response = await verifyOTP(otp);
                        //       setState(() {
                        //         _isLoading = false;
                        //       });
                        //       if (response) {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => CreatePinPage()));
                        //       } else {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(
                        //                 content: Text(
                        //                     errors ?? "something went wrong")));
                        //       }
                        //     }),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 6,
                    ),
                    InkWell(
                      onTap: () async {
                        var response = await verifyOTP(otp);
                        _isLoading = false;
                        if (mounted) {
                          setState(() {});
                        }
                        if (response) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreatePinPage()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(errors ?? "something went wrong")));
                        }
                      },
                      child: _isLoading
                          ? luxButtonLoading(
                              HexColor("#D70A0A"), double.infinity)
                          : luxButton(HexColor("#D70A0A"), Colors.white,
                              "Verify", double.infinity,
                              fontSize: 16),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 8,
                    ),
                    time == 0
                        ? InkWell(
                            onTap: () async {
                              //var data = await resentOTP();
                              await resentOTP();
                              startCountdown();
                            },
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              text: "Having trouble? Request a new code in ",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: getTimeForCountDown(time),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
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

  Future<bool> verifyOTP(String otp) async {
    otp = otp.replaceAll("\u200B", "");
    if (otp.isEmpty || otp.length != 6) {
      //print(otp.length);
      errors = "Input Otp complete";
      return false;
    }
    Map<String, dynamic> body = {
      "otp": "$otp",
    };
    print("otp: $otp");
    try {
      var response = await dio.post(
        "/api/user/signup/confirm/",
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

Future<String?> resentOTP() async {
  Map<String, dynamic> body = {"type": "email"};
  try {
    await dio.post(
      "/api/user/signup/otp/",
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
