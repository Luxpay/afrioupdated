import 'package:flutter/material.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../utils/colors.dart';

class LuxTag extends StatefulWidget {
  const LuxTag({Key? key}) : super(key: key);

  @override
  State<LuxTag> createState() => _LuxTagState();
}

class _LuxTagState extends State<LuxTag> {
  @override
  Widget build(BuildContext context) {
    return Padding(
     padding: MediaQuery.of(context).viewInsets,
      child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: 6,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: grey4,
                        ),
                        margin: const EdgeInsets.only(top: 10)),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: CircleButton(
                              onTap: () => Navigator.pop(context),
                              iconData: Icons.close))),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: 30, top: 40),
                          child: Text(
                            "What is a LuxTag ?",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ))),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          margin: EdgeInsets.only(left: 30, top: 100, right: 30),
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                      "A Luxpay Tag is a unique name you can use to send money to your friends and family without any hassle or the use of account details ",
                                      style: TextStyle(fontSize: 19)),
                                ),
                              ],
                            ),
                          ))),
                ],
              )
            ],
          )),
    );
  }
}
