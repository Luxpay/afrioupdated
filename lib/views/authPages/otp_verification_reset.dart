import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:luxpay/utils/functions.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/reset_password.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/otfields.dart';

import '../../networking/DioServices/dio_client.dart';

class OTPVerificationReset extends StatefulWidget {
  final VoidCallback onVerified;
  final String recipientAddress;
  const OTPVerificationReset(
      {Key? key, required this.onVerified, required this.recipientAddress})
      : super(key: key);

  @override
  State<OTPVerificationReset> createState() => _OTPVerificationResetState();
}

class _OTPVerificationResetState extends State<OTPVerificationReset> {
  int time = 120;
  bool _isLoading = false;
  String otp = "";
  late Timer timer;

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
                    width: SizeConfig.safeBlockHorizontal! * 28,
                  ),
                  const Text(
                    "Verification",
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
                        "Enter the 6 digits verification code we sent to \n${widget.recipientAddress}",
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
                      OTPFields(
                          count: 6,
                          onVerified: (v) async {
                            otp = v;
                            _isLoading = true;
                            if (mounted) {
                              setState(() {});
                            }
                            var res = await verifyOTP(otp);
                            // create a scaffold messenger that displays res as text
                            if (res != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text(res)));
                            } else {
                              ResetPasswordData.instance
                                  .modify(otp: otp.replaceAll("\u200B", ""));
                              widget.onVerified();
                            }
                            _isLoading = false;
                            if (mounted) {
                              setState(() {});
                            }
                          }),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 6,
                  ),
                  InkWell(
                    onTap: () async {
                      _isLoading = true;
                      if (mounted) {
                        setState(() {});
                      }
                      var res = await verifyOTP(otp);
                      // create a scaffold messenger that displays res as text
                      if (res != null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(res)));
                      } else {
                        timer.cancel();
                        widget.onVerified();
                      }
                      _isLoading = false;
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    child: _isLoading
                        ? luxButtonLoading(HexColor("#D70A0A"), double.infinity)
                        : luxButton(HexColor("#D70A0A"), Colors.white, "Verify",
                            double.infinity,
                            fontSize: 16),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 8,
                  ),
                  time == 0
                      ? InkWell(
                          onTap: () async {
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
                            style: TextStyle(fontSize: 14, color: Colors.black),
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
    );
  }

  Future<String?> verifyOTP(String otp) async {
    otp = otp.replaceAll("\u200B", "");
    if (otp.isEmpty || otp.length != 6) {
      print(otp.length);
      return "Please enter OTP";
    }
    Map<String, dynamic> body = {
      "otp_code": "$otp",
      "type": "email",
      "email": ResetPasswordData.instance.email,
      "phone_number": ""
    };
    try {
      await unAuthDio.post(
        "/api/auth/reset-password/verify-otp/",
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

  Future<String?> resentOTP() async {
    Map<String, dynamic> body = {"type": "email"};
    try {
      await dio.post(
        "/api/auth/otp_code/resend/",
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
