import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:luxpay/models/crowd365_cashout.dart';
import 'package:luxpay/models/errors/authError.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/crowd365/crow365pin.dart';
import 'package:luxpay/views/crowd365/crowd365upgrade_package.dart';
import 'package:luxpay/views/page_controller.dart';

import '../../models/aboutUser.dart';
import '../../models/crowd36model.dart';
import '../../models/cycle.dart';
import '../../models/errors/refferal.dart';
import '../../networking/DioServices/dio_client.dart';
import '../../networking/DioServices/dio_errors.dart';
import '../../utils/constants.dart';
import '../../widgets/methods/showDialog.dart';
import 'crowd365_referral_code.dart';
import 'package:flutter/services.dart';

class Crowd365Dashboard extends StatefulWidget {
  static const String path = "crowd365Dashboard";
  final String? from;

  const Crowd365Dashboard({Key? key, this.from}) : super(key: key);

  @override
  State<Crowd365Dashboard> createState() => _Crowd365DashboardState();
}

class _Crowd365DashboardState extends State<Crowd365Dashboard> {
  var errors;
  bool can_withdraw = false;
  var refLest;
  int? direct, indirect, cycles;
  List<History> directRef = [];

  var amount;
  String? total,
      today,
      payout,
      referral_code,
      name,
      price,
      price_currency,
      username;
  var checckData;

  bool isActive = true;

  Future refreshChecks() async {
    await crowd365_dashBoard();
    await crowd365_dashBoardCycle();
    await aboutUser();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      crowd365_dashBoard();
      crowd365_dashBoardCycle();
      aboutUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      // Reset SystemUiOverlayStyle for PageOne.
      // If this is not set, the status bar will use the style applied from another route.
      value: SystemUiOverlayStyle(
        statusBarColor: HexColor("#415CA0"),
        statusBarBrightness: Brightness.light,
      ),
      child: RefreshIndicator(
        onRefresh: refreshChecks,
        color: HexColor("#415CA0"),
        child: Scaffold(
            body: SafeArea(
          child: checckData == null
              ? Center(
                  child: CircularProgressIndicator(
                  color: HexColor("#415CA0"),
                ))
              : SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height + 20,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (widget.from == 'home') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppPageController()));
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    icon: const Icon(Icons.arrow_back_ios_new),
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width:
                                        SizeConfig.safeBlockHorizontal! * 2.4,
                                  ),
                                  const Text(
                                    "Crowd365",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () =>
                                    {_crow365ReferralCodeBottomSheet(context)},
                                child: Container(
                                  margin: EdgeInsets.only(right: 30),
                                  child: Text(
                                    "Referral Code",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: HexColor("#8D9091"),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height:
                                          SizeConfig.safeBlockVertical! * 12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: HexColor("#415CA0"),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                1), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: earnings("Today’s Earning",
                                                "N${today ?? 0}"),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: SizeConfig
                                                      .safeBlockVertical! *
                                                  3,
                                            ),
                                            height: double.infinity,
                                            width: 0.7,
                                            decoration: BoxDecoration(
                                              color: HexColor("#DADADA"),
                                            ),
                                          ),
                                          Expanded(
                                            child: earnings("Total Earning",
                                                "N${total ?? 0}"),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 3,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        statusCircles(
                                            "${direct ?? 0}", "Direct Ref"),
                                        statusCircles(
                                            "${indirect ?? 0}", "Indirect Ref"),
                                        statusCircles(
                                            "${cycles ?? 0}", "Cycles"),
                                        statusCircles(
                                            "${refLest ?? 0}", "Ref Left"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            child: can_withdraw == false
                                                ? button(
                                                    title: "cash out",
                                                    hexColor: "#415CA0",
                                                    active: false)
                                                : button(
                                                    title: "Cash out",
                                                    active: true,
                                                    hexColor: "#415CA0",
                                                    onTap: () {
                                                      cashOutFetch(context);
                                                    })),
                                        Container(
                                          child: isActive == true
                                              ? button(
                                                  title: "Renew",
                                                  hexColor: "#415CA0",
                                                  active: false)
                                              : button(
                                                  title: "Renew",
                                                  hexColor: "#415CA0",
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Crowd365Pin(
                                                                    name:
                                                                        name)));
                                                  },
                                                  active: true),
                                        ),
                                        Container(
                                          child: isActive == true
                                              ? button(
                                                  title: "Upgrade",
                                                  hexColor: "#415CA0",
                                                  active: false)
                                              : button(
                                                  title: "Upgrade",
                                                  hexColor: "#22B02E",
                                                  active: true,
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Crowd365PackagesUpgrade(
                                                                  price: price,
                                                                )));
                                                  }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: SizeConfig.blockSizeVertical! * 5,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.3),
                                thickness: 15,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0)
                                      .add(EdgeInsets.only(
                                    top: 25,
                                  )),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Direct Referral History",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 HistoryofReferral(
                                          //                     direct:
                                          //                         directRef)));
                                          //   },
                                          //   child: Text(
                                          //     "See all",
                                          //     style: TextStyle(
                                          //       fontSize: 14,
                                          //       color: HexColor("#8D9091"),
                                          //       fontWeight: FontWeight.w700,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                      Expanded(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                //color: Colors.red,
                                                child: directRef.isNotEmpty
                                                    ? ListView.separated(
                                                        separatorBuilder:
                                                            (BuildContext
                                                                        context,
                                                                    int
                                                                        index) =>
                                                                Divider(
                                                                    height: 1),
                                                        itemCount:
                                                            directRef.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var ref =
                                                              directRef[index];

                                                          return ListTile(
                                                            title: Text(
                                                                '${ref.username}'),
                                                          );
                                                        })
                                                    : Text(
                                                        "No history",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: HexColor(
                                                              "#CCCCCC"),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                              ),
                                              SizedBox(
                                                height: SizeConfig
                                                        .safeBlockVertical! *
                                                    2,
                                              ),
                                              InkWell(
                                                onTap: () => {
                                                  _crow365ReferralCodeBottomSheet(
                                                      context)
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: SizeConfig
                                                          .blockSizeHorizontal! *
                                                      40,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          HexColor("#CCCCCC"),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    "Invite friends",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          HexColor("#CCCCCC"),
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        )),
      ),
    );
  }

  Widget button(
      {required String title,
      required String hexColor,
      VoidCallback? onTap,
      bool active = true}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 28,
        width: SizeConfig.blockSizeHorizontal! * 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: active ? HexColor(hexColor) : HexColor("#E2E2E2"),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget statusCircles(String amount, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: grey2.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Text(
            amount,
            style: TextStyle(
              fontSize: 16,
              color: HexColor("#8D9091"),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 0.5,
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget earnings(String title, String amount) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical! * 0.5,
          ),
          Text(
            "$amount",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> cashOut() async {
    try {
      var response = await dio.post(
        "/crowd365/withdraw/",
      );
      //GCLV9M
      debugPrint("${response.statusCode}");
      if (response.statusCode == 200) {
        var data = response.data;
        var cashOutData = await CashOut.fromJson(data);
        amount = cashOutData.data.amount;

        debugPrint("Cashout : ${data}");
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
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
        showErrorDialog(context, errors, "Crowd365");
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> crowd365_dashBoard() async {
    try {
      var response = await dio.get(
        "/crowd365/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var crowd365Data = await Crowd365Db.fromJson(data);
        // notedBashBoad();
        checckData = crowd365Data.data;

        setState(() {
          can_withdraw = crowd365Data.data[0].canWithdraw;
          total = crowd365Data.data[0].earnings.total
              .replaceAllMapped(reg, mathFunc);
          today = crowd365Data.data[0].earnings.today
              .replaceAllMapped(reg, mathFunc);
          directRef = crowd365Data.data[0].history;
          direct = crowd365Data.data[0].history.length;
          if (crowd365Data.data[0].history.isNotEmpty) {
            int? refOne, refTwo;
            if (crowd365Data.data[0].history[0].referrals.isNotEmpty) {
              //indirect = crowd365Data.data[0].history[0].referrals.length;
              refOne = crowd365Data.data[0].history[0].referrals.length;
              refTwo = crowd365Data.data[0].history[1].referrals.length;
              indirect = refOne + refTwo;
            }
          }
          isActive = crowd365Data.data[0].isActive;
          name = crowd365Data.data[0].package.name;
          price = crowd365Data.data[0].package.price;
          price_currency = "N";
          refLest = 6 - ((direct ?? 0) + (indirect ?? 0));
          debugPrint("History lent : $direct");
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await ReferralError.fromJson(errorData);
          errors = errorMessage.errors.extra.error[0];
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> crowd365_dashBoardCycle() async {
    try {
      var response = await dio.get(
        "/crowd365/cycles/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var crowd365DataCycle = await CycleCrowd365.fromJson(data);

        setState(() {
          cycles = crowd365DataCycle.data.cycles;
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          showExpiredsessionDialog(
              context, "Please Login again\nThanks", "Expired Session");
          return false;
        } else {
          var errorData = e.response?.data;
          var errorMessage = await ReferralError.fromJson(errorData);
          errors = errorMessage.errors.extra.error[0];
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void _crow365ReferralCodeBottomSheet(context) {
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
          return Crowd365ReferralCode(referralCode: username);
        });
  }

  Future<bool> aboutUser() async {
    var response = await dio.get(
      "/user/profile/",
    );
    debugPrint('Data Code ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');
        var user = await AboutUser.fromJson(data);
        username = user.data.username;
        debugPrint("name ${username}");
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        return false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  void cashOutFetch(BuildContext context, {packageName, pin}) async {
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

    var cashoutResult = await cashOut();
    if (cashoutResult) {
      Navigator.of(context).pop();
      showErrorDialog(
          context,
          "Congratulation!!! Successfully Cashout N$amount \nThanks.",
          "Crowd365");
    } else {
      Navigator.of(context).pop();
      showErrorDialog(context, errors, "Crowd365");
    }
  }
}
