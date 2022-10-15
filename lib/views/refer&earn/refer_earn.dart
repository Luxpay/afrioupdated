import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/views/refer&earn/refer&earn_payment.dart';

import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/touchUp.dart';

class Membership extends StatefulWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  State<Membership> createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  var controllerMember = TextEditingController();

  var errors;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 370,
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
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: Text(
                        "Have a referral username ?",
                        style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.only(right: 20, top: 30),
                        child: CircleButton(
                            onTap: () => Navigator.pop(context),
                            iconData: Icons.close))),
                Container(
                  margin: EdgeInsets.only(top: 100, right: 40, left: 40),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          LuxTextField(
                            hint: "Enter Invitation username Here",
                            controller: controllerMember,
                            innerHint: "Invitation username here",
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              var referal = controllerMember.text.trim();
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
                                    "Refer And Earn");

                                return;
                              }

                              var res = await referrerSend(referal);
                              print("ref ${res}");
                              // create a scaffold messenger that displays res as text
                              if (!res) {
                                setState(() {
                                  _isLoading = false;
                                });
                                showErrorDialog(
                                    context, errors, "Refer And Earn");
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ReferEarnPaymentMethod(
                                              sponsor: referal,
                                            )));
                              }
                            },
                            child: _isLoading
                                ? luxButtonLoading(
                                    HexColor("#D70A0A"), double.infinity)
                                : luxButton(HexColor("#D70A0A"), Colors.white,
                                    "Continue", 325,
                                    fontSize: 16, height: 50, radius: 8),
                          ),
                          SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReferEarnPaymentMethod(
                                            sponsor: '',
                                          )));
                            },
                            child: Text(
                              "BECOME A MEMEBER  NOW AND START EARNING ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor("#D70A0A"),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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

    try {
      var response = await dio.get("/v1/refer-earn/check/?sponsor=$referalName");
      if (response.statusCode == 200) {
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
}
