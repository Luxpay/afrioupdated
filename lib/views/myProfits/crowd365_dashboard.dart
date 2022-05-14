import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/myProfits/profit_rules.dart';

class Crowd365Dashboard extends StatefulWidget {
  static const String path = "crowd365Dashboard";
  const Crowd365Dashboard({Key? key}) : super(key: key);

  @override
  State<Crowd365Dashboard> createState() => _Crowd365DashboardState();
}

class _Crowd365DashboardState extends State<Crowd365Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfitRules()))
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 34.0),
                    child: Text(
                      "Rules",
                      style: TextStyle(
                          fontSize: 13,
                          color: HexColor("#8D9091"),
                          fontWeight: FontWeight.w600),
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
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: earnings("Today’s Earning", "0"),
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
                              child: earnings("Total Earning", "0"),
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
                          statusCircles("0", "Direct Ref"),
                          statusCircles("0", "Indirect Ref"),
                          statusCircles("0", "Cycles"),
                          statusCircles("0", "Ref Left"),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          button(title: "Cash out", hexColor: "#415CA0"),
                          button(
                              title: "Renew",
                              hexColor: "#415CA0",
                              active: false),
                          button(title: "Upgrade", hexColor: "#22B02E"),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical! * 5,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: HexColor("#FBFBFB"),
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
                                Container(
                                  alignment: Alignment.center,
                                  width: SizeConfig.blockSizeHorizontal! * 40,
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
      ),
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
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
            color: HexColor("#E8E8E8").withOpacity(0.35),
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
            "N$amount",
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
}
