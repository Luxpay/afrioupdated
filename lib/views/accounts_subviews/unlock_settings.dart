import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:luxpay/views/accounts_subviews/payment_settings.dart';

import '../../utils/hexcolor.dart';
import '../../utils/sizeConfig.dart';
import '../../widgets/settings_item.dart';
import 'about_luxpay.dart';

class UnlockSettings extends StatefulWidget {
  const UnlockSettings({Key? key}) : super(key: key);

  @override
  State<UnlockSettings> createState() => _UnlockSettingsState();
}

class _UnlockSettingsState extends State<UnlockSettings> {
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
                margin: EdgeInsets.only(top: 20),
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
                      thickness: 3,
                    ),
                    UnlockItemToggle(
                      title: "Pin unlock",
                    ),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 3,
                    ),
                    UnlockItemToggle(
                      title: "Touch ID unlock",
                    ),
                    Divider(
                      color: HexColor("#FBFBFB"),
                      thickness: 3,
                    ),
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

class UnlockItemToggle extends StatefulWidget {
  final String title;
  final VoidCallback? onTap;
  const UnlockItemToggle({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  State<UnlockItemToggle> createState() => _UnlockItemToggle();
}

class _UnlockItemToggle extends State<UnlockItemToggle> {
  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    bool isSwitched = false;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 53,
        padding: EdgeInsets.symmetric(horizontal: 24),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(IconlyLight.lock),
                SizedBox(
                  width: 8,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#343434"),
                  ),
                ),
              ],
            ),
            Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    //storage.write(key: 'isSwitched', value: '$isSwitched');
                  });
                }),
          ],
        ),
      ),
    );
  }
}
