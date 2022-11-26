import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/accounts_subviews/about_luxpay.dart';
import 'package:luxpay/widgets/settings_item.dart';

import '../../widgets/navigate_route.dart';
import 'change_luxpayPin.dart';

class SettingsPage extends StatelessWidget {
  static const String path = "/settings";
  const SettingsPage({Key? key}) : super(key: key);

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
                      width: SizeConfig.safeBlockHorizontal! * 2,
                    ),
                    const Text(
                      "Settings",
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
                      thickness: 3,
                    ),
                    SettingsItem(
                      title: "LuxPay Pin",
                      onTap: () {
                        Navigator.push(
                            context, SizeTransition4(ChangeLuxpayPin()));
                      },
                    ),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 3,
                    ),
                    // SettingsItem(
                    //   title: "Payment Settings",
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => PaymentSettings()));
                    //   },
                    // ),
                    // Divider(
                    //   color: HexColor("#FBFBFB"),
                    //   thickness: 3,
                    // ),
                    // SettingsItem(
                    //   title: "Unlock Settings",
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => UnlockSettings()));
                    //   },
                    // ),
                    // Divider(
                    //   color: HexColor("#FBFBFB"),
                    //   thickness: 3,
                    // ),
                    // SettingsItem(
                    //   title: "Biometric Authentication",
                    //   onTap: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => BioAuth()));
                    //   },
                    // ),
                    // Divider(
                    //   color: HexColor("#FBFBFB"),
                    //   thickness: 3,
                    // ),
                    // SettingsItemToggle(
                    //   title: "Notification",
                    // ),
                    // Divider(
                    //   color: HexColor("#FBFBFB"),
                    //   thickness: 3,
                    // ),
                    SettingsItem(
                        title: "About LuxPay",
                        onTap: () {
                          Navigator.push(
                              context, SizeTransition4(AboutLuxPay()));
                        }),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: HexColor("#FBFBFB"),
                      ),
                    )
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
