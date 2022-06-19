import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/networking/dio.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/authPages/create_account.dart';
import 'package:luxpay/views/authPages/addBvn_page.dart';
import 'package:luxpay/views/authPages/create_new_pin_password_profile.dart';
import 'package:luxpay/views/page_controller.dart';
import 'package:luxpay/widgets/pin_entry.dart';

class CreatePinPage extends StatefulWidget {
  static const String path = "/createpin";
  const CreatePinPage({Key? key}) : super(key: key);

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  var confirm = false;
  int? confirmPin;
  int? pin;
  String? errors;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (confirm) {
          confirm = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          onPressed: () {
                            if (confirm) {
                              confirm = false;
                              if (mounted) {
                                setState(() {});
                              }
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          icon: const Icon(Icons.arrow_back_ios_new)),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 27,
                      ),
                      const Text(
                        "Create a pin",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: SizeConfig.safeBlockHorizontal! * 6,
                    right: SizeConfig.safeBlockHorizontal! * 6,
                    top: SizeConfig.safeBlockHorizontal! * 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        confirm ? "Confirm pin" : "Create pin",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 2,
                      ),
                      Text(
                        confirm
                            ? """Re-enter your authorization pin. To change this pin, 
you'll have to make a request"""
                            : "Create a 4 digits pin to autorize transactions on \nLuxpay.",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 8,
                      ),
                      !confirm
                          ? PinEntry(
                              tag: "pin",
                              onPinChanged: (v) {
                                pin = v;
                                if (v?.toString().split("").length == 4) {
                                  setState(() {
                                    confirm = true;
                                  });
                                }
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                            )
                          : PinEntry(
                              tag: "confirm",
                              onPinChanged: (v) async {
                                confirmPin = v;
                                if (v.toString().split("").length == 4) {
                                  var res = await setPin(pin, confirmPin);
                                  // create a scaffold messenger that displays res as text
                                  if (!res) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(errors ??
                                                "something went wrong")));
                                  } else {
                                    // Navigator.of(context).pushNamedAndRemoveUntil(
                                    //     AppPageController.path, (route) => false);

                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateNewPassword2Profile()),
                                        (route) => false);
                                  }
                                }
                              },
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> setPin(int? pin, int? confirmPin) async {
    if (pin != confirmPin) {
      errors = "Pin does not match";
    }
    Map<String, dynamic> body = {
      'pin': "$pin",
    };
    try {
      var response = await dio.post(
        "/api/user/pin/",
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
