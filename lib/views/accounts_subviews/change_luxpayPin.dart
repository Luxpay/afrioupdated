import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luxpay/models/errors/authError.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/pin_entry.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../crowd365/numberic_pad.dart';
import '../page_controller.dart';

class ChangeLuxpayPin extends StatefulWidget {
  static const String path = "/createpin";
  const ChangeLuxpayPin({Key? key}) : super(key: key);

  @override
  State<ChangeLuxpayPin> createState() => _ChangeLuxpayPinState();
}

class _ChangeLuxpayPinState extends State<ChangeLuxpayPin> {
  var confirm = false;
  int? confirmPin;
  int? pin;
  String? errors, tag;
  String? newPinCode, oldPinCode;
  String number1 = "";
  String number2 = "";

  get grey1 => null;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return AnnotatedRegion(
      // Reset SystemUiOverlayStyle for PageOne.
      // If this is not set, the status bar will use the style applied from another route.
      value: SystemUiOverlayStyle(
        statusBarColor: white,
        statusBarBrightness: Brightness.light,
      ),

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
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
                            icon: Icon(Icons.arrow_back_ios_new)),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 3,
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
                              ? "Enter your Old Pin to Confirm this your Account on \nLuxpay."
                              : """Enter Your New Pin First. To change this pin, 
you'll have to make a request""",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 8,
                        ),
                        !confirm
                            ? Column(
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        buildCodeNumberBox(number1.length > 0
                                            ? number1.substring(0, 1)
                                            : ""),
                                        buildCodeNumberBox(number1.length > 1
                                            ? number1.substring(1, 2)
                                            : ""),
                                        buildCodeNumberBox(number1.length > 2
                                            ? number1.substring(2, 3)
                                            : ""),
                                        buildCodeNumberBox(number1.length > 3
                                            ? number1.substring(3, 4)
                                            : ""),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          SizeConfig.blockSizeVertical! * 10),
                                  Container(
                                    child: NumericPad(
                                      onNumberSelected: (value) {
                                        setState(() {
                                          if (value != -1) {
                                            if (value.toString().length != 4) {
                                              number1 =
                                                  number1 + value.toString();

                                              if (number1.toString().length ==
                                                  4) {
                                                newPinCode = number1;
                                                debugPrint(
                                                    "Complete NewPin ${newPinCode}");

                                                number1 = '';
                                                confirm = true;
                                              }
                                            }
                                          } else {
                                            number1 = number1.substring(
                                                0, number1.length - 1);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        buildCodeNumberBox(number2.length > 0
                                            ? number2.substring(0, 1)
                                            : ""),
                                        buildCodeNumberBox(number2.length > 1
                                            ? number2.substring(1, 2)
                                            : ""),
                                        buildCodeNumberBox(number2.length > 2
                                            ? number2.substring(2, 3)
                                            : ""),
                                        buildCodeNumberBox(number2.length > 3
                                            ? number2.substring(3, 4)
                                            : ""),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          SizeConfig.blockSizeVertical! * 10),
                                  Container(
                                    child: NumericPad(
                                      onNumberSelected: (value) {
                                        setState(() {
                                          if (value != -1) {
                                            if (value.toString().length != 4) {
                                              number2 =
                                                  number2 + value.toString();

                                              if (number2.toString().length ==
                                                  4) {
                                                oldPinCode = number2;
                                                debugPrint(
                                                    "Complete OldPin ${oldPinCode}");

                                                fetchPin(context, newPinCode,
                                                    oldPinCode);
                                                number2 = '';
                                                confirm = true;
                                              }
                                            }
                                          } else {
                                            number1 = number1.substring(
                                                0, number1.length - 1);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> setPin(pin, confirmPin) async {
    if (pin != confirmPin) {
      errors = "Pin does not match";
    }
    Map<String, dynamic> body = {"new_pin": "$pin", "old_pin": "$confirmPin"};
    try {
      var response = await dio.patch(
        "/wallet/pin/",
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
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
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

  void fetchPin(BuildContext context, pin, confirmPin) async {
    // show the loading dialog
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    var res = await setPin(pin, confirmPin);
    // create a scaffold messenger that displays res as text
    if (!res) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errors ?? "something went wrong")));
    } else {
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     AppPageController.path, (route) => false);
      Navigator.pop(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => AppPageController()),
          (route) => false);
    }
  }
}
