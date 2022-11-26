import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

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
                              color: status == 'FAILED'
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 10,
                              fontWeight: FontWeight.bold)),
                      // Text("$type",
                      //     style: TextStyle(
                      //       color:type == 'DEBIT' ? red2 : green4,
                      //       fontSize: 10,
                      //     )),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: type == 'DEBIT'
                            ? Text(
                                "-N${amount.replaceAllMapped(reg, mathFunc)}",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600),
                              )
                            : Text(
                                "N${amount.replaceAllMapped(reg, mathFunc)}",
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

class KYCCard extends StatelessWidget {
  final String phone, status;
  final String date;
  final VoidCallback? onTap;
  KYCCard(
      {Key? key,
      required this.date,
      this.onTap,
      required this.phone,
      required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(4, 3), // changes position of shadow
              )
            ]),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  //top: 15,
                  left: 15,
                  right: 15,
                  // bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                IconlyLight.addUser,
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                left: 70,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text(
                                    phone,
                                    style:
                                        TextStyle(fontSize: 13, color: black),
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
                          Container(
                            child: Text(
                              "status",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text("$status",
                              style: TextStyle(
                                  color: status == 'FAILED'
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// how to add shadow in flutter container?

