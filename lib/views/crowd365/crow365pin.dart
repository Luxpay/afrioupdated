import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/errors/authError.dart';
import '../../models/successfullWallet.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/colors.dart';
import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/methods/showDialog.dart';
import 'crowd365_dashboard.dart';
import 'numberic_pad.dart';

class Crowd365Pin extends StatefulWidget {
  final String? name;
  const Crowd365Pin({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  State<Crowd365Pin> createState() => _Crowd365PinState();
}

class _Crowd365PinState extends State<Crowd365Pin> {
  String codePinNumber = "";
  var errors, namePackage;
  String? successfullAmount, from, to, status, fee;
  DateTime? date;

  @override
  void initState() {
    codePinNumber = '';
    namePackage = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: grey1,
        title: Text(
          "Transaction Pin",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 2,
                ),
                Text(
                  "Enter your transaction pin below to authorize your payment, for Crowd365 ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 8,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildCodeNumberBox(codePinNumber.length > 0
                    ? codePinNumber.substring(0, 1)
                    : ""),
                buildCodeNumberBox(codePinNumber.length > 1
                    ? codePinNumber.substring(1, 2)
                    : ""),
                buildCodeNumberBox(codePinNumber.length > 2
                    ? codePinNumber.substring(2, 3)
                    : ""),
                buildCodeNumberBox(codePinNumber.length > 3
                    ? codePinNumber.substring(3, 4)
                    : ""),
              ],
            ),
          ),
          NumericPad(
            onNumberSelected: (value) {
              setState(() {
                if (value != -1) {
                  if (value.toString().length != 4) {
                    codePinNumber = codePinNumber + value.toString();

                    if (codePinNumber.toString().length == 4) {
                      debugPrint("Complete $codePinNumber");

                      comfirmPayment(context,
                          packageName: namePackage, pin: codePinNumber);
                      codePinNumber = '';
                    }
                  }
                } else {
                  codePinNumber =
                      codePinNumber.substring(0, codePinNumber.length - 1);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            border: Border.all(
              color: grey8,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
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

  Future<bool> packageSelected({String? name, String? pin}) async {
    final storage = new FlutterSecureStorage();
    String referrer = await storage.read(key: "Crowd365ReferalCode") ?? "";
    print(name);
    //YTIQLW
    Map<String, dynamic> body = {
      "package": name,
      "pin": pin,
      "username": referrer
    };
    if (referrer == '') {
      body.remove('username');
    }
    debugPrint("Package Selected : $body");
    try {
      var response = await dio.post(
        "/crowd365/subscribe/",
        data: body,
      );
      //GCLV9M
      debugPrint("${response.statusCode}");
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
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
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
        showErrorDialog(context, errors, "Crowd365");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void comfirmPayment(BuildContext context, {packageName, pin}) async {
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
                children: [
                  // The loading indicator
                  CircularProgressIndicator(
                    color: HexColor("#415CA0"),
                  ),
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

    var res = await packageSelected(name: packageName, pin: pin);
    // create a scaffold messenger that displays res as text
    print(res);
    if (!res) {
      Navigator.of(context).pop();
      showErrorDialog(context, errors, "Crowd365");
    } else {
      Navigator.of(context).pop();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Crowd365Dashboard()));
      //Navigator.of(context).pop();
    }
  }
}
