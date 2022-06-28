import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/aboutUser.dart';
import 'package:luxpay/models/walletsModel.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/finances.dart';
import 'package:luxpay/views/notifications/notificationsPage.dart';
import 'package:luxpay/views/rechargeAndBills/airtime.dart';
import 'package:luxpay/views/rechargeAndBills/bill_payment_page.dart';
import 'package:luxpay/widgets/alertDialog/alert_helper.dart';
import 'package:luxpay/widgets/home_page_menu.dart';
import '../models/crowd36model.dart';
import '../models/errors/refferal.dart';
import '../networking/dio.dart';
import '../services/local_notification_service.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/sizeConfig.dart';
import '../widgets/touchUp.dart';
import '../widgets/wallet_balance.dart';
import 'crowd365/crowd365.dart';
import 'crowd365/crowd365_dashboard.dart';
import 'request_money_from_others.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  bool notify = false;
  String time = "Good Day";
  String? username, userAvatar;
  var errors;
  String? packageName;

  List? walletInfo;
  bool checkdata = false;
  DioCacheManager? _dioCacheManager;
  Timer? _timer;

  //final List<Color> colors = <Color>[blue1, , yellow1, red1];

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      setState(() {
        time = 'Good Morning';
      });
      return 'Good Morning';
    }
    if (hour < 17) {
      setState(() {
        time = 'Good Afternoon';
      });
      return 'Good Afternoon';
    }
    setState(() {
      time = 'Good Evening';
    });
    return 'Evening';
  }

  @override
  void initState() {
    getWallets();
    aboutUser();

    greeting();
    LocalNotificationService.initialize(context);
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.dismiss();

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        setState(() {
          notify = true;
        });
        print(message);
        LocalNotificationService.display(message);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        setState(() {
          notify = true;
        });
        print("message title ${message.notification!.title}");
        print("message body ${message.notification!.body}");
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NotificationPage()));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.dismiss();
    username = null;
    userAvatar = null;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      EasyLoading.dismiss();
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

    SizeConfig().init(context);
    return RefreshIndicator(
      onRefresh: getWallets,
      child: SingleChildScrollView(
        child: WillPopScope(
          onWillPop: _willPopCallback,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 500,
                    width: double.infinity,
                    color: HexColor("#771313")),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 170),
                  height: 900,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: SizeConfig.safeBlockVertical! * 1,
                                  ),
                                  Container(
                                    child: userAvatar == null
                                        ? Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: grey4,
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 30,
                                                  color: white,
                                                )),
                                          )
                                        : CircleAvatar(
                                            radius: 30.5,
                                            backgroundImage:
                                                NetworkImage("${userAvatar}"),
                                            backgroundColor: Colors.transparent,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 2,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hello 👋🏿, ${time} !",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      username ?? "Loading...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color: white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  margin: EdgeInsets.only(left: 20, top: 5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: notify == false
                                          ? Color.fromARGB(255, 114, 13, 6)
                                          : Colors.red),
                                ),
                                IconButton(
                                    onPressed: () {
                                      EasyLoading.dismiss();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const NotificationPage()));
                                      setState(() {
                                        notify = false;
                                      });
                                    },
                                    icon: const Icon(IconlyLight.notification,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    Container(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: checkdata == false ? 1 : walletInfo!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20),
                            child: WalletBalance(
                              balance: checkdata == false
                                  ? "0.000000"
                                  : walletInfo![index].balance,
                              currency: checkdata == false
                                  ? "N"
                                  : walletInfo![index].balanceCurrency,
                            ),
                          );
                        },
                      ),
                    )

                        //child: WalletBalance(),
                        ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    //Finances
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            const Text(
                              "Finances",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MenuWidget(
                                    menuName: "FundTag",
                                    imageName: "assets/fund-tag.png"),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            body: const FinancesPage()),
                                      ),
                                    ),
                                  },
                                  child: MenuWidget(
                                      menuName: "Transfer",
                                      imageName: "assets/transfer.png"),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                            body: const FinancesPage()),
                                      ),
                                    ),
                                  },
                                  child: MenuWidget(
                                      menuName: "Withdraw",
                                      imageName: "assets/withdraw.png"),
                                ),
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ReceiveMoneyFromOthers()))
                                  },
                                  child: MenuWidget(
                                      menuName: "Request",
                                      imageName: "assets/request.png"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 3.5,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [

                            //   ],
                            // ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.9,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    //Crowdfunding & Donations
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(left: 33.0, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            const Text(
                              "Crowdfunding & Donations",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    EasyLoading.show(status: 'loading...');
                                    var checkCrowd365 =
                                        await crowd365_dashBoard();

                                    if (checkCrowd365) {
                                      EasyLoading.dismiss();
                                      if (packageName != null) {
                                        EasyLoading.dismiss();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Crowd365Dashboard()));
                                      } else {
                                        EasyLoading.dismiss();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Crowd365()));
                                      }
                                    }
                                  },
                                  child: MenuWidget(
                                      menuName: "Crowd 365",
                                      imageName: "assets/profits.png"),
                                ),
                                InkWell(
                                  onTap: () => {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const RaiseFunds()))
                                    DialogHelper.exit(context)
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 16),
                                    child: MenuWidget(
                                        menuName: "Raise Funds",
                                        imageName: "assets/piggy.png"),
                                  ),
                                ),
                                MenuWidget(
                                    menuName: "Epic",
                                    imageName: "assets/epic.png"),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 3.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    //Recharge & Bill Payments
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35.0, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            const Text(
                              "Recharge & Bill Payments",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Airtime
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Airtime()))
                                  },
                                  child: MenuWidget(
                                    menuName: "Airtime",
                                    imageName: "assets/homeIcons/airtime.png",
                                  ),
                                ),
                                //Electricity
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GenericBillPage(
                                                  title: "Electricity",
                                                  transactionIdHint:
                                                      "Meter number",
                                                  transactionIdInnerHint:
                                                      "Enter meter number",
                                                )))
                                  },
                                  child: MenuWidget(
                                    menuName: "Airtime",
                                    imageName:
                                        "assets/homeIcons/electricity.png",
                                  ),
                                ),
                                //TV
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GenericBillPage(
                                                  title: "TV",
                                                  transactionIdHint:
                                                      "Decoder number",
                                                  transactionIdInnerHint:
                                                      "Enter decoder number",
                                                )))
                                  },
                                  child: MenuWidget(
                                    menuName: "TV",
                                    imageName: "assets/homeIcons/tv.png",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 3.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MenuWidget(
                                  menuName: "Water",
                                  imageName: "assets/homeIcons/water.png",
                                ),
                                MenuWidget(
                                  menuName: "Data Bundle",
                                  imageName: "assets/homeIcons/data.png",
                                ),
                                MenuWidget(
                                  menuName: "Internet",
                                  imageName: "assets/request.png",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 3.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MenuWidget(
                                  menuName: "Betting",
                                  imageName: "assets/homeIcons/betting.png",
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: MenuWidget(
                                    menuName: "Educatiom",
                                    imageName: "assets/homeIcons/edu.png",
                                  ),
                                ),
                                MenuWidget(
                                  menuName: "Transport",
                                  imageName: "assets/homeIcons/transport.png",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 3.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MenuWidget(
                                  menuName: "Pay Ads",
                                  imageName: "assets/homeIcons/ad.png",
                                ),
                                MenuWidget(
                                  menuName: "Event & Ticketing",
                                  imageName: "assets/homeIcons/event.png",
                                ),
                                Container(
                                  width: 46,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 9,
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
    );
  }

  Future<bool> getWallets() async {
    try {
      final storage = new FlutterSecureStorage();
      aboutUser();
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
        base_url + "/api/v1/finance/",
        options: _cacheOptions,
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await MyWallets.fromJson(data);
        setState(() {
          checkdata = true;
          walletInfo = walletData.data;
        });
        debugPrint('Wallet Data : ${walletData.data.length}');

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');
        // var errorData = e.response?.data;
        // var errorMessage = await ErrorMessages.fromJson(errorData);
        // errors = errorMessage.errors.message;
        return false;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('${e}');
      return false;
    }
  }

  Future<bool> aboutUser() async {
    try {
      final storage = new FlutterSecureStorage();
      DioCacheManager dioCacheManager;
      dioCacheManager = DioCacheManager(CacheConfig());
      Options _cacheOptions = buildCacheOptions(Duration(days: 7),
          forceRefresh: true,
          options: Options(headers: {
            'Authorization':
                'Bearer ${await storage.read(key: authToken) ?? ""}'
          }));
      Dio _dio = Dio();
      _dio.interceptors.add(dioCacheManager.interceptor);
      var response = await _dio.get(
        base_url + "/api/user/",
        options: _cacheOptions,
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var user = await AboutUser.fromJson(data);
        setState(() {
          userAvatar = user.data.avatar;
          username = user.data.username;

          debugPrint("Image ${userAvatar}");
          debugPrint("name ${username}");
        });

        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(' Error: ${e.response?.data}');

        // var errorData = e.response?.data;
        // var errorMessage = await ErrorMessages.fromJson(errorData);
        // errors = errorMessage.errors.message;
        return false;
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
      var response = await dio.get(
        base_url + "/api/v1/crowd365/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var crowd365Data = await Crowd365Db.fromJson(data);
        setState(() {
          packageName = crowd365Data.data.plan.name;
        });
        EasyLoading.dismiss();
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          EasyLoading.dismiss();
          errors = "Network issue, Try Again";
          _showChoiceDialog(context, errors);
          return false;
        } else {
          EasyLoading.dismiss();
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

  Future<void> _showChoiceDialog(BuildContext context, content) async {
    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Crowd365",
              ),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK")),
              ],
              content: Text(content));
        });
  }
}
