import 'package:flutter/material.dart';
import 'package:luxpay/widgets/settings_item.dart';

import '../../utils/sizeConfig.dart';

class PaymentSettings extends StatefulWidget {
  const PaymentSettings({Key? key}) : super(key: key);

  @override
  State<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                          "Payment Settings",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 90),
                    child: SettingsItemToggle(
                      title: "Pay without Pin",
                    ),
                  ))
            ],
          ),
        ));
  }
}
