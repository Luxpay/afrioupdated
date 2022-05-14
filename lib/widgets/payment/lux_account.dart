import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/utils/toaster.dart';

class LuxAccount extends StatelessWidget {
  const LuxAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: HexColor("#FBFBFB"),
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
          Text(
            "Your LuxPay account is :",
            style: TextStyle(
              fontSize: 13,
              color: HexColor("#8D9091"),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("7010589059",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: InkWell(
                    onTap: () => {
                          Clipboard.setData(ClipboardData(text: "7010589059")),
                          LuxToast.show(msg: "Copied")
                        },
                    child: Image.asset(
                      "assets/paymentMethod/copy.png",
                      width: 22.97,
                      height: 26,
                    )),
              )
            ],
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 1.4,
          ),
          Text(
            "Select WEMA as Bank ",
            style: TextStyle(color: HexColor("#8D9091"), fontSize: 13),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical! * 2,
          ),
        ],
      ),
    );
  }
}
