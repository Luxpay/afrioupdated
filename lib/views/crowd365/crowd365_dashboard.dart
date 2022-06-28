import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';


import '../../models/crowd36model.dart';
import '../../models/errors/refferal.dart';
import '../../networking/dio.dart';
import '../../utils/constants.dart';
import '../../widgets/methods/showDialog.dart';
import 'crowd365_referral_code.dart';

class Crowd365Dashboard extends StatefulWidget {
  static const String path = "crowd365Dashboard";

  const Crowd365Dashboard({Key? key}) : super(key: key);

  @override
  State<Crowd365Dashboard> createState() => _Crowd365DashboardState();
}

class _Crowd365DashboardState extends State<Crowd365Dashboard> {
  DioCacheManager? _dioCacheManager;
  var errors;
  bool can_withdraw = false;
  int? direct, indirect, cycles, refLest;
  String? total, today, payout, referral_code, name, price, price_currency;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crowd365_dashBoard();
  }

  @override
  Widget build(BuildContext context) {
    var errors;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: crowd365_dashBoard,
        color: HexColor("#415CA0"),
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
                        onPressed: () => {Navigator.pop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new),
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2.4,
                      ),
                      const Text(
                        "Crowd 365",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => {_crow365ReferralCodeBottomSheet(context)},
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
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: SizeConfig.safeBlockVertical! * 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: HexColor("#415CA0"),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: earnings(
                                    "Today’s Earning", "${today ?? 0}"),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: SizeConfig.safeBlockVertical! * 3,
                                ),
                                height: double.infinity,
                                width: 0.7,
                                decoration: BoxDecoration(
                                  color: HexColor("#DADADA"),
                                ),
                              ),
                              Expanded(
                                child:
                                    earnings("Total Earning", "${total ?? 0}"),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statusCircles("${direct ?? 0}", "Direct Ref"),
                            statusCircles("${indirect ?? 0}", "Indirect Ref"),
                            statusCircles("${cycles ?? 0}", "Cycles"),
                            statusCircles("${refLest ?? 0}", "Ref Left"),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical! * 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: can_withdraw == false
                                    ? button(
                                        title: "cash out",
                                        hexColor: "#415CA0",
                                        active: false)
                                    : button(
                                        title: "Cash out",
                                        hexColor: "#415CA0",
                                        onTap: () async {
                                          var cashoutResult = await cashOut();
                                          if (cashoutResult) {
                                            showChoiceDialog(
                                                context, "Successfull","Crowd365");
                                          } else {
                                            showChoiceDialog(context, errors,"Crowd365");
                                          }
                                        })),
                            button(
                                title: "Renew",
                                hexColor: "#415CA0",
                                active: false),
                            button(
                              title: "Upgrade",
                              hexColor: "#22B02E",
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0)
                          .add(EdgeInsets.only(
                        top: 25,
                      )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Earning History",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "See all",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: HexColor("#8D9091"),
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No history",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: HexColor("#CCCCCC"),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.safeBlockVertical! * 12,
                                  ),
                                  InkWell(
                                    onTap: () => {
                                      _crow365ReferralCodeBottomSheet(context)
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          SizeConfig.blockSizeHorizontal! * 40,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: HexColor("#CCCCCC"),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        "Invite friends",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: HexColor("#CCCCCC"),
                                          fontWeight: FontWeight.w700,
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
      )),
    );
  }

  Widget button(
      {required String title,
      required String hexColor,
      VoidCallback? onTap,
      bool active = true}) {
    return Container(
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
        "/api/v1/crowd365/withdraw/",
      );
      //GCLV9M
      debugPrint("${response.statusCode}");
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint("Cashout : ${data}");
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        if (e.response?.statusCode == 400) {
          errors = "Something Went wrong";
          return false;
        } else if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          showChoiceDialog(context, errors,"Crowd365");
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

  Future<bool> crowd365_dashBoard() async {
    try {
      final storage = new FlutterSecureStorage();

      _dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 7),
          forceRefresh: true,
          options: Options(headers: {
            'Authorization':
                'Bearer ${await storage.read(key: authToken) ?? ""}'
          }));
      Dio _dio = Dio();
      _dio.interceptors.add(_dioCacheManager!.interceptor);
      var response = await _dio.get(
        base_url + "/api/v1/crowd365/",
        options: _cacheOptions,
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var crowd365Data = await Crowd365Db.fromJson(data);
        // notedBashBoad();

        setState(() {
          can_withdraw = crowd365Data.data.canWithdraw;
          total = crowd365Data.data.earnings.total;
          today = crowd365Data.data.earnings.today;
          direct = crowd365Data.data.referrals.direct;
          indirect = crowd365Data.data.referrals.indirect;
          cycles = crowd365Data.data.cycles;
          payout = crowd365Data.data.payout;
          referral_code = crowd365Data.data.referralCode;
          name = crowd365Data.data.plan.name;
          price = crowd365Data.data.plan.price;
          price_currency = crowd365Data.data.plan.priceCurrency;

          refLest = 6 - direct! + indirect!;
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          errors = "Network issue, Try Again";
          showChoiceDialog(context, errors,"Crowd365");
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
          return Crowd365ReferralCode(referralCode: referral_code);
        });
  }
}
