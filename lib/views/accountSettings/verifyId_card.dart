import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/accountSettings/selectId_card.dart';

import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';

class ValidIDCard extends StatefulWidget {
  const ValidIDCard({Key? key}) : super(key: key);

  @override
  State<ValidIDCard> createState() => _ValidIDCardState();
}

class _ValidIDCardState extends State<ValidIDCard> {
  TextEditingController controller = TextEditingController();

  bool _isLoading = false;

  var cardID, cardName;

  var errors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#D70A0A"),
        body: SafeArea(
          child: Stack(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon:
                              Icon(Icons.arrow_back_ios, color: Colors.white)),
                      Text("Valid ID Card",
                          style: TextStyle(fontSize: 18, color: Colors.white))
                    ],
                  ),
                  Text(
                      "Please fill in your identification information (Please note\nthat it must not be details of an expired ID card)",
                      style: TextStyle(color: Colors.white))
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: SizeConfig.screenHeight,
                margin: EdgeInsets.only(top: 150),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      Text("ID Type"),
                      SizedBox(height: 5),
                      Container(
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(color: grey1),
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${cardName ?? "select id"}",
                                style: TextStyle(fontSize: 15, color: grey10),
                              ),
                              IconButton(
                                  onPressed: () {
                                    selectID_BottomSheet(context);
                                  },
                                  icon: Icon(Icons.arrow_drop_down))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LuxTextField(
                            hint: "ID Number",
                            controller: controller,
                            innerHint: "Enter Number",
                          ),
                          Text("* make sure you enter a valid ID number"),
                        ],
                      ),
                      SizedBox(height: 40),
                      InkWell(
                          onTap: () async {
                            var id_number = controller.text.trim();
                            var validators = [
                              cardName == null
                                  ? "Please Select a ID type"
                                  : null,
                              id_number.isEmpty
                                  ? "ID Number can't be empty"
                                  : null,
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
                                  "Luxpay");
                              return;
                            }
                            setState(() {
                              _isLoading = true;
                            });
                            var response =
                                await upgradeAccount(cardName, id_number);
                            if (!response) {
                              setState(() {
                                _isLoading = false;
                              });
                              showErrorDialog(context, errors, "Luxpay");
                            } else {
                              setState(() {
                                _isLoading = false;
                              });
                              showErrorDialog(context,
                                  "Upgrade is being processed.", "Luxpay");
                            }
                          },
                          child: _isLoading
                              ? luxButtonLoading(
                                  HexColor("#D70A0A"), double.infinity)
                              : luxButton(HexColor("#D70A0A"), Colors.white,
                                  "Continue", double.infinity,
                                  fontSize: 16)),
                    ],
                  ),
                ),
              ),
            )
          ]),
        ));
  }

  void selectID_BottomSheet(context) {
    showModalBottomSheet<dynamic>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => SelectIDCard()).then((value) => {
          setState(() {
            cardID = value["cardID"];
            cardName = value["cardName"];
          })
        });
  }

  Future<bool> upgradeAccount(String idType, String idNumber) async {
    Map<String, dynamic> body = {"id_type": idType, 'id_number': idNumber};
    try {
      var response = await dio.post(
        "/user/upgrade/",
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
      handleStatusCode(e.response?.statusCode, context);
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          setState(() {
            _isLoading = false;
          });
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        errors = errorMessage;
        showErrorDialog(context, errors, "Luxpay");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}
