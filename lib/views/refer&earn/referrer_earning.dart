import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class ReferrerEarning extends StatefulWidget {
  const ReferrerEarning({Key? key}) : super(key: key);

  @override
  State<ReferrerEarning> createState() => _ReferrerEarningState();
}

class _ReferrerEarningState extends State<ReferrerEarning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Referral Earnings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () => {Navigator.maybePop(context)},
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 490,
                width: double.infinity,
                color: grey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    earningStatus("EARNINGS THIS WEEK", "NGN10"),
                    earningStatus("TOTAL EARNINGS", "NGN10"),
                    earningStatus("Signups", "0"),
                    earningStatus("Signups that subscribe", "0"),
                    earningStatus("No Of Referrals", "0"),
                    earningStatus("Next Payout Date", "June 29,2022"),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Payout history",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: Stack(children: [
                  Center(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Image.asset('assets/coolicon.png'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Nothing to see here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "You haven’t made any transactions yet, all transactions will show up here",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget earningStatus(status, value) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            status,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 7),
          Text(value)
        ],
      ),
    );
  }
}
