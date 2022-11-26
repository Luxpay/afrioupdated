import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/DioServices/dio_client.dart';
import 'package:luxpay/views/refer&earn/referearn_dashboard.dart';
import '../../models/errors/authError.dart';
import '../../models/successfullWallet.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/pin_entry.dart';
import '../crowd365/numberic_pad.dart';

class ReferEarnPin extends StatefulWidget {
  final String? sponsor;
  const ReferEarnPin({
    Key? key,
    required this.sponsor,
  }) : super(key: key);

  @override
  State<ReferEarnPin> createState() => _ReferEarnPinState();
}

class _ReferEarnPinState extends State<ReferEarnPin> {
  String? sponsor;
  String? successfullAmount, from, to, status, fee;
  DateTime? date;
  String number = "";
  var errors;

  @override
  void initState() {
    super.initState();

    sponsor = widget.sponsor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
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
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    const Text(
                      "Transaction Pin",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                      "Enter Transaction Pin",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    Text(
                      "Enter your transaction pin below to authorize your payment. ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 8,
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildCodeNumberBox(
                              number.length > 0 ? number.substring(0, 1) : ""),
                          buildCodeNumberBox(
                              number.length > 1 ? number.substring(1, 2) : ""),
                          buildCodeNumberBox(
                              number.length > 2 ? number.substring(2, 3) : ""),
                          buildCodeNumberBox(
                              number.length > 3 ? number.substring(3, 4) : ""),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 10),
                    Container(
                      child: NumericPad(
                        onNumberSelected: (value) {
                          setState(() {
                            if (value != -1) {
                              if (value.toString().length != 4) {
                                number = number + value.toString();

                                if (number.toString().length == 4) {
                                  debugPrint("Complte");
                                  String pinCode = number;
                                  // comfirmPayment(context,
                                  //     packageName: namePackage, pin: phoneNumber);
                                  _fetchSub(context,
                                      confirmPin: pinCode, sponsor: sponsor);
                                  number = '';
                                }
                              }
                            } else {
                              number = number.substring(0, number.length - 1);
                            }
                          });
                        },
                      ),
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

  void _fetchSub(BuildContext context, {confirmPin, sponsor}) async {
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

    var res = await referearnSub(confirmPin, sponsor);
    // create a scaffold messenger that displays res as text
    debugPrint('$res');
    if (!res) {
      Navigator.of(context).pop();
      showErrorDialog(context, errors, "LuxPay");
    } else {
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReferrerEarningDashoard()));
    }
  }

  Future<bool> referearnSub(confirmPin, sponsor) async {
    if (confirmPin == null) {
      errors = "Enter your pin";
    }
    Map<String, dynamic> body = {"sponsor": sponsor, "pin": confirmPin};
    if (sponsor == '') {
      body.remove('sponsor');
    }
    try {
      var response = await dio.post(
        "/refer-earn/subscribe/",
        data: body,
      );

      if (response.statusCode == 201) {
        var data = response.data;
        var transDetals = await SuccesfullWalletTransfer.fromJson(data);
        from = transDetals.data.data.from;
        to = transDetals.data.data.to;
        successfullAmount = transDetals.data.amount;
        date = transDetals.data.createdAt;
        fee = transDetals.data.fee;
        status = transDetals.data.status;
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        var errorData = e.response?.data;
        var errorMessage = await AuthError.fromJson(errorData);
        debugPrint(' Error: ${errorMessage.message}');
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
}
