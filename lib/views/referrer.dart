import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/refer_earn.dart';

import '../utils/hexcolor.dart';
import '../widgets/lux_buttons.dart';

class ReferreAndEarn extends StatefulWidget {
  const ReferreAndEarn({Key? key}) : super(key: key);

  @override
  State<ReferreAndEarn> createState() => _ReferreAndEarnState();
}

class _ReferreAndEarnState extends State<ReferreAndEarn> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          height: MediaQuery.of(context).size.height,
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
                                  fontWeight: FontWeight.w900, fontSize: 20),
                            ),
                            SizedBox(height: 15),
                            Text(
                                "As a Member on LuxPay, you can earn two types of Referral Bonuses which include:",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 15)),
                            SizedBox(height: 13),
                            Text(
                              "Earn an Instant Referral Commission of N500:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " when you refer someone to become a memeber on LuxPay. The more You Refer, the moreyou earn.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              " For Example: If you refer an average of 20 users per day, you will 'N10,000' per day and 'N300,000' per month from just referral Bonuses alone.",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "  Earn Tasks Referral Commission Get 10% Commission",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "When you refer someone to join crowd365, any package",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "For example, if you refer 50 users to buy premium package worth N6000",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                            Text(
                              "you will earn N600 per user ",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  _referEarnBottomSheet(context);
                                },
                                child: luxButton(HexColor("#D70A0A"),
                                    Colors.white, "Continue", width,
                                    fontSize: 16),
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
