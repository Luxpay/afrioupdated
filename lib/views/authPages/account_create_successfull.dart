import 'package:flutter/material.dart';
import 'package:luxpay/views/authPages/login_page.dart';

import '../../utils/hexcolor.dart';
import '../../widgets/lux_buttons.dart';

class AccountCreateSuccefful extends StatefulWidget {
  const AccountCreateSuccefful({Key? key}) : super(key: key);

  @override
  State<AccountCreateSuccefful> createState() => _AccountCreateSucceffulState();
}

class _AccountCreateSucceffulState extends State<AccountCreateSuccefful> {
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
            Text("Successful!!!",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    child: Text(
                        "Congratulations, your Phone number has been verified successfully. Please log into your account to complete your profile",
                        style: TextStyle(color: Colors.grey))),
              ],
            )),
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
