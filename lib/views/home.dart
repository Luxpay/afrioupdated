import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/podos/user.dart';
import 'package:luxpay/services/notification_database.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/finances.dart';
import 'package:luxpay/views/myProfits/crowd365.dart';
import 'package:luxpay/views/notifications/notificationsPage.dart';
import 'package:luxpay/views/raiseFunds.dart';
import 'package:luxpay/views/rechargeAndBills/airtime.dart';
import 'package:luxpay/views/rechargeAndBills/bill_payment_page.dart';

import '../podos/notifications.dart';
import '../services/local_notification_service.dart';
import '../utils/colors.dart';
import '../utils/sizeConfig.dart';
import '../widgets/touchUp.dart';
import '../widgets/wallet_balance.dart';
import 'request_money_from_others.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";

  @override
  void initState() {
    LocalNotificationService.initialize(context);
    User.getFromPrefs().then((user) {
      setState(() {
        name = user.full_name ?? "";
      });
    });
    super.initState();

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message);
       
      }
    });
    

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
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
  Widget build(BuildContext context) {
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

    SizeConfig().init(context);
    return SingleChildScrollView(
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
                                const CircleAvatar(
                                  radius: 22.5,
                                  backgroundImage: NetworkImage(
                                      'https://via.placeholder.com/150'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal! * 2,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Hiya 👋🏿, good morning !",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: HexColor("#8D9091")),
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () => {
                              
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NotificationPage()))
                                },
                            icon: const Icon(IconlyLight.notification,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: WalletBalance(),
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
                          color: Colors.grey.withOpacity(0.2),
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
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/fund-tag.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "FundTag",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Scaffold(body: const FinancesPage()),
                                    ),
                                  ),
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/transfer.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Transfer",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Scaffold(body: const FinancesPage()),
                                    ),
                                  ),
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/withdraw.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Withdraw",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ReceiveMoneyFromOthers()))
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/request.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Request",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
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
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35.0, right: 35),
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
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RaiseFunds()))
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/piggy.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Raise Funds",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Crowd365()))
                                },
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/profits.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Crowd 365",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/epic.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Epic",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
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
                    color: Colors.white,
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
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/homeIcons/airtime.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Airtime",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
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
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/homeIcons/electricity.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Electricity",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
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
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/homeIcons/tv.png",
                                      width: 46,
                                      height: 47,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "TV",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
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
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/water.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Water",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/data.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Data Bundle",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/request.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Internet",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical! * 3.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/betting.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Betting",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/edu.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Educatiom",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/transport.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Transport",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.safeBlockVertical! * 3.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/ad.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Pay Ads",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    "assets/homeIcons/event.png",
                                    width: 46,
                                    height: 47,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Event & Ticketing",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
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
    );
  }
}
