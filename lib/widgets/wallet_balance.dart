import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:luxpay/utils/colors.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/payment_page.dart';

class WalletBalance extends StatelessWidget {
  WalletBalance({Key? key, required this.balance, required this.currency})
      : super(key: key);
  String? balance, currency;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
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
                          SizedBox(width: 3),
                          Text(
                            balance!,
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
                        color: HexColor("#144DDE"),
                        size: 20,
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 0.7,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PaymentWidget()));
                        },
                        child: Text(
                          "Top up",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: HexColor("#144DDE")),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.safeBlockVertical! * 2,
              ),
              Row(
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
                      const Text(
                        "N 0",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
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
                      const Text(
                        "N 0",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
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
