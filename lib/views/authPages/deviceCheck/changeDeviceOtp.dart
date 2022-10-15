import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/sent_otp.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../models/errors/authError.dart';
import '../../../models/userData.dart';
import '../../../networking/DioServices/dio_client.dart';
import '../../../networking/DioServices/dio_errors.dart';
import '../../../utils/constants.dart';
import '../../../utils/functions.dart';
import '../../../widgets/methods/getDeviceInfo.dart';
import '../../page_controller.dart';
import 'change_device_otp.dart';

class ChangeDeviceOtp extends StatefulWidget {
  final String recipientAddress;
  final String recipientAddresEmail;
  const ChangeDeviceOtp(
      {Key? key,
      required this.recipientAddresEmail,
      required this.recipientAddress})
      : super(key: key);

  @override
  State<ChangeDeviceOtp> createState() => _ChangeDeviceOtpState();
}

class _ChangeDeviceOtpState extends State<ChangeDeviceOtp> {
  int time = 120;
  bool _isLoading = false;
  String otp = "";
  late Timer timer;
  String? errors;
  String? showAddress, phone, email;
  TextEditingController textEditingController = TextEditingController();
  var event_id;

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
    fcmToken();
    getDeviceDetails();
    super.initState();
    if (widget.recipientAddress != '') {
      phone = widget.recipientAddress;
      showAddress = widget.recipientAddress
          .replaceRange(2, widget.recipientAddress.length - 5, "****");
      sendOTP(widget.recipientAddress, "");
    } else {
      email = widget.recipientAddresEmail;
      showAddress = widget.recipientAddresEmail
          .replaceRange(2, widget.recipientAddresEmail.length - 5, "****");
      sendOTP("", widget.recipientAddresEmail);
    }

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
                          "Enter the 6 digits verification code we sent to \n$showAddress",
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

                            bool response = await verifyOTP(otp);
                            setState(() {
                              _isLoading = false;
                            });

                            if (response) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppPageController()));
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
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
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 6,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        bool response = await verifyOTP(otp);

                        if (response) {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppPageController()));
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
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
                              await sendOTP(phone, email);
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
    String token;
    final storage = new FlutterSecureStorage();
    otp = otp.replaceAll("\u200B", "");
    if (otp.isEmpty || otp.length != 6) {
      //print(otp.length);
      errors = "Input Complete Otp";
      return false;
    }
    Map<String, dynamic> body = {
      "event_id": event_id,
      "code": "$otp",
    };
    //print("otp: $otp");
    try {
      var response = await unAuthDio.post(
        "/auth/device/verify/",
        data: body,
      );
       ;
      if (response.statusCode == 200) {

        var data = response.data;
        debugPrint('${response.statusCode}');
        var userData = await UserData.fromJson(data);
        token = userData.data.token;
        debugPrint("Token Stored: ${token}");
        storage.write(key: authToken, value: token);

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
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

  Future<bool> sendOTP(phone, email) async {
    String url;
    final storage = new FlutterSecureStorage();
    try {
      Map<String, dynamic> body = {
        "phone": phone,
        "email": email,
        "token": await storage.read(key: 'fcmToken'),
        "platform": await storage.read(key: "DeviceName")
      };
      if (phone.isEmpty) {
        body.remove("phone");
        url = "/auth/device/register-email/";
      } else {
        body.remove("email");
        url = "/auth/device/register-phone/";
      }
      var result = await unAuthDio.post(
        url,
        data: body,
      );

      var data = result.data;
      var otpData = await SenOtpResponse.fromJson(data);
      event_id = otpData.data.eventId;

      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await AuthError.fromJson(errorData);
        errors = errorMessage.message;
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
