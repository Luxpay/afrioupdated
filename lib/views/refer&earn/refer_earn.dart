import 'package:flutter/material.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/views/refer&earn/refer&earn_payment.dart';

import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';
import '../../widgets/lux_textfield.dart';
import '../../widgets/touchUp.dart';

class Membership extends StatefulWidget {
  const Membership({Key? key}) : super(key: key);

  @override
  State<Membership> createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {
  var controllerMember = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        height: 370,
        width: double.infinity,
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
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: Text(
                        "Have a referral code ?",
                        style: TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: EdgeInsets.only(right: 20, top: 30),
                        child: CircleButton(
                            onTap: () => Navigator.pop(context),
                            iconData: Icons.close))),
                Container(
                  margin: EdgeInsets.only(top: 100, right: 40, left: 40),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          LuxTextField(
                            hint: "Enter Invitation tag Here",
                            controller: controllerMember,
                            innerHint: "Invitation tag here",
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ReferEarnPaymentMethod()));
                            },
                            child: luxButton(HexColor("#D70A0A"), Colors.white,
                                "Membership fee N1,000", 325,
                                fontSize: 16, height: 50, radius: 8),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "BECOME A MEMEBER  NOW AND START EARNING ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: HexColor("#D70A0A"),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
