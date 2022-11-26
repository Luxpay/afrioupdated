import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/finances/selectBeneficiary_withdrawal.dart';
import 'package:luxpay/views/finances/select_bank.dart';
import 'package:luxpay/views/finances/withdrawal_confirmation.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../models/about_wallet.dart';
import '../../models/accountName.dart';
import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/validators.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/payment/wallet.dart';

class Withdrawal extends StatefulWidget {
  const Withdrawal({Key? key}) : super(key: key);

  @override
  State<Withdrawal> createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  var luxpayTagController = TextEditingController();
  var luxpayAmountController = TextEditingController();
  var reasonController = TextEditingController();
  var benefiaryAccController = TextEditingController();
  final storage = new FlutterSecureStorage();
  String? selectedBank, selectedbankCode, accountName, warning;
  String save = 'false';
  var errors;
  bool checkdata = false;

  String? walletBalance;
  var beneAccountName;
  var beneBankCode;
  var beneBankName;
  var beneAccountNumber;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getWallets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Stack(children: [
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
                            width: SizeConfig.safeBlockHorizontal! * 1,
                          ),
                          const Text(
                            "Withdraw",
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
                        margin: EdgeInsets.only(top: 60, left: 20, right: 20),
                        child: WalletLuxpay(balance: walletBalance ?? '0.00'))),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 230, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.person,
                              color: black,
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  _SelectBeneficiaryBottomSheet(context);
                                },
                                child: Text(
                                  "Select Beneficiary",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: black),
                                ),
                              ),
                            )
                          ],
                        )),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2,
                        ),
                        Text(
                          "Select Your Bank",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#1E1E1E")),
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
                              child: Text("${selectedBank ?? "eg GTB Bank"}"),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2.7,
                        ),
                        LuxTextField(
                          hint: "Beneficiary Account Number *",
                          controller: benefiaryAccController,
                          innerHint: "Account number",
                          onChanged: (v) async {
                            print(v);
                            if (v.trim().length == 10) {
                              var result =
                                  await getUserName(v, '${selectedbankCode}');
                              debugPrint("$result");
                              if (!result) {
                                setState(() {
                                  accountName = "${errors}";
                                });
                              }
                            }
                          },
                        ),
                        Text(
                          "${accountName ?? " "}",
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 1.2,
                        ),
                        LuxTextField(
                            hint: "Amount *",
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
                                if (amount <= 499) {
                                  setState(() {
                                    warning =
                                        'Ensure this amount is greater than or equal to N500';
                                  });
                                } else {
                                  setState(() {
                                    warning = '';
                                  });
                                }
                              }
                            }),
                        Text(
                          "${warning ?? " "}",
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 2.2,
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
                        Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Save Beneficiary",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: black),
                            ),
                            //Icon(IconlyLight.profile),
                            Container(
                              height: 20,
                              child: ToggleSwitch(
                                minWidth: 50.0,
                                cornerRadius: 20.0,
                                activeBgColors: [
                                  [Colors.green[800]!],
                                  [Colors.red[800]!]
                                ],
                                activeFgColor: Colors.white,
                                inactiveBgColor: grey2,
                                inactiveFgColor: Colors.white,
                                initialLabelIndex: 1,
                                totalSwitches: 2,
                                labels: ['yes', 'no'],
                                radiusStyle: true,
                                onToggle: (index) {
                                  if (index == 0) {
                                    save = 'true';
                                  } else {
                                    save = 'false';
                                  }
                                  print('switched to: $save');
                                },
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 3,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              var beneficiaryAccountNum =
                                  benefiaryAccController.text.trim();
                              var amount = luxpayAmountController.text.trim();
                              var reasons = reasonController.text.trim();

                              int ego;
                              //cLimit;
                              //double limit;
                              var validators, validators1;

                              if (amount.isNotEmpty) {
                                ego = int.parse(amount);
                                //limit = double.parse(walletBalance!);
                                //cLimit = limit.toInt();
                                ego = int.parse(amount);
                                validators1 = [
                                  ego < 499
                                      ? "Amount can't be less than N500"
                                      : null,
                                  // ego > cLimit
                                  //     ? "Upgrade your account to be able to make bigger amount transaction\nAmount exceeds single limit Thanks "
                                  //     : null
                                ];
                                if (validators1
                                    .any((element) => element != null)) {
                                  showErrorDialog(
                                      context,
                                      validators1.firstWhere(
                                              (element) => element != null) ??
                                          "",
                                      "Request Money");
                                  return;
                                }
                              }

                              validators = [
                                selectedBank == null ? "Select a bank" : null,
                                Validators.isValidAmount(amount),
                                Validators.forWithdrawal(beneficiaryAccountNum),
                              ];

                              if (validators
                                  .any((element) => element != null)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(validators.firstWhere(
                                                (element) => element != null) ??
                                            "")));
                                return;
                              } else {
                                _confirmBottomSheet(context,
                                    accountName: accountName,
                                    bankName: selectedBank,
                                    beneficiaryAccountNumber:
                                        beneficiaryAccountNum,
                                    amount: amount,
                                    reasons: reasons,
                                    save: save,
                                    selectedbankCode: selectedbankCode);
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
                          height: SizeConfig.safeBlockVertical! * 3,
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  Future<bool> getUserName(
    String? accountNumber,
    String? bankCode,
  ) async {
    try {
      var response = await dio.get(
          "/finances/withdraw/resolve/?account_number=$accountNumber&bank_code=$bankCode");
      if (response.statusCode == 200) {
        var data = response.data;
        var user = await GetAccountName.fromJson(data);
        setState(() {
          accountName = user.data.accountName;
          print(accountName);
        });
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await AuthError.fromJson(errorData);
        setState(() {
          errors = errorMessage.message;
        });
        return false;
      } else {
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
        builder: (BuildContext context) => SelectBank()).then((value) => {
          setState(() {
            debugPrint("Whats Returning :${value["bank_code"]}");
            debugPrint("Whats Returning :${value["bank_name"]}");
            selectedBank = value["bank_name"];
            selectedbankCode = value["bank_code"];
          })
        });
  }

  void _SelectBeneficiaryBottomSheet(context) {
    showModalBottomSheet<dynamic>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) => SelectBeneficiaryWithdrawal())
        .then((value) => {
              setState(() {
                beneAccountName = value["account_name"];
                beneBankCode = value["bank_code"];
                beneBankName = value["bank_name"];
                beneAccountNumber = value["account_number"];

                selectedbankCode = beneBankCode;
                benefiaryAccController.text = beneAccountNumber;
                selectedBank = beneBankName;
                if (beneAccountNumber != null) {
                  returns();
                }
              })
            });
  }

  void returns() async {
    var result = await getUserName(beneAccountNumber, '${selectedbankCode}');
    debugPrint("$result");
    if (!result) {
      setState(() {
        accountName = "${errors}";
      });
    }
  }

  Future<bool> getWallets() async {
    var response = await dio.get(
      "/wallet/",
    );
    debugPrint('${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await AboutWallet.fromJson(data);
        setState(() {
          checkdata = true;
          // walletInfo = walletData.data.wallet.balance;

          walletBalance = walletData.data.balance;
          ;
        });

        debugPrint("wallet balance $walletBalance}");

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
        showErrorDialog(context, errors, "Wallet");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }
}

void _confirmBottomSheet(context,
    {accountName,
    bankName,
    save,
    beneficiaryAccountNumber,
    amount,
    reasons,
    selectedbankCode}) {
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
        return WithdrawalConfirmation(
            save: save,
            bankCode: selectedbankCode,
            accountName: accountName,
            bankName: bankName,
            beneficiaryAccountNumber: beneficiaryAccountNumber,
            amount: amount,
            reasons: reasons);
      });
}
