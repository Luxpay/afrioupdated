import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/invite_earn.dart';
import 'package:luxpay/views/refer&earn/refer_earn.dart';
import '../models/errors/authError.dart';
import '../models/errors/referEarn_ds.dart';
import '../networking/DioServices/dio_client.dart';
import '../networking/DioServices/dio_errors.dart';
import '../utils/hexcolor.dart';
import '../utils/sizeConfig.dart';
import '../widgets/lux_buttons.dart';
import '../widgets/methods/showDialog.dart';
import '../widgets/touchUp.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key? key}) : super(key: key);

  @override
  State<ReferAndEarn> createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  var statusCode;
  var errors;
  var confirm;
  var checkData;

  Future<bool> _willPopCallback() async {
    showDialog(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.black,
            alignment: Alignment.center,
            child: popUp(context),
          );
        });
    return true; // return true if the route to be popped
  }


  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "Refer and Earn",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Stack(
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
                                  margin:
                                      EdgeInsets.only(left: 50, bottom: 130),
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
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 3,
                                    ),
                                    Text(
                                        "LuxPay Users can earn two types of referral bonuses.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 15)),
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 2,
                                    ),
                                    Text(
                                      "Instant N500 Commission",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 1,
                                    ),
                                    Text(
                                      " Get free N500 cash when your friends register and perform transactions on Refer and Earn using your Referral ID/link.",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 1,
                                    ),
                                    Text(
                                      " The more you refer, the more you earn.",
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 2,
                                    ),
                                    Text(
                                      "  Get 10% Instant Commission on Crowd365 Refer Program",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 1,
                                    ),
                                    Text(
                                      "When Your Referrals Subscribes to any of the packages  on Crowd365, You immediately get a 10% Bonus on your Subscribers",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.safeBlockVertical! * 1,
                                    ),
                                    Text(
                                      "Example:- (You can get up to N600 on a N6,000 package on Crowd365 from referrals)",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: InkWell(
                        onTap: () {
                          _fetchReferEarn(context);
                        },
                        child: Container(
                          child: luxButton(HexColor("#D70A0A"), Colors.white,
                              "Click here to get started", width,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 6,
                ),
              ],
            ),
          )),
    );
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
      if (checkData.isEmpty) {
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
        "/refer-earn/",
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
