import 'package:flutter/material.dart';
import 'package:luxpay/views/refer&earn/invite_earn.dart';

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
          Text("Payment Complete", style: TextStyle(fontSize: 13)),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InviteAndEarn()));
              },
              child: Text("CLick here",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    ));
  }
}
