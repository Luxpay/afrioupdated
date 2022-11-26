import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luxpay/views/page_controller.dart';
import '../../utils/colors.dart';

class TopUpCongratulation extends StatefulWidget {
  final String? amount, from, to, status, fee;
  final DateTime? date;
  const TopUpCongratulation(
      {Key? key,
      required this.amount,
      required this.from,
      required this.to,
      required this.fee,
      required this.status,
      required this.date})
      : super(key: key);

  @override
  State<TopUpCongratulation> createState() => _TopUpCongratulationState();
}

class _TopUpCongratulationState extends State<TopUpCongratulation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppPageController()));
                            },
                            icon: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.black)),
                        Text(
                          "Transaction Status",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () => {Navigator.maybePop(context)},
                            icon: const Icon(Icons.library_books,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 110),
                    height: 900,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              //Navigator.push(context,MaterialPageRoute(builder: (context)=> CreateNewPassword()));
                            },
                            child: Image.asset(
                              "assets/successIcon.png",
                              scale: 2,
                            )),
                        SizedBox(height: 30),
                        Text("Your Transaction is ${widget.status}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.green)),
                        SizedBox(height: 5),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: Text(
                                      "  Your Transaction is been process you will get a notification once its successfull or failed\n Summary of transaction are included below",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey))),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        const Divider(
                          indent: 20,
                          endIndent: 20,
                          color: Colors.black,
                        ),
                        SizedBox(height: 6),
                        Text(" Luxpay",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                        transactionStatus(
                            amount: "N${widget.amount}",
                            from: "${widget.from}",
                            to: "${widget.to}",
                            date: widget.date,
                            fee: "${widget.fee ?? 'N/A'} "),
                        SizedBox(height: 10),
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => AppPageController()));
                        //   },
                        //   child: luxButton(
                        //       HexColor("#D70A0A"), Colors.white, "Done", 70),
                        // ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }

  Widget transactionStatus({amount, from, to, date, fee}) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL AMOUNT SEND',
                ),
                SizedBox(height: 7),
                Text(
                  '$amount',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FROM',
                ),
                SizedBox(height: 7),
                Text(
                  '$from',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TO',
                ),
                SizedBox(height: 7),
                Text(
                  '$to',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TRANSACTION DATE',
                ),
                SizedBox(height: 7),
                Text("${DateFormat('MMMd kk:mm').format(date)}")
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FEE',
                ),
                SizedBox(height: 7),
                Text(
                  '$fee',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
