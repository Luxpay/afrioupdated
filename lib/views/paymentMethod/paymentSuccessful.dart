import 'package:flutter/material.dart';
import 'package:luxpay/views/page_controller.dart';

class SuccessfullPayment extends StatefulWidget {
  const SuccessfullPayment({Key? key}) : super(key: key);

  @override
  State<SuccessfullPayment> createState() => _SuccessfullPaymentState();
}

class _SuccessfullPaymentState extends State<SuccessfullPayment> {
  Future<bool> _willPopCallback() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AppPageController()));
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: _willPopCallback,
          child: Center(
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
              Text("Payment Process Completed",
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
                            "You have completed your Transaction Completly",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey))),
                  ],
                ),
              ),
              // SizedBox(height: 50),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => LoginPage()));
              //   },
              //   child:
              //       luxButton(HexColor("#D70A0A"), Colors.white, "Done", 150),
              // ),
            ],
          )),
        ));
  }
}
