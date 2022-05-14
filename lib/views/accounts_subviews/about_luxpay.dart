import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/accounts_subviews/terms_and_condition.dart';
import 'package:luxpay/widgets/settings_item.dart';

class AboutLuxPay extends StatelessWidget {
  static const String path = "/aboutLuxPay";
  const AboutLuxPay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    SizedBox(
                      width: SizeConfig.safeBlockHorizontal! * 5,
                    ),
                    const Text(
                      "About LuxPay",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical! * 3,
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/lp2.png"),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical! * 2,
                          ),
                          Text(
                            "LuxPay version 1.2",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor("#D70A0A"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    SettingsItem(title: "To Store"),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 4,
                    ),
                    SettingsItem(
                      title: "Terms and Conditions",
                      onTap: () => Navigator.of(context).pushNamed(
                        TermsAndConditions.path,
                      ),
                    ),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 4,
                    ),
                    SettingsItem(title: "Privacy Policy"),
                    Expanded(
                        child: Container(
                      color: HexColor("#FBFBFB"),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
