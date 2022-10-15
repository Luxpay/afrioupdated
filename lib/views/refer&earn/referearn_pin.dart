import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/networking/DioServices/dio_client.dart';
import 'package:luxpay/views/refer&earn/successfull_payment.dart';
import '../../models/errors/authError.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/pin_entry.dart';

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
  int? confirmPin;
  int? pin;
  String? errors, tag;
  String? sponsor;

  @override
  void initState() {
    super.initState();
    tag = 'pin';

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
                    Container(
                      child: PinEntry(
                        tag: '$tag',
                        onPinChanged: (v) async {
                          tag = 'confirm';
                          confirmPin = v;
                          if (v.toString().split("").length == 4) {
                            _fetchSub(context,
                                confirmPin: confirmPin, sponsor: sponsor);
                            v = null;
                          }
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
    print(res);
    if (!res) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("$errors")));
    } else {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => PaymentSuccessfull()));
    }
  }

  Future<bool> referearnSub(int? confirmPin, sponsor) async {
    if (confirmPin == null) {
      errors = "Enter your pin";
    }
    Map<String, dynamic> body = {"sponsor": sponsor, "pin": confirmPin};
    if (sponsor == '') {
      body.remove('sponsor');
    }
    try {
      var response = await dio.post(
        "/v1/refer-earn/subscribe/",
        data: body,
      );

      if (response.statusCode == 201) {
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
