import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/get_user.dart';
import 'package:luxpay/views/finances/luxpay_confrim.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/constants.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../utils/validators.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';

class TransferToLuxpayAccount extends StatefulWidget {
  const TransferToLuxpayAccount({Key? key}) : super(key: key);

  @override
  State<TransferToLuxpayAccount> createState() =>
      _TransferToLuxpayAccountState();
}

class _TransferToLuxpayAccountState extends State<TransferToLuxpayAccount> {
  var luxpayTagController = TextEditingController();
  var luxpayAmountController = TextEditingController();
  var reasonController = TextEditingController();
  String? fullName, avatar, amount, reason, urname, warning, singleLimit;
  var errors = 'something went wrong';
  String save = 'false';
  final storage = new FlutterSecureStorage();

  Timer? searchOnStoppedTyping;

  var fullnameBene;

  var username;

  _onChangeHandler(value) {
    print(value);
    const duration = Duration(
        seconds: 3); // set the duration that you want call search() after that.
    setState(() => searchOnStoppedTyping?.cancel());
    setState(() => searchOnStoppedTyping = new Timer(duration, () async {
          var result = await getUserName(value);
          debugPrint("$result");
          if (!result) {
            setState(() {
              fullName = "${errors}";
            });
          }
        }));
  }

  Future checkBalance() async {
    singleLimit = await storage.read(key: singleLimitTransfer);
  }

  @override
  void initState() {
    super.initState();
    checkBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () => {Navigator.maybePop(context)},
                              icon: const Icon(Icons.arrow_back_ios_new)),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 2,
                          ),
                          const Text(
                            "Transfer to LuxPay account",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 70, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LuxTextField(
                          suffixIcon: Icon(IconlyLight.addUser),
                          hint: "LuxPay ID",
                          controller: luxpayTagController,
                          innerHint: "Enter LuxPay Tag",
                          onChanged: (v) {
                            _onChangeHandler(v);
                          },
                        ),
                        Text(
                          "${fullName ?? " "}",
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3,
                        ),
                        LuxTextField(
                            suffixIcon: Icon(IconlyLight.paper),
                            hint: "Amount [N]",
                            innerHint: "Enter Amount",
                            controller: luxpayAmountController,
                            textInputType: TextInputType.number,
                            onChanged: (v) {
                              if (v.isEmpty) {
                                setState(() {
                                  warning = '';
                                });
                              } else {
                                var amount = int.parse(v);
                                if (amount < 100) {
                                  setState(() {
                                    warning = 'amount most be more than 100';
                                  });
                                } else {
                                  setState(() {
                                    warning = '';
                                  });
                                }
                              }
                            }),
                        Text(
                          "${warning ?? ""}",
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 5,
                        ),
                        LuxTextField(
                          multiline: true,
                          hint: "Reason for withdrawal? (optional)",
                          innerHint: "Enter  message",
                          controller: reasonController,
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2,
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 5,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              int ego, cLimit;
                              double limit;
                              var amount = luxpayAmountController.text.trim();
                              var reasons = reasonController.text.trim();
                              username = luxpayTagController.text.trim();
                              var validators, validators1;
                              if (amount.isNotEmpty) {
                                ego = int.parse(amount);
                                limit = double.parse(singleLimit!);
                                cLimit = limit.toInt();
                                debugPrint("${ego} ${cLimit}");
                                validators1 = [
                                  ego < 100
                                      ? "Amount Can't be less than N100"
                                      : null,
                                  ego > cLimit
                                      ? "Upgrade your account to be able to make bigger amount transaction\nAmount exceeds single limit \nThanks "
                                      : null
                                ];
                                if (validators1
                                    .any((element) => element != null)) {
                                  showErrorDialog(
                                      context,
                                      validators1.firstWhere(
                                              (element) => element != null) ??
                                          "",
                                      "Luxpay");
                                  return;
                                }
                              }

                              print("ego ${amount}");
                              validators = [
                                Validators.forWithdrawal(username),
                                Validators.isValidAmount(amount),
                              ];

                              if (validators
                                  .any((element) => element != null)) {
                                showErrorDialog(
                                    context,
                                    validators.firstWhere(
                                            (element) => element != null) ??
                                        "",
                                    "Luxpay");
                                return;
                              } else {
                                luxpayToLuxpayBottomSheet(context,
                                    amount: amount,
                                    save: save,
                                    reasons: reasons,
                                    username: username,
                                    avatar: avatar,
                                    fullname: fullName);
                              }
                            },
                            child: luxButton(
                              HexColor("#D70A0A"),
                              HexColor("#FFFFFF"),
                              "Continue",
                              double.infinity,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 3,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  Future<bool> getUserName(String? luxTag) async {
    //"username": "08168768372",
    try {
      var response =
          await dio.get("/wallet/transfer/resolve/?username=$luxTag");
      //debugPrint("Check User name ${luxTag}");
      if (response.statusCode == 200) {
        var data = response.data;
        var user = await ResolveUserAccount.fromJson(data);
        setState(() {
          fullName = user.data.fullName;
          avatar = user.data.avatar;
          urname = user.data.username;
          debugPrint(urname);
        });

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
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
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

void luxpayToLuxpayBottomSheet(context,
    {username, amount, fullname, avatar, reasons, save}) {
  showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return LuxpayConfirm(
            username: username,
            avatar: avatar,
            reasons: reasons,
            fullname: fullname,
            amount: amount,
            save: save);
      });
}
