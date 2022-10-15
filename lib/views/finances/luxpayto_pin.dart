import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/DioServices/dio_client.dart';
import 'package:luxpay/views/paymentMethod/congratulation_luxpay.dart';
import '../../models/errors/authError.dart';
import '../../models/successfullWallet.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/pin_entry.dart';

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
  int? confirmPin;
  int? pin;
  String? errors, tag;
  String? username, amount, reasons, save;
  String? successfullAmount, from, to, fee;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    tag = 'pin';
    print(tag);
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
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 25,
                    ),
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
                    PinEntry(
                      tag: '$tag',
                      onPinChanged: (v) async {
                        tag = 'confirm';
                        confirmPin = v;
                        print(tag);
                        if (v.toString().split("").length == 4) {
                          _fetchData(context, confirmPin: confirmPin);
                          v = null;
                        }
                      },
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
    print(res);
    if (!res) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${errors ?? "Something went wrong"}")));
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
                  date: date)));
    }
  }

  Future<bool> transferToLuxPay(int? confirmPin) async {
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
    try {
      var response = await dio.post(
        "/v1/wallets/transfer/",
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
