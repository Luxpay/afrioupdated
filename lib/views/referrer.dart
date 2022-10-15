import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/invite_earn.dart';
import 'package:luxpay/views/refer&earn/refer_earn.dart';
import '../models/errors/authError.dart';
import '../models/errors/referEarn_ds.dart';
import '../networking/DioServices/dio_client.dart';
import '../networking/DioServices/dio_errors.dart';
import '../utils/hexcolor.dart';
import '../widgets/lux_buttons.dart';
import '../widgets/methods/showDialog.dart';

class ReferreAndEarn extends StatefulWidget {
  const ReferreAndEarn({Key? key}) : super(key: key);

  @override
  State<ReferreAndEarn> createState() => _ReferreAndEarnState();
}

class _ReferreAndEarnState extends State<ReferreAndEarn> {
  var statusCode;
  var errors;
  var confirm;
  var checkData;

  @override
  void initState() {
    super.initState();
   
       WidgetsBinding.instance!.addPostFrameCallback((_) {
     referEarn_dashBoard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Refer and Earn",
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          // leading: GestureDetector(
          //   child: const Icon(
          //     Icons.chevron_left,
          //     color: Colors.black,
          //     size: 35,
          //   ),
          //   onTap: Navigator.of(context).pop,
          // ),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 60),
                              child: Image.asset(
                                "assets/star.png",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 60),
                              child: Image.asset(
                                "assets/star.png",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 60),
                              child: Image.asset(
                                "assets/star.png",
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 50, bottom: 130),
                              child: Image.asset(
                                "assets/star.png",
                              ),
                            ),
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Refer and Earn Big",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 15),
                                Text(
                                    "LuxPay Users can earn two types of referral bonuses.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15)),
                                SizedBox(height: 13),
                                Text(
                                  "Instant N500 Commission",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  " Get free N500 cash when your friends register and perform transactions on LuxPay using your Referral ID/link.",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  " The more you refer, the more you earn.",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "  Get 10% Instant Commission on Crowd365 Refer Program",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "When your referrals subscribe to any of the packages on Crowd365, you immediately get a 10% bonus on your investments.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "(You can get up to N5000 on a N50,000 package on Crowd365 from referrals)",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]),
                          Container(
                            margin: EdgeInsets.only(
                              top: 400,
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                child: InkWell(
                                  onTap: () {
                                    _fetchReferEarn(context);
                                  },
                                  child: checkData == null
                                      ? Container(
                                          child: luxButton(HexColor("#D70A0A"),
                                              Colors.white, "Apply now", width,
                                              fontSize: 16),
                                        )
                                      : Container(
                                          child: luxButton(
                                              HexColor("#D70A0A"),
                                              Colors.white,
                                              "Access Dashboard",
                                              width,
                                              fontSize: 16),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55,
              )
            ],
          ),
        ));
  }

  void _fetchReferEarn(BuildContext context) async {
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

      await referEarn_dashBoard();
      if (checkData == null && statusCode == '422') {
        Navigator.of(context).pop();
        _referEarnBottomSheet(context);
      } else {
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const InviteAndEarn()));
      }
    });
  }

  Future<bool> referEarn_dashBoard() async {
    try {
      var response = await dio.get(
        "/v1/refer-earn/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var referEarnData = await ReferEarnDs.fromJson(data);
        setState(() {
          checkData = referEarnData.data;
        });
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
        } else if (e.response?.statusCode == 422) {
          statusCode = "422";
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
        showErrorDialog(context, errors, "Refer and eran");

        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

void _referEarnBottomSheet(context) {
  showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Membership();
      });
}
