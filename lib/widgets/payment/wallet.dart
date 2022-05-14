import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class Wallet extends StatelessWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: HexColor("#FBFBFB"),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 3,
          ),
          const Text(
            "Wallet Balance",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.4,
          ),
          Text(
            "N 905,000 ",
            style: TextStyle(
                color: HexColor("#1E1E1E"),
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat",
                fontSize: 24),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LuxPay account is :",
                style: TextStyle(color: HexColor("#8D9091"), fontSize: 13),
              ),
              Text("7010589059",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 13))
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 3,
          ),
        ],
      ),
    );
  }
}
