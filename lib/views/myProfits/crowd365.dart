import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/myProfits/crow365_referral.dart';
import 'package:luxpay/views/myProfits/crowd365_packages.dart';
import 'package:luxpay/views/myProfits/profit_rules.dart';

import '../../widgets/lux_buttons.dart';

class Crowd365 extends StatefulWidget {
  const Crowd365({Key? key}) : super(key: key);

  @override
  _Crowd365State createState() => _Crowd365State();
}

class _Crowd365State extends State<Crowd365> {
  List<String> list = [
    "The My Profit system offers three packages with different incentives and registration fees.",
    "Your invitees can only subscribe to your package; i.e., the Starter package accepts only Starter package referees.",
    "The My Profit system is a short-term campaign that requires only two-level, i.e., six partners. "
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: HexColor("#415CA0"),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: HexColor("#415CA0"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => {Navigator.pop(context)},
                            icon: const Icon(Icons.arrow_back_ios_new),
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal! * 2.4,
                          ),
                          const Text(
                            "Crowd365",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfitRules()))
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 34.0),
                          child: Row(
                            children: [
                              Image.asset("assets/rules-question.png"),
                              SizedBox(
                                width: SizeConfig.safeBlockHorizontal! * 2.4,
                              ),
                              const Text(
                                "Rules",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        myProfit(),
                        Container(
                          color: Colors.white,
                          child: howToEarn(),
                        ),
                        Container(
                          color: Colors.white,
                          height: SizeConfig.safeBlockVertical! * 12.5,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              // top: SizeConfig.safeBlockVertical! * 100,
              right: 0,
              left: 0,
              bottom: MediaQuery.of(context).padding.bottom + 25,
              child: Container(
                // width: MediaQuery.of(context).size.width,
                // height: 72,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                      onTap: () => {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => const AppPageController()))
                            // Navigator.of(context)
                            //     .pushNamed(Crowd365Packages.path)
                            _crow365RefereBottomSheet(context)
                          },
                      child: luxButton(
                          HexColor("#415CA0"), Colors.white, "Apply now", 325,
                          fontSize: 16, height: 50, radius: 8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myProfit() {
    return Container(
      color: HexColor("#415CA0"),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 3.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          text: "Exclusive offers for ",
                        ),
                        TextSpan(
                          text: "Crowd 365 ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        TextSpan(
                          text: "Earners",
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  Text(
                    "Get a chance to cash out as much as N50,000 on the Crowd365 Structure.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Image.asset(
                    "assets/money-profit.png",
                    width: 187,
                    height: 142.07,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget howToEarn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Text(
                    "HOW TO EARN ?",
                    style: TextStyle(
                        color: HexColor("#415CA0"),
                        fontWeight: FontWeight.w700,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 86,
                        height: 110,
                        child: Column(
                          children: [
                            Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: HexColor("#415CA0"),
                                    borderRadius: BorderRadius.circular(42)),
                                child: Image.asset(
                                  "assets/profits/share-link-with-friends.png",
                                  height: 45,
                                  width: 45,
                                  scale: 2,
                                )),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Share link with friends",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor("#1B2124"),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        height: 110,
                        child: Column(
                          children: [
                            Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: HexColor("#415CA0"),
                                    borderRadius: BorderRadius.circular(42)),
                                child: Image.asset(
                                    "assets/profits/invitee-accept.png",
                                    height: 45,
                                    width: 45,
                                    scale: 2)),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Invitees accept & register",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor("#1B2124"),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: HexColor("#415CA0"),
                                    borderRadius: BorderRadius.circular(42)),
                                child: Image.asset(
                                  "assets/profits/completes-taks.png",
                                  height: 18.67,
                                  width: 23.33,
                                  scale: 2,
                                )),
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              "Invitees completes tasks",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor("#1B2124"),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  Row(
                    children: [
                      Text(
                        "Referral Code: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 3,
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "6903803215",
                            style: TextStyle(
                              fontSize: 13,
                              color: HexColor("#8D9091"),
                            ),
                          ),
                          height: 30,
                          decoration: BoxDecoration(
                            color: HexColor("#ECECEC"),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: double.infinity,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal! * 3,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Copy",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                        height: 30,
                        decoration: BoxDecoration(
                          color: HexColor("#415CA0"),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: SizeConfig.blockSizeHorizontal! * 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 2,
                  ),
                  ListView.builder(
                    // scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 18),
                    itemCount: list.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext ctxt, int index) {
                      return myProfitListItemCard(list[index], context, index);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myProfitListItemCard(String s, BuildContext context, int index) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: HexColor("#415CA0").withOpacity(.05),
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(19.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.asset(
                    "assets/profits/token-1.png",
                    height: 16,
                    width: 16,
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Expanded(
                  child: Text(
                    s,
                    style: TextStyle(
                        height: 2.1,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0,
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15,
        )
      ],
    );
  }
}

void _crow365RefereBottomSheet(context) {
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
        return Crowd365Refere();
      });
}
