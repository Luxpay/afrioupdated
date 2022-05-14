import 'package:flutter/material.dart';
import 'package:luxpay/utils/hexcolor.dart';
import 'package:luxpay/utils/sizeConfig.dart';
import 'package:luxpay/views/transfers/bank_transfer.dart';
import 'package:luxpay/views/transfers/wallet_transfer.dart';

class FinancesPage extends StatefulWidget {
  const FinancesPage({Key? key}) : super(key: key);

  @override
  _FinancesPageState createState() => _FinancesPageState();
}

class _FinancesPageState extends State<FinancesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.safeBlockHorizontal! * 6,
            bottom: SizeConfig.safeBlockVertical! * 8,
            top: MediaQuery.of(context).padding.top,
          ),
          child: const Text(
            "Transfer",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 5,
                  ),
                  child: Row(
                    children: [
                      TransferCard(
                        onTap: () {
                          Navigator.pushNamed(context, WalletTransfer.path);
                        },
                        color: "#339502",
                        title: "Transfer to \nLuxPay account",
                        image: "",
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2,
                      ),
                      TransferCard(
                        onTap: () {
                          Navigator.pushNamed(context, BankTransfer.path);
                        },
                        color: "#395185",
                        title: "Transfer to \nBank account",
                        image: "",
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 2,
                      ),
                      TransferCard(
                        onTap: () {},
                        color: "#FB9B0B",
                        title: "International \nTransfer",
                        image: "",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recent Transfer",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No transfer records",
                            style: TextStyle(
                              color: HexColor("#CCCCCC"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 10,
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: HexColor("#E8E8E8").withOpacity(0.35),
                  thickness: 12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.safeBlockHorizontal! * 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 4,
                      ),
                      Text(
                        "Recent Transfer",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No transfer records",
                            style: TextStyle(
                              color: HexColor("#CCCCCC"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.safeBlockVertical! * 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TransferCard extends StatelessWidget {
  final VoidCallback onTap;
  final String color;
  final String title;
  final String image;
  const TransferCard({
    Key? key,
    required this.onTap,
    required this.color,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: SizeConfig.blockSizeVertical! * 12,
          decoration: BoxDecoration(
            color: HexColor(color),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
