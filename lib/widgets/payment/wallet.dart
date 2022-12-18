import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

import '../../utils/constants.dart';

class WalletLuxpay extends StatelessWidget {
  final String? balance;
  WalletLuxpay({
    Key? key,
    required this.balance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: HexColor("#D70A0A"),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(20)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 1,
            ),
            const Text(
              "Available Balance",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 0.3,
            ),
            Flexible(
              child: Text(
                "N${balance!.replaceAllMapped(reg, mathFunc)}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Montserrat",
                    fontSize: 23),
              ),
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "LuxPay",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
                // Text("7010589059",
                //     style: TextStyle(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 13))
              ],
            ),
            SizedBox(
              height: SizeConfig.safeBlockVertical! * 2,
            ),
          ],
        ),
      ),
    );
  }
}
