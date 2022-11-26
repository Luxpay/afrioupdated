import 'package:flutter/material.dart';
import 'package:luxpay/podos/banks.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class TransferInstructions extends StatelessWidget {
  final Bank bank;
  const TransferInstructions({Key? key, required this.bank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: HexColor("#C10505"),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.white,
                    ),
                  ],
                ),
                Image.asset(
                  "${bank.img}",
                  height: 73.8,
                  width: 123,
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1.9,
                ),
              ],
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                    margin: EdgeInsets.only(top: 200),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Container(
                        margin: EdgeInsets.only(top: 30, right: 30, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${bank.name}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                " 1.   Login to your ${bank.name} Mobile Application "),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                " 2.    Click ‘’ Transfer “ on menu dashboard  "),
                            SizedBox(
                              height: 20,
                            ),
                            Text(" 3.   Choose Transfer type "),
                            SizedBox(
                              height: 20,
                            ),
                            Text(" 4.   Select ‘’ Sterling Bank “  "),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              ' 5.    Input your Luxpay account no e.g 0795093009',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                                " 6.    Confirm name and input PIN to confirm payment")
                          ],
                        ),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
