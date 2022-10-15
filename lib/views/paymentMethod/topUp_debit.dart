import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/widgets/lux_textfield.dart';

import '../../utils/sizeConfig.dart';
import '../../widgets/lux_buttons.dart';
import 'addDebit_card.dart';

class TopUpViaDebit extends StatefulWidget {
  const TopUpViaDebit({Key? key}) : super(key: key);

  @override
  State<TopUpViaDebit> createState() => _TopUpViaDebitState();
}

class _TopUpViaDebitState extends State<TopUpViaDebit> {
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
                  height: 60,
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
                          "Top up via Debit Card",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(top: 90, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How much would you be depositing?",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 35),
                      LuxTextField(
                        hint: "Enter Amount ",
                        innerHint: "N5,000",
                        //controller: luxpayAmountController,
                        onChanged: (v) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 10),
                      Text(
                        " 🎉 Get up to N350 everytime you fund your wallet",
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(height: 60),
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddDebitCard()));
                          },
                      child: luxButton(
                            HexColor("#D70A0A").withOpacity(
                              0.5,
                            ),
                            HexColor("#FFFFFF"),
                            "Continue",
                            double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
