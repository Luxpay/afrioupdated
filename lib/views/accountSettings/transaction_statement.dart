import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/sizeConfig.dart';

class TransactionStatement extends StatefulWidget {
  const TransactionStatement({Key? key}) : super(key: key);

  @override
  State<TransactionStatement> createState() => _TransactionStatementState();
}

class _TransactionStatementState extends State<TransactionStatement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => {Navigator.maybePop(context)},
                      icon: const Icon(Icons.arrow_back_ios_new)),
                  SizedBox(
                    width: SizeConfig.safeBlockHorizontal! * 2,
                  ),
                  const Text(
                    "Transactions Statement",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 300,
              margin: EdgeInsets.only(top: 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.6), // border color
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      IconlyLight.document,
                      color: white,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Transaction Statement",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Strictly for personal reconciliation",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            )),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: EdgeInsets.only(top: 300),
            child: Container(
              height: 200,
              //color: Colors.white,
              child: Column(
                children: [
                  transactionDCard("Transaction Type", "All"),
                  SizedBox(height: 5),
                  transactionDCard("Duration",
                      cate(boderColor: grey9, cateName: "Current month")),
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }

  Widget transactionDCard(type, other) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Text(
                type,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
                child: other == "All"
                    ? Container(
                        margin: EdgeInsets.only(right: 40),
                        child: Text(
                          other,
                          style: TextStyle(fontSize: 16, color: grey7),
                        ),
                      )
                    : other)
          ],
        ),
      ),
    );
  }

  Widget cate({cateName, boderColor}) {
    return Container(
      height: 30,
      width: 110,
      margin: EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: boderColor),
          borderRadius: BorderRadius.circular(30),
          color: white),
      child: Center(
          child: Text(cateName, style: TextStyle(color: grey7, fontSize: 13))),
    );
  }
}
