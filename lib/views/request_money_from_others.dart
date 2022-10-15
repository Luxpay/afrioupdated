import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

import '../models/errors/authError.dart';
import '../networking/DioServices/dio_client.dart';
import '../networking/DioServices/dio_errors.dart';
import '../utils/colors.dart';
import '../utils/validators.dart';
import '../widgets/methods/showDialog.dart';
import 'luxpay_beneficiary.dart';

class ReceiveMoneyFromOthers extends StatefulWidget {
  const ReceiveMoneyFromOthers({Key? key}) : super(key: key);

  @override
  _ReceiveMoneyFromOthersState createState() => _ReceiveMoneyFromOthersState();
}

class _ReceiveMoneyFromOthersState extends State<ReceiveMoneyFromOthers> {
  bool _isLoading = false;
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerAmount = TextEditingController();

  var errors;

  var selectedUsername;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: const Icon(Icons.arrow_back_ios_new)),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 2.4,
                ),
                const Text(
                  "Request money from others",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 1.9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  LuxTextField(
                    hint: "Amount (N)",
                    controller: controllerAmount,
                    innerHint: "eg 1000",
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 4,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Select Username",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#1E1E1E")),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 1,
                      ),
                      InkWell(
                        onTap: () {
                          _SelectBankBottomSheet(context);
                        },
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          color: grey1,
                          child: Container(
                              child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("${selectedUsername ?? "eg johnson"}"),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 10,
                  ),
                  Center(
                      child: InkWell(
                          onTap: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            var amount = controllerAmount.text.trim();

                            var ego = int.parse(amount);
                            var validators = [
                              Validators.isValidAmount(amount),
                              selectedUsername == null
                                  ? "Select a userName"
                                  : null,
                              ego < 500
                                  ? "Amount Can't be less than N500"
                                  : null
                            ];
                            if (validators.any((element) => element != null)) {
                              setState(() {
                                _isLoading = false;
                              });
                              showErrorDialog(
                                  context,
                                  validators.firstWhere(
                                          (element) => element != null) ??
                                      "",
                                  "Request Money");
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });

                            var response = await requestMoney(
                              amount,
                              selectedUsername,
                            );

                            debugPrint("request: $response");
                            if (response) {
                              showErrorDialog(context, errors, "Request Money");
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              showErrorDialog(context, errors, "Request Money");
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: _isLoading
                              ? luxButtonLoading(HexColor("#D70A0A"), width)
                              : luxButton(HexColor("#D70A0A"), Colors.white,
                                  "Send", width,
                                  fontSize: 16))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> requestMoney(String amount, String username) async {
    Map<String, dynamic> body = {"amount": amount, 'username': username};
    try {
      var response = await dio.post(
        "/v1/wallets/request/",
        data: body,
      );
      if (response.statusCode == 200) {
        var data = response.data;
        var userData = await AuthError.fromJson(data);
        errors = userData.message;
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else if (e.response?.statusCode == 400) {
          errors = "Cannot transfer to self";
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Request Money");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void _SelectBankBottomSheet(context) {
    showModalBottomSheet<dynamic>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) => LuxpayBeneficiary())
        .then((value) => {
              setState(() {
                debugPrint("Whats Returning :${value["username"]}");

                selectedUsername = value["username"];
              })
            });
  }
}
