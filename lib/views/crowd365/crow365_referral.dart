import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/authError.dart';

import 'package:luxpay/models/packagesModel.dart';

import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';

import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/methods/showDialog.dart';
import 'crowd365_packages.dart';

class Crowd365Refere extends StatefulWidget {
  const Crowd365Refere({Key? key}) : super(key: key);

  @override
  State<Crowd365Refere> createState() => _Crowd365RefereState();
}

class _Crowd365RefereState extends State<Crowd365Refere> {
  TextEditingController controllerRefere = TextEditingController();
  List<Packs> packageItems = [];
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
                            hint: "Enter your referral username here",
                            controller: controllerRefere,
                            innerHint: "Enter referral name",
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
                                    ? "Please Enter Your Referral Username"
                                    : null,
                              ];
                              if (validators
                                  .any((element) => element != null)) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showErrorDialog(
                                    context,
                                    validators.firstWhere(
                                            (element) => element != null) ??
                                        "",
                                    "Crowd365");

                                return;
                              }

                              var res = await referrerSend(referal);
                              print("ref ${res}");
                              // create a scaffold messenger that displays res as text
                              if (!res) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showErrorDialog(context, errors, "Crowd365");
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
                                showErrorDialog(context, errors, "Crowd365");
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
                                    "Packages Loadin....",
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

  Future<bool> referrerSend(String referalName) async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'Crowd365ReferalCode');
    debugPrint("Sponsor ReferalCode: $referalName");
    await storage.write(key: 'Crowd365ReferalCode', value: referalName);

    try {
      var response = await dio.get("/crowd365/packages/?username=$referalName");
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var packageData = Packages.fromJson(data);
        packageItems = packageData.data;

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        setState(() {
          _isLoading = false;
        });
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 400) {
          errors = "Username is required";
          return false;
        } else if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Crowd365");
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

//F6PN7W
  Future<bool> getPackage() async {
    final storage = new FlutterSecureStorage();
    await storage.delete(key: 'Crowd365ReferalCode');
    try {
      var response = await dio.get(
        "/crowd365/packages/?username=",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;

        var packageData = Packages.fromJson(data);

        packageItems = packageData.data;

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Crowd365");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
