import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

class RaiseFunds extends StatefulWidget {
  const RaiseFunds({Key? key}) : super(key: key);

  @override
  _RaiseFundsState createState() => _RaiseFundsState();
}

class _RaiseFundsState extends State<RaiseFunds> {
  TextEditingController referralCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // final double width = MediaQuery.of(context).size.width;
    // final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 2.4,
                  ),
                  const Text(
                    "Raise Funds",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 1.9,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  backGroundRaiseFunds(),
                  Positioned(
                      top: 23,
                      right: 24,
                      child: luxButton(
                          Colors.white, HexColor("#D70A0A"), "Rules", 95,
                          height: 25, fontSize: 13)),
                  Positioned(
                      top: 196,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white),
                            color: Colors.pink),
                      )),
                  Positioned(top: 208, right: 0, left: 0, child: howToEarn()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget backGroundRaiseFunds() {
    return Stack(
      children: [
        Container(
          color: HexColor("#771313"),
          height: 242,
        ),
        Image.asset("assets/raise-funds1.png"),
      ],
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
                        color: HexColor("#771313"),
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
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/share.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Share link or referral code",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/signup-raise-funds.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Sign up with referral code",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/gift.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Claim rewards",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Text(
                    "If your friend is already a Luxpay user, you can send them the referral code directly or just share them the link ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HexColor("#8D9091"), fontSize: 13),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Referral code : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor("#1E1E1E"),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      luxButton(HexColor("#D70A0A"), Colors.white, "Copy", 95,
                          height: 25, fontSize: 13)
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
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
                        color: HexColor("#771313"),
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
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/share.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Share link or referral code",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/signup-raise-funds.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Sign up with referral code",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/gift.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Claim rewards",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Text(
                    "If your friend is already a Luxpay user, you can send them the referral code directly or just share them the link ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HexColor("#8D9091"), fontSize: 13),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Referral code : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor("#1E1E1E"),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      luxButton(HexColor("#D70A0A"), Colors.white, "Copy", 95,
                          height: 25, fontSize: 13)
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
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
                        color: HexColor("#771313"),
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
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/share.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Share link or referral code",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/signup-raise-funds.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Sign up with referral code",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 86,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/gift.png",
                              height: 45,
                              width: 45,
                            ),
                            Text(
                              "Claim rewards",
                              style: TextStyle(
                                  color: HexColor("#771313"),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Text(
                    "If your friend is already a Luxpay user, you can send them the referral code directly or just share them the link ",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: HexColor("#8D9091"), fontSize: 13),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Referral code : ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexColor("#1E1E1E"),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      luxButton(HexColor("#D70A0A"), Colors.white, "Copy", 95,
                          height: 25, fontSize: 13)
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical! * 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget myOffice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0),
      child: Container(
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
                    color: HexColor("#771313"),
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
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/share.png",
                          height: 45,
                          width: 45,
                        ),
                        Text(
                          "Share link or referral code",
                          style: TextStyle(
                              color: HexColor("#771313"),
                              fontWeight: FontWeight.w700,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 86,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/signup-raise-funds.png",
                          height: 45,
                          width: 45,
                        ),
                        Text(
                          "Sign up with referral code",
                          style: TextStyle(
                              color: HexColor("#771313"),
                              fontWeight: FontWeight.w700,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 86,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/gift.png",
                          height: 45,
                          width: 45,
                        ),
                        Text(
                          "Claim rewards",
                          style: TextStyle(
                              color: HexColor("#771313"),
                              fontWeight: FontWeight.w700,
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 3,
              ),
              Text(
                "If your friend is already a Luxpay user, you can send them the referral code directly or just share them the link ",
                textAlign: TextAlign.center,
                style: TextStyle(color: HexColor("#8D9091"), fontSize: 13),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Referral code : ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HexColor("#1E1E1E"),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  luxButton(HexColor("#D70A0A"), Colors.white, "Copy", 95,
                      height: 25, fontSize: 13)
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
