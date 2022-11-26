import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/DioServices/dio_client.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/views/paymentMethod/congratulation_luxpay.dart';
import 'package:luxpay/widgets/methods/showDialog.dart';
import '../../models/errors/authError.dart';
import '../../models/successfullWallet.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../crowd365/numberic_pad.dart';

class TransactionPinTransfer extends StatefulWidget {
  final String? username, amount, reasons, save;

  const TransactionPinTransfer(
      {Key? key,
      required this.username,
      required this.amount,
      required this.reasons,
      required this.save})
      : super(key: key);

  @override
  State<TransactionPinTransfer> createState() => _TransactionPinTransferState();
}

class _TransactionPinTransferState extends State<TransactionPinTransfer> {
  String number = "";
  String? username, amount, reasons, save;
  String? successfullAmount, from, to, status, fee;
  DateTime? date;
  var errors;

  @override
  void initState() {
    super.initState();

    username = widget.username;
    amount = widget.amount;
    reasons = widget.reasons;
    save = widget.save;
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
                                  _fetchData(context, confirmPin: pinCode);
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

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 55,
        height: 55,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            border: Border.all(
              color: grey5,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fetchData(BuildContext context, {confirmPin}) async {
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

    // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
    // await Future.delayed(const Duration(seconds: 3));

    var res = await transferToLuxPay(confirmPin);
    // create a scaffold messenger that displays res as text
    debugPrint('$res');
    if (!res) {
      Navigator.of(context).pop();
      showErrorDialog(
          context, errors ?? "Something went wrong\ntry again", "LuxPay");
    } else {
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TopUpCongratulation(
                  amount: successfullAmount,
                  from: from,
                  to: to,
                  fee: fee,
                  status: status,
                  date: date)));
    }
  }

  Future<bool> transferToLuxPay(confirmPin) async {
    try {
      if (confirmPin == null) {
        errors = "Enter your pin";
      }
      Map<String, dynamic> body = {
        "username": username,
        "amount": amount,
        "description": reasons ?? "",
        "save": true,
        "pin": confirmPin
      };

      var response = await dio.post(
        "/wallet/transfer/",
        data: body,
      );

      if (response.statusCode == 200) {
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
      debugPrint("401");
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          Navigator.of(context).pop();
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
        Navigator.of(context).pop();
        errors = errorMessage;
        showErrorDialog(context, errors!, "Luxpay");

        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
