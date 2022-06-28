import 'package:flutter/material.dart';

import 'invite_earn.dart';

class PaymentSuccessfull extends StatefulWidget {
  const PaymentSuccessfull({Key? key}) : super(key: key);

  @override
  State<PaymentSuccessfull> createState() => _PaymentSuccessfullState();
}

class _PaymentSuccessfullState extends State<PaymentSuccessfull> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Successfull!!!", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InviteAndEarn()));
              },
              child: Text("Payment Complete", style: TextStyle(fontSize: 13)))
        ],
      ),
    ));
  }
}
