import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import '../utils/constants.dart';
import '../views/paymentMethod/payment_method.dart';


class WalletBalance extends StatelessWidget {
  WalletBalance(
      {Key? key,
      required this.balance,
      required this.currency,
      required this.dIncome,
      required this.dExpense})
      : super(key: key);
  final String? balance, currency, dIncome, dExpense;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Card(
        //color: red1,
        child: Padding(
          padding: const EdgeInsets.only(left: 21.0, top: 23, right: 21),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Wallet Balance",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 0.7,
                      ),
                      Row(
                        children: [
                          Text(
                            currency!,
                            style: TextStyle(
                                color: HexColor("#22B02E"),
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          Text(
                            balance!.replaceAllMapped(reg, mathFunc),
                            style: TextStyle(
                                color: HexColor("#22B02E"),
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        IconlyBold.wallet,
                        color: Color.fromARGB(255, 114, 13, 6),
                        size: 20,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 0.7,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentMethod()));

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             FlutterPaymentSdk('Top Up')));
                        },
                        child: Text(
                          "Add Money",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 114, 13, 6)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              Container(
                // color: Colors.amber,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Today’s Income",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#8D9091")),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 0.7,
                        ),
                        Text(
                          "N${dIncome!.replaceAllMapped(reg, mathFunc)}",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.grey,
                      thickness: 1, //thickness of divier line
                    ),
                    Column(
                      children: [
                        Text(
                          "Today’s Expenses",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: HexColor("#8D9091")),
                        ),
                        SizedBox(
                          height: SizeConfig.safeBlockVertical! * 0.7,
                        ),
                        Text(
                          "N${dExpense!.replaceAllMapped(reg, mathFunc)}",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
