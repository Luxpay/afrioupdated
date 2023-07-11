import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/get_account_details.dart';
import 'package:luxpay/podos/payment_methods.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/paymentMethod/ussd.dart';

import '../../models/errors/authError.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../widgets/methods/showDialog.dart';
import 'amount_debit.dart';
import 'bank_transfer.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  List<PaymentMethodObj> items = [
    if (Platform.isAndroid) ...{
      new PaymentMethodObj(
          2,
          "Quick TopUp",
          "Top up with a debit card",
          "assets/paymentMethod/card.png",
          HexColor("#22B02E").withOpacity(.20)),
    },
    new PaymentMethodObj(
        1,
        "LuxPay Account",
        "From bank app or internet banking",
        "assets/paymentMethod/bank.png",
        HexColor("#F4752E").withOpacity(.20)),
    new PaymentMethodObj(3, "USSD", "With your other bank’s USSD code",
        "assets/paymentMethod/hash.png", HexColor("#144DDE").withOpacity(.20)),
  ];

  var errors, check, statusCode;

  String? accountNumber, accountName, bankName;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 2.4,
                    ),
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.6,
                ),
                Container(
                  color: HexColor("#FBFBFB"),
                  child: Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            index == items.length - 1
                                ? Container()
                                : const SizedBox(
                                    height: 16,
                                  ),
                        padding: const EdgeInsets.symmetric(horizontal: 24).add(
                          const EdgeInsets.only(top: 27, bottom: 32),
                        ),
                        itemBuilder: (context, index) => PaymentMethodWidget(
                          paymentMethodObj: items[index],
                        ),
                        itemCount: items.length,
                      )
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

  PaymentMethodWidget({required PaymentMethodObj paymentMethodObj}) {
    return InkWell(
      onTap: () async {
        if (paymentMethodObj.id == 1) {
          _fetchBankTransfer(context);
        } else if (paymentMethodObj.id == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DebitAmount(
                        channel: "CARD",
                      )));
        } else {
          fetchUSSD(context);
        }
      },
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, top: 30.5, bottom: 30.5, right: 22.67),
          child: Row(
            children: [
              Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: paymentMethodObj.colour,
                      borderRadius: BorderRadius.circular(16)),
                  child: Image.asset(
                    "${paymentMethodObj.img}",
                    scale: 2,
                  )),
              SizedBox(
                width: 21,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${paymentMethodObj.title}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${paymentMethodObj.subTitle}",
                    style: TextStyle(
                        color: black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_forward_ios,
                      color: HexColor("#8D9091"),
                      size: 14,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> accountDetails() async {
    try {
      var response = await dio.get("/finances/deposit/details/");
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        var accDetails = await GetAccountDetails.fromJson(data);
        check = accDetails.data;
        bankName = accDetails.data[0].bankName;
        accountNumber = accDetails.data[0].accountNumber;
        accountName = accDetails.data[0].accountName;
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          statusCode = 401;
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else if (e.response?.statusCode == 422) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DebitAmount(
                        channel: "BANK",
                      )));
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await AuthError.fromJson(errorData);
          errors = errorMessage.message;
          return false;
        }
      } else {
        errors = errorMessage;
        showErrorDialog(context, errors, "Banks Transfer");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void _fetchBankTransfer(BuildContext context) async {
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

    Future.delayed(const Duration(milliseconds: 100), () async {
// Here you can write your code

      await accountDetails();
      if (check.isNotEmpty) {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BankTransfer(
                    accountNumber: accountNumber,
                    accountName: accountNumber,
                    bankName: bankName)));
      } else if (statusCode == 401) {
        Navigator.of(context).pop();
        showExpiredsessionDialog(
            context, "Please Login again\nThanks", "Expired Session");
      } else {
        Navigator.of(context).pop();
        showErrorDialog(
            context,
            "Upgrade your Account with a Valid ID Card to enable your Bank Transfer\nThanks",
            "Luxpay");
      }
    });
  }

  void fetchUSSD(BuildContext context) async {
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

    Future.delayed(const Duration(milliseconds: 100), () async {
// Here you can write your code

      await accountDetails();
      if (check.isNotEmpty) {
        Navigator.pop(context);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UssdTransfer(
                      bankName: accountName,
                      bankNumber: accountNumber,
                    )));
        Navigator.pop(context);
      } else if (statusCode == 401) {
        Navigator.of(context).pop();
        showExpiredsessionDialog(
            context, "Please Login again\nThanks", "Expired Session");
      } else {
        Navigator.pop(context);
        showErrorDialog(
            context,
            "Upgrade your Account with a Valid ID Card to enable your Bank USSD Transfer\nThanks",
            "Luxpay");
      }
    });
  }
}
