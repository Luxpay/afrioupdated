import 'package:flutter/material.dart';
import '../utils/colors.dart';

class TransferHistoryCard extends StatelessWidget {
  final String amount, type, status;
  final String? channel;
  final String date;
  final VoidCallback? onTap;
  TransferHistoryCard(
      {Key? key,
      required this.amount,
      required this.type,
      required this.date,
      this.onTap,
      this.channel,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 15,
              left: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/transactionpay.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            left: 70,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  child: Text(
                                "Luxpay Transaction",
                                style: TextStyle(fontSize: 13, color: black),
                              )),
                              SizedBox(
                                height: 5,
                              ),
                              Text("$date")
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("$status",
                          style: TextStyle(
                              color: status.contains("F") ? red2 : green4,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                      Text("$type",
                          style: TextStyle(
                            color: red4,
                            fontSize: 10,
                          )),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: type == 'DEBIT'
                            ? Text(
                                "-N$amount",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              )
                            : Text(
                                "N$amount",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: black,
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
