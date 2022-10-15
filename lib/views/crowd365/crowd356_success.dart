import 'package:flutter/material.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

import '../../utils/hexcolor.dart';
import 'crowd365_dashboard.dart';

class Crowd365SuccessfullSub extends StatefulWidget {
  const Crowd365SuccessfullSub({Key? key}) : super(key: key);

  @override
  State<Crowd365SuccessfullSub> createState() => _Crowd365SuccessfullSubState();
}

class _Crowd365SuccessfullSubState extends State<Crowd365SuccessfullSub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  //Navigator.push(context,MaterialPageRoute(builder: (context)=> CreateNewPassword()));
                },
                child: Image.asset(
                  "assets/successIcon.png",
                  scale: 3,
                )),
            Text("Transaction Complete",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text("Your Subscribtion was successful ",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey))),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Crowd365Dashboard()));
              },
              child: luxButton(
                  HexColor("#415CA0"), Colors.white, "Open Dashboard", 350),
            ),
          ],
        )));
  }
}
