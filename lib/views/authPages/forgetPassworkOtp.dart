import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/functions.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/authPages/create_new_password.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../models/errors/error.dart';
import '../../models/sent_otp.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';

class ForgetPasswordOtp extends StatefulWidget {
  final String? eventID;
  const ForgetPasswordOtp(
      {Key? key,
      required this.recipientAddressEmail,
      required this.recipientAddress,
      required this.eventID})
      : super(key: key);

  final String recipientAddress, recipientAddressEmail;

  @override
  State<ForgetPasswordOtp> createState() => _ForgetPasswordOtpState();
}

class _ForgetPasswordOtpState extends State<ForgetPasswordOtp> {
  int time = 120;
  bool _isLoading = false;
  String otp_number = "";
  late Timer timer;
  String? showPhone;
  String errors = "";
  String? newOtp, forgetEventID;

  String? event_id;

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

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startCountdown();
    forgetEventID = widget.eventID;
    setState(() {
      showPhone = widget.recipientAddress
          .replaceRange(2, widget.recipientAddress.length - 5, "****");
    });
    if (widget.recipientAddress != '') {
      setState(() {
        showPhone = widget.recipientAddress
            .replaceRange(2, widget.recipientAddress.length - 5, "****");
      });
    } else {
      setState(() {
        showPhone = widget.recipientAddressEmail
            .replaceRange(2, widget.recipientAddressEmail.length - 5, "****");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SafeArea(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
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
                              otp_number = v;
                              //print("Otp: $otp");
                              setState(() {
                                _isLoading = true;
                              });

                              print(otp_number);
                              print(widget.recipientAddress);

                              var response = await verifyOTP(
                                  otp: otp_number, event_id: forgetEventID);
                              setState(() {
                                _isLoading = false;
                              });

                              if (response) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CreateNewPassword(
                                            idEvent: forgetEventID)));
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(errors)));
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
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 6,
                      ),
                      InkWell(
                        onTap: () async {
                          var response = await verifyOTP(
                              otp: otp_number, event_id: widget.eventID);

                          setState(() {
                            _isLoading = true;
                          });

                          if (response) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateNewPassword(
                                        idEvent: forgetEventID)));
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
                                await resentOTP(widget.recipientAddress,
                                    widget.recipientAddressEmail);
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
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
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
      ),
    );
  }

  Future<bool> verifyOTP({otp, event_id}) async {
    otp = otp.replaceAll("\u200B", "");

    Map<String, dynamic> body = {"code": "$otp", 'event_id': "$event_id"};

    try {
      var response = await unAuthDio.post(
        "/auth/reset-password/verify/",
        data: body,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await ErrorMessages.fromJson(errorData);
        errors = errorMessage.errors.message;
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

  Future<bool> resentOTP(String phone, email) async {
    String url;
    Map<String, dynamic> body = {"phone": "$phone", "email": email};
    if (phone.isEmpty) {
      body.remove("phone");
      url = "/auth/reset-password/request-email/";
    } else {
      body.remove("email");
      url = "/auth/reset-password/request-phone/";
    }

    try {
      var response = await unAuthDio.post(
        url,
        data: body,
      );
      // final storage = new FlutterSecureStorage();
      //await storage.write(key: "phone", value: "$phone");
      if (response.statusCode == 201) {
        var data = response.data;
        var userData = await SenOtpResponse.fromJson(data);
        ;
        event_id = userData.data.eventId;
        forgetEventID = event_id;

        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await ErrorMessages.fromJson(errorData);
        errors = errorMessage.errors.message;
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
