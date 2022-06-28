import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:luxpay/views/refer&earn/invitecode.dart';
import 'package:luxpay/views/refer&earn/referrer_earning.dart';

import '../../utils/hexcolor.dart';

class InviteAndEarn extends StatefulWidget {
  const InviteAndEarn({Key? key}) : super(key: key);

  @override
  State<InviteAndEarn> createState() => _InviteAndEarnState();
}

class _InviteAndEarnState extends State<InviteAndEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Refer and Earn",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => {Navigator.maybePop(context)},
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height + 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                color: Colors.white,
                child: Stack(children: [
                  Center(
                    child: Image.asset(
                      "assets/package.png",
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(left: 60),
                      child: Image.asset(
                        "assets/coins.png",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 80, bottom: 140),
                      child: Image.asset(
                        "assets/star.png",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 60, top: 90, left: 20),
                      child: Image.asset(
                        "assets/star.png",
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 60, top: 50, right: 10),
                      child: Image.asset(
                        "assets/star.png",
                      ),
                    ),
                  ),
                ]),
              ),
              Text(
                "  Earn Tasks Referral Commission Get 10% Commission",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Invite a friend and get a 10% commission on every successful sign-up on Crowd365 with your referral code.\nYou also enjoy cash rewards once they join or subscribe.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(),
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Text("LuxPay")),
                      Container(
                          height: 80,
                          width: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor("#D70A0A"),
                          ),
                          child: IconButton(
                              onPressed: () {
                                print("copied");
                                Fluttertoast.showToast(
                                  msg: "Luxpay",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity
                                      .BOTTOM, // also possible "TOP" and "CENTER"
                                  backgroundColor: HexColor("#415CA0"),
                                );
                                Clipboard.setData(
                                    ClipboardData(text: "Luxpay"));
                              },
                              icon: Icon(Icons.copy, color: Colors.white)))
                    ],
                  ),
                ),
              ),
              Container(
                  width: 120,
                  margin: EdgeInsets.only(
                    left: 30,
                    top: 15,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/sharered.png",
                        ),
                        Image.asset(
                          "assets/facebook.png",
                        ),
                        Image.asset(
                          "assets/tweeter.png",
                        ),
                        Image.asset(
                          "assets/ig.png",
                        )
                      ])),
              SizedBox(height: 20),
              Container(
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InvitationCode()));
                            },
                            child: Container(
                              height: 50,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: HexColor("#D70A0A"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text("Share",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18))),
                            ),
                          ),
                          SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReferrerEarning()));
                            },
                            child: Container(
                              height: 50,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: HexColor("#D70A0A"),
                                  ),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text("View Earnings",
                                      style: TextStyle(
                                          color: HexColor("#D70A0A"),
                                          fontSize: 18))),
                            ),
                          ),
                        ],
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
}
