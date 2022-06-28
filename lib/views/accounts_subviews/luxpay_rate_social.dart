import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import '../../utils/colors.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';

class LuxPaySocial extends StatefulWidget {
  const LuxPaySocial({Key? key}) : super(key: key);

  @override
  State<LuxPaySocial> createState() => _LuxPaySocialState();
}

class _LuxPaySocialState extends State<LuxPaySocial> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 80,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 2,
                    ),
                    const Text(
                      "LuxPay Socials",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Rate us",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                        "LuxPay is concerned about the rating of every customer, and we are always ready to respnd quickly to every review"),
                    SizedBox(height: 50),
                    luxButton(
                        HexColor("#D70A0A"), Colors.white, "Rate Us", width,
                        fontSize: 16),
                    SizedBox(height: 50),
                    Text(
                      "Join the Community",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Text(
                        "Follow us on Socials media, let's know what you think"),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          socaialButton("FaceBook", () {}),
                          SizedBox(
                            width: 40,
                          ),
                          socaialButton("Instagram", () {})
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          socaialButton("Telegram", () {}),
                          SizedBox(
                            width: 40,
                          ),
                          socaialButton("Twitter", () {})
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }

  Widget socaialButton(account, onTap) {
    VoidCallback? onTap;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: grey2,
              blurRadius: 5.0,
              spreadRadius: 3.0,
              offset: Offset(
                0.0,
                1.0,
              ),
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: Center(child: Text(account)),
        ),
      ),
    );
  }
}
