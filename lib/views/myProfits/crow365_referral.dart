import 'package:flutter/material.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/myProfits/crowd365_packages.dart';
import 'package:luxpay/widgets/lux_textfield.dart';
import 'package:luxpay/widgets/touchUp.dart';

import '../../widgets/lux_buttons.dart';

class Crowd365Refere extends StatefulWidget {
  const Crowd365Refere({Key? key}) : super(key: key);

  @override
  State<Crowd365Refere> createState() => _Crowd365RefereState();
}

class _Crowd365RefereState extends State<Crowd365Refere> {
  TextEditingController controllerRefere = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 450,
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
              Container(
                margin: EdgeInsets.only(top: 60, right: 40, left: 40),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        LuxTextField(
                          hint: "Enter your referral code here",
                          controller: controllerRefere,
                          innerHint: "Enter card code name",
                        ),
                        SizedBox(height: 20),
                        luxButton(
                            HexColor("#415CA0"), Colors.white, "Continue", 325,
                            fontSize: 16, height: 50, radius: 8),
                        SizedBox(height: 30),
                        InkWell(
                          onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Crowd365Packages()))
                          },
                          child: Text(
                            "GET A NEW PACKAGE",
                            style: TextStyle(
                                color: HexColor("#415CA0"), fontSize: 16),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          )
        ],
      ),
    );
  }
}
