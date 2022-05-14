import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/accounts_subviews/about_luxpay.dart';
import 'package:luxpay/widgets/settings_item.dart';

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
                      width: SizeConfig.safeBlockHorizontal! * 5,
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
                      thickness: 8,
                    ),
                    SettingsItem(title: "LuxPay Pin"),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    SettingsItem(title: "Payment Settings"),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    SettingsItem(title: "Unlock Settings"),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    SettingsItem(title: "Biometric Authentication"),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    SettingsItem(
                      title: "LuxPay Pin",
                    ),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 8,
                    ),
                    SettingsItem(
                      title: "About LuxPay",
                      onTap: () =>
                          Navigator.of(context).pushNamed(AboutLuxPay.path),
                    ),
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
