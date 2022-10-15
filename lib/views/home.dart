import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/models/aboutUser.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/authPages/create_pin_page.dart';
import 'package:luxpay/views/finances/transfer_toLuxpay.dart';
import 'package:luxpay/views/notifications/notificationsPage.dart';
import 'package:luxpay/widgets/home_page_menu.dart';
import '../models/about_wallet.dart';
import '../models/crowd36model.dart';
import '../models/errors/authError.dart';
import '../networking/DioServices/dio_client.dart';
import '../networking/DioServices/dio_errors.dart';
import '../services/local_notification_service.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/sizeConfig.dart';
import '../widgets/methods/showDialog.dart';
import '../widgets/touchUp.dart';
import '../widgets/wallet_balance.dart';
import 'crowd365/crowd365.dart';
import 'crowd365/crowd365_dashboard.dart';
import 'finances/transfer_withdraw.dart';
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
  var errors;

  bool checkdata = false;
  DioCacheManager? _dioCacheManager;
  String? walletBalance,
      dailyExpense,
      checkPin,
      dailyIncome,
      username,
      userAvatar,
      packageName;

  String? statusCode;
  var crowd365Data;

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

  Future refreshChecks() async {
    await getWallets();
    await aboutUser();
    greeting();
  }

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    // });
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getWallets();
      aboutUser();
      greeting();
     //crowd365_dashBoard();
    });

    LocalNotificationService.initialize(context);
    super.initState();

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
        // sendNotification(
        //     title: message.notification!.title,
        //     body: message.notification!.body);
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
  Widget build(BuildContext context) {
    Future<bool> _willPopCallback() async {
      ;
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

    String capitalizeAllWord(String value) {
      var result = value[0].toUpperCase();
      for (int i = 1; i < value.length; i++) {
        if (value[i - 1] == " ") {
          result = result + value[i].toUpperCase();
        } else {
          result = result + value[i];
        }
      }
      return result;
    }

    String usernameCapital = capitalizeAllWord(username ?? "loading...");

    SizeConfig().init(context);
    return RefreshIndicator(
      onRefresh: refreshChecks,
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
                                      "Hello 👋 \n${time} ! ${usernameCapital}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Colors.white),
                                    ),
                                    // Text(
                                    //   usernameCapital,
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w500,
                                    //       fontSize: 15,
                                    //       color: white),
                                    // )
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
                      child: WalletBalance(
                          balance: walletBalance ?? '0.00',
                          currency: 'N',
                          dIncome: dailyIncome ?? '0.00',
                          dExpense: dailyExpense ?? '0.00'),
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
                              "Finance",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),

                            SizedBox(
                              height: SizeConfig.safeBlockVertical! * 2.9,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TransferToLuxpayAccount()))
                                  },
                                  child: MenuWidget(
                                      menuName: "Lux Tag",
                                      imageName: "assets/fund-tag.png"),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Withdrawal()))
                                  },
                                  child: MenuWidget(
                                      menuName: "Send Money",
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
                                    _fetchCrowd365(context);
                                  },
                                  child: MenuWidget(
                                      menuName: "Crowd 365",
                                      imageName: "assets/profits.png"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const TransactionDetailsPage()));
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const TopUpCongratulation()));
                                      // DialogHelper.exit(context)
                                      underConstruction(context);
                                    },
                                    child: MenuWidget(
                                        menuName: "Raise Funds",
                                        imageName: "assets/piggy.png"),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {underConstruction(context)},
                                  child: MenuWidget(
                                      menuName: "Epic",
                                      imageName: "assets/epic.png"),
                                ),
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const Airtime()))
                                    underConstruction(context),
                                  },
                                  child: MenuWidget(
                                    menuName: "Airtime",
                                    imageName: "assets/homeIcons/airtime.png",
                                  ),
                                ),
                                //Electricity
                                InkWell(
                                  onTap: () => {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const GenericBillPage(
                                    //               title: "Electricity",
                                    //               transactionIdHint:
                                    //                   "Meter number",
                                    //               transactionIdInnerHint:
                                    //                   "Enter meter number",
                                    //             )))
                                    underConstruction(context),
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const GenericBillPage(
                                    //               title: "TV",
                                    //               transactionIdHint:
                                    //                   "Decoder number",
                                    //               transactionIdInnerHint:
                                    //                   "Enter decoder number",
                                    //             )))
                                    underConstruction(context),
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
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Water",
                                    imageName: "assets/homeIcons/water.png",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Data Bundle",
                                    imageName: "assets/homeIcons/data.png",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Internet",
                                    imageName: "assets/request.png",
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
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Betting",
                                    imageName: "assets/homeIcons/betting.png",
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      underConstruction(context);
                                    },
                                    child: MenuWidget(
                                      menuName: "Educatiom",
                                      imageName: "assets/homeIcons/edu.png",
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Transport",
                                    imageName: "assets/homeIcons/transport.png",
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
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Pay Ads",
                                    imageName: "assets/homeIcons/ad.png",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    underConstruction(context);
                                  },
                                  child: MenuWidget(
                                    menuName: "Event & Ticketing",
                                    imageName: "assets/homeIcons/event.png",
                                  ),
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
    final storage = new FlutterSecureStorage();

    _dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 3),
        forceRefresh: true,
        options: Options(headers: {
          'Authorization': 'Bearer ${await storage.read(key: authToken)}'
        }));
    Dio _dio = Dio();
    _dio.interceptors.add(_dioCacheManager!.interceptor);
    var response = await _dio.get(
      base_url + "/wallet/",
      options: _cacheOptions,
    );
    debugPrint('${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('${data}');
        var walletData = await AboutWallet.fromJson(data);

        setState(() {
          checkdata = true;
          // walletInfo = walletData.data.wallet.balance;

          walletBalance = walletData.data.balance;
          checkPin = "${walletData.data.hasPin}";
          dailyIncome = walletData.data.dailySummary.income;
          dailyExpense = walletData.data.dailySummary.expense;
        });

        if (checkPin == 'false') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreatePinPage()));
        }

        debugPrint("wallet balance $walletBalance}");
        debugPrint("wCheck Pin $checkPin}");

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
    final storage = new FlutterSecureStorage();

    DioCacheManager dioCacheManager;
    dioCacheManager = DioCacheManager(CacheConfig());
    Options _cacheOptions = buildCacheOptions(Duration(days: 3),
        forceRefresh: true,
        options: Options(headers: {
          'Authorization': 'Bearer ${await storage.read(key: authToken) ?? ""}'
        }));
    Dio _dio = Dio();
    _dio.interceptors.add(dioCacheManager.interceptor);
    var response = await _dio.get(
      base_url + "/user/profile/",
      options: _cacheOptions,
    );
    debugPrint('Data Code ${response.statusCode}');
    try {
      if (response.statusCode == 200) {
        var data = response.data;
        debugPrint('${response.statusCode}');
        debugPrint('Check Data ${data}');
        var user = await AboutUser.fromJson(data);
        setState(() {
          userAvatar = user.data.avatar;
          username = user.data.username;
        });
        debugPrint("name : ${username}");
        debugPrint("avatar : ${userAvatar}");
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

  Future<bool> crowd365_dashBoard() async {
    try {
      var response = await dio.get(
        "/crowd365/",
      );
      debugPrint('${response.statusCode}');
      if (response.statusCode == 200) {
        var data = response.data;
        crowd365Data = await Crowd365Db.fromJson(data);

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
        showErrorDialog(context, errors, "Crowd365");

        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _fetchCrowd365(BuildContext context) async {
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

      await crowd365_dashBoard();
      if (crowd365Data.data.isEmpty) {
        Navigator.of(context).pop();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Crowd365()));
      } else {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Crowd365Dashboard(from: "home")));
      }
    });
  }
}

void underConstruction(BuildContext context) async {
  // show the loading dialog
  showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: true,
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
                // Some text
                Center(child: Text('Still Under Construction'))
              ],
            ),
          ),
        );
      });
}
