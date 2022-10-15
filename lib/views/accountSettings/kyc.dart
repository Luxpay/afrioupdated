import 'package:flutter/material.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/views/accountSettings/account_profile.dart';

import '../../utils/sizeConfig.dart';

class KYCPage extends StatefulWidget {
  const KYCPage({Key? key}) : super(key: key);

  @override
  State<KYCPage> createState() => _KYCPageState();
}

class _KYCPageState extends State<KYCPage> {
  @override
  Widget build(BuildContext context) {
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
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => {Navigator.maybePop(context)},
                        icon: const Icon(Icons.arrow_back_ios_new)),
                    const Text(
                      "KYC Levels",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  margin: EdgeInsets.only(top: 90),
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "KYC regulations are set by the Central Bank of Nigeria. KYC simply stands for “Know Your Customer”. The requirements are developed to prevent identity theft, financial fraud, money laundering and terrorist financing.",
                          style: TextStyle(color: grey10, fontSize: 15),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(
                          child: ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                    height: SizeConfig.blockSizeVertical! * 2,
                                  ),
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: kyc_card(),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}
