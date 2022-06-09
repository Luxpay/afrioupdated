import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/views/authPages/login_page.dart';
import 'package:luxpay/widgets/lux_buttons.dart';

class PasswordChangeCongratulation extends StatefulWidget {
  const PasswordChangeCongratulation({Key? key}) : super(key: key);

  @override
  State<PasswordChangeCongratulation> createState() =>
      _PasswordChangeCongratulationState();
}

class _PasswordChangeCongratulationState
    extends State<PasswordChangeCongratulation> {
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
            Text("Password reset complete",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: Text("Log in to your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey))),
                ],
              ),
            ),
            SizedBox(height: 50),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child:
                  luxButton(HexColor("#D70A0A"), Colors.white, "Log in", 350),
            ),
          ],
        )));
  }
}
