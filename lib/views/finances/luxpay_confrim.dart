import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/finances/luxpayto_pin.dart';
import 'package:luxpay/widgets/payment/wallet.dart';

import '../../models/about_wallet.dart';
import '../../models/errors/authError.dart';

import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/methods/showDialog.dart';

class LuxpayConfirm extends StatefulWidget {
  final String? username, amount, fullname, avatar, reasons, save;

  LuxpayConfirm(
      {Key? key,
      required this.username,
      required this.amount,
      required this.fullname,
      this.save,
      this.avatar,
      this.reasons})
      : super(key: key);

  @override
  _LuxpayConfirmState createState() => _LuxpayConfirmState();
}

class _LuxpayConfirmState extends State<LuxpayConfirm> {
  String? username, amount, fullname, avatar, reasons;
  String? save;
  var errors;
  bool checkdata = false;

  String? walletBalance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getWallets();
    });

    username = widget.username;
    amount = widget.amount;
    fullname = widget.fullname;
    reasons = widget.reasons;
    avatar = widget.avatar;
    save = widget.save;

    print("chect save ${save}");
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text("Confirm Debit Transaction",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            child: IconButton(
                          icon: Icon(Icons.cancel),
                          color: HexColor("#E8E8E8"),
                          onPressed: () => Navigator.pop(context),
                        )),
                      ],
                    )),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 1.6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 3.3,
                    ),
                    WalletLuxpay(
                      balance: walletBalance ?? '0.0',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: avatar == null
                          ? Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: grey4,
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: white,
                                  )),
                            )
                          : CircleAvatar(
                              radius: 30.5,
                              backgroundImage: NetworkImage("${avatar}"),
                              backgroundColor: Colors.transparent,
                            ),
                    ),
                    SizedBox(height: 10),
                    earningStatus("USERNAME", "${username ?? 'N/A'}"),
                    SizedBox(height: 10),
                    earningStatus("FULLNAME", "${fullname ?? 'N/A'}"),
                    SizedBox(height: 10),
                    earningStatus("AMOUNT",
                        "${amount?.replaceAllMapped(reg, mathFunc) ?? 'N/A'}"),
                    SizedBox(height: 10),
                    earningStatus(
                        "REASON FOR WITHDRAWAL", "${reasons ?? 'N/A'}"),
                 
                    SizedBox(height: 50),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                                onTap: () {
                                  checkBalance(context);
                                },
                                child: luxButton(HexColor("#D70A0A"),
                                    Colors.white, "Pay", 20,
                                    fontSize: 16, height: 50, radius: 8)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Container(
                          //     child: Image.asset(
                          //   "assets/fprint.png",
                          //   height: 50,
                          //   width: 50,
                          //   fit: BoxFit.cover,
                          // )),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget earningStatus(status, value) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          // SizedBox(height: 1),
          Text(value, textAlign: TextAlign.center)
        ],
      ),
    );
  }

  Future<bool> getWallets() async {
    try {
      var response = await dio.get(
        "/wallet/",
      );
      debugPrint('${response.statusCode}');

      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await AboutWallet.fromJson(data);
        setState(() {
          checkdata = true;
          // walletInfo = walletData.data.wallet.balance;

          walletBalance = walletData.data.balance;
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

  void checkBalance(BuildContext context) async {
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

      var response = await getWallets();
      if (response) {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransactionPinTransfer(
                    username: username,
                    amount: amount,
                    reasons: reasons,
                    save: save)));
      }
    });
  }
}
