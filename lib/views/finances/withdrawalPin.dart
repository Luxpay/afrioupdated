import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/DioServices/dio_client.dart';
import '../../models/errors/authError.dart';
import '../../models/successfullWallet.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';
import '../../widgets/pin_entry.dart';
import '../crowd365/numberic_pad.dart';
import '../paymentMethod/congratulation_withdrawal.dart';

class WithdrawalPin extends StatefulWidget {
  final String? beneficiaryAccountNumber, amount, reasons, save, bankCode;
  const WithdrawalPin(
      {Key? key,
      required this.beneficiaryAccountNumber,
      required this.amount,
      required this.reasons,
      required this.save,
      required this.bankCode})
      : super(key: key);

  @override
  State<WithdrawalPin> createState() => _WithdrawalPinState();
}

class _WithdrawalPinState extends State<WithdrawalPin> {

  String? errors;
  String? beneficiaryAccountNumber, amount, reasons, save, status, bankCode;
  String? successfullAmount, from, to, fee, accountNumber, bankName;
  DateTime? date;
   String number = "";

  @override
  void initState() {
    super.initState();

    beneficiaryAccountNumber = widget.beneficiaryAccountNumber;
    amount = widget.amount;
    reasons = widget.reasons;
    bankCode = widget.bankCode;
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

    var res = await bankWithdrawal(confirmPin);
    // create a scaffold messenger that displays res as text
    print(res);
    if (!res) {
 
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$errors")));
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CongratulationOnWithdrawal(
              amount: successfullAmount,
              from: from,
              to: to,
              fee: fee,
              accountNumber: accountNumber,
              bankName: bankName,
              status: status,
              date: date)));
    }
  }

  Future<bool> bankWithdrawal(confirmPin) async {
    try {
      if (confirmPin == null) {
        errors = "Enter your pin";
      }
      Map<String, dynamic> body = {
        "account_number": beneficiaryAccountNumber,
        "bank_code": bankCode,
        "amount": amount,
        "description": reasons ?? "",
        "save": save ?? 'false',
        "pin": confirmPin
      };

      var response = await dio.post(
        "/finances/withdraw/",
        data: body,
      );

      if (response.statusCode == 200) {
        var data = response.data;

        var transDetals = await SuccesfullWalletTransfer.fromJson(data);
        var arr = transDetals.data.amount.split('.');
        var amount = arr[0];
        from = transDetals.data.data.from;
        to = transDetals.data.data.to;
        successfullAmount = amount;
        date = transDetals.data.createdAt;
        fee = transDetals.data.fee;
        accountNumber = "luxpay";
        bankName = "luxpay";
        status = transDetals.data.status;
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
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
