import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/error.dart';
import 'package:luxpay/models/packagesModel.dart';
import 'package:luxpay/models/refreshUser.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/constants.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/myProfits/crowd365_packages.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../models/errors/refferal.dart';
import '../../networking/dio.dart';
import '../../widgets/lux_buttons.dart';

class Crowd365Refere extends StatefulWidget {
  const Crowd365Refere({Key? key}) : super(key: key);

  @override
  State<Crowd365Refere> createState() => _Crowd365RefereState();
}

class _Crowd365RefereState extends State<Crowd365Refere> {
  TextEditingController controllerRefere = TextEditingController();
  List? packageItems;
  bool _isLoading = false;
  bool _isLoadingPackage = false;
  var errors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 6,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: grey4,
                      ),
                      margin: const EdgeInsets.only(top: 10)),
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.only(right: 20, top: 20),
                        child: CircleButton(
                            onTap: () => Navigator.pop(context),
                            iconData: Icons.close))),
                Container(
                  margin: EdgeInsets.only(top: 60, right: 40, left: 40),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          LuxTextField(
                            hint: "Enter your referral code here",
                            controller: controllerRefere,
                            innerHint: "Enter card code name",
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                                _isLoadingPackage = false;
                              });
                              var referal = controllerRefere.text.trim();
                              var validators = [
                                referal.isEmpty
                                    ? "Please Enter Your Referral Code"
                                    : null,
                              ];
                              if (validators
                                  .any((element) => element != null)) {
                                setState(() {
                                  _isLoading = false;
                                });
                                _showChoiceDialog(
                                    context,
                                    validators.firstWhere(
                                            (element) => element != null) ??
                                        "");

                                return;
                              }

                              var res = await referrerSend(referal);
                              print("ref ${res}");
                              // create a scaffold messenger that displays res as text
                              if (!res) {
                                setState(() {
                                  _isLoading = false;
                                });
                                _showChoiceDialog(context, errors);
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Crowd365Packages(
                                              referrerPackage: packageItems,
                                            )));
                              }
                            },
                            child: _isLoading
                                ? luxButtonLoading(
                                    HexColor("#415CA0"), double.infinity)
                                : luxButton(HexColor("#415CA0"), Colors.white,
                                    "Continue", 325,
                                    fontSize: 16, height: 50, radius: 8),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoading = false;
                                _isLoadingPackage = true;
                              });

                              var result = await getPackage();

                              if (!result) {
                                setState(() {
                                  _isLoadingPackage = false;
                                });
                                _showChoiceDialog(context, errors);
                              } else {
                                setState(() {
                                  _isLoadingPackage = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Crowd365Packages(
                                              referrerPackage: packageItems,
                                            )));
                              }
                            },
                            child: _isLoadingPackage
                                ? Text(
                                    "Try again Loadin....",
                                    style: TextStyle(
                                        color: HexColor("#415CA0"),
                                        fontSize: 16),
                                  )
                                : Text(
                                    "GET A NEW PACKAGE",
                                    style: TextStyle(
                                        color: HexColor("#415CA0"),
                                        fontSize: 16),
                                  ),
                          )
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> referrerSend(String referalCode) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'Crowd365ReferalCode');
    debugPrint("Sponsor ReferalCode: $referalCode");
    await storage.write(key: 'Crowd365ReferalCode', value: referalCode);

    try {
      var response =
          await dio.get("/api/v1/crowd365/packages/?referrer=$referalCode");
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var packageData = Packages.fromJson(data);
        packageItems = packageData.data.packages;
        await storage.delete(key: expiredToken);
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 400) {
          errors = "Invalid Code Check And Retry Again";
          return false;
        } else if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          _showChoiceDialog(context, errors);
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await ReferralError.fromJson(errorData);
          errors = errorMessage.errors.extra.error[0];
          return false;
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        return false;
      }
    } catch (e) {
      debugPrint('Error What ${e}');
      setState(() {
        _isLoading = false;
      });
      return false;
    }
  }

  Future<void> _showChoiceDialog(BuildContext context, content) async {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Crowd365",
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK")),
              ],
              content: Text(content));
        });
  }

//F6PN7W
  Future<bool> getPackage() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'Crowd365ReferalCode');
    try {
      var response = await dio.get(
        "/api/v1/crowd365/packages/",
      );
      debugPrint('Error code${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var packageData = Packages.fromJson(data);
        packageItems = packageData.data.packages;

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          _showChoiceDialog(context, errors);
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await ErrorMessages.fromJson(errorData);
          errors = errorMessage.errors.message;
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
